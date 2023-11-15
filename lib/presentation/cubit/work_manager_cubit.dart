import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:workmanager_clean_architecture_sample/data/mapper/log_event_mapper.dart';
import 'package:workmanager_clean_architecture_sample/data/work_manager/work_manager_plus.dart';
import 'package:workmanager_clean_architecture_sample/di/di.dart';

import '../../data/local_isar/dt_task.dart';
import '../../usecase/task_usecase.dart';

enum EventType {
  red,
  black,
}

class LogEvent {
  String id;
  DateTime dateTime;
  EventType eventType;
  TaskStatus status;

  LogEvent(this.id, this.dateTime, this.status, this.eventType);
}

class WorkManagerState {
  final int redCount;
  final int blackCount;
  final Map<String, List<LogEvent>> logEvents;

  WorkManagerState({
    this.redCount = 0,
    this.blackCount = 0,
    this.logEvents = const {},
  });

  WorkManagerState copyWith({
    int? redCount,
    int? blackCount,
    Map<String, List<LogEvent>>? logEvents,
  }) {
    return WorkManagerState(
      redCount: redCount ?? this.redCount,
      blackCount: blackCount ?? this.blackCount,
      logEvents: logEvents ?? this.logEvents,
    );
  }
}

@injectable
class WorkManagerCubit extends Cubit<WorkManagerState> {
  final TaskUseCase _taskUseCase;

  WorkManagerCubit(this._taskUseCase)
      : super(WorkManagerState(blackCount: 0, redCount: 0, logEvents: {}));

  Future<void> init() async {
    getIt<WorkManagerPlus>().notifyWorkManager();

    List<DtTask> taskList = await _taskUseCase.getTaskList() ?? [];
    emit(state.copyWith(
        redCount: taskList.getDoneTaskCount(EventType.red),
        blackCount: taskList.getDoneTaskCount(EventType.black),
        logEvents: taskList.toLogEvents()));

    final logStream = _taskUseCase.getTaskListStream();

    logStream.listen((List<DtTask> taskList) async {
      int redCount = taskList.getDoneTaskCount(EventType.red);
      int blackCount = taskList.getDoneTaskCount(EventType.black);

      Map<String, List<LogEvent>>? logEvents = taskList.toLogEvents();
      emit(state.copyWith(
          redCount: redCount, blackCount: blackCount, logEvents: logEvents));
    });
  }

  Future<void> plusOneNumber(EventType color) async {
    await _taskUseCase.plusOneNumber(color);
  }
}

extension on List<DtTask> {
  Map<String, List<LogEvent>> toLogEvents() {
    Map<String, List<LogEvent>> logEvents = {};
    map((e) => LogEventMapper().mapToLogEvent(e)).toList().forEach((element) {
      if (logEvents[element.id] == null) {
        logEvents[element.id] = [element];
      } else {
        logEvents[element.id]!.add(element);
      }
    });
    return logEvents;
  }

  int getDoneTaskCount(EventType eventType) {
    return where((DtTask task) =>
            task.taskType == eventType.name && task.taskStatus == TaskStatus.done)
        .length;
  }
}
