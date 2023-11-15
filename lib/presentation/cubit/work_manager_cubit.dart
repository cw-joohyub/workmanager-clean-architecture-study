import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:workmanager_clean_architecture_sample/data/mapper/log_event_mapper.dart';

import '../../data/local_isar/dt_task.dart';
import '../../usecase/task_usecase.dart';

class LogEvent {
  String id;
  DateTime dateTime;
  EventType eventType;
  TaskStatus status;

  LogEvent(this.id, this.dateTime, this.eventType, this.status);
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
            task.eventType == eventType && task.taskStatus == TaskStatus.done)
        .length;
  }
}
