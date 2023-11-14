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
  bool isSuccess;

  LogEvent(this.id, this.dateTime, this.eventType, this.isSuccess);
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
    final logStream = _taskUseCase.watchLogChanged();

    logStream.listen((List<DtTask> taskList) async {
      int redCount = await _taskUseCase.getTaskCount(EventType.red);
      int blackCount = await _taskUseCase.getTaskCount(EventType.black);

      Map<String, List<LogEvent>>? logEvents = {};
      taskList.map((e) => LogEventMapper().mapToLogEvent(e)).toList().forEach((element) {
        logEvents[element.id] = [element];
      });

      emit(state.copyWith(
          redCount: redCount, blackCount: blackCount, logEvents: logEvents));
    });
  }

  Future<void> plusOneNumber(EventType color) async {
    await _taskUseCase.plusOneNumber(color);
  }

}
