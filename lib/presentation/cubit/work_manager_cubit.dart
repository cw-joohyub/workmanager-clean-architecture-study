import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../usecase/number_usecase.dart';

enum EventType { red, black }

class LogEvent {
  final DateTime time;
  final int retry;
  EventType eventType;
  bool isSuccess;

  LogEvent(this.time, this.retry, this.eventType, this.isSuccess);
}

class WorkManagerState {
  final int redCount;
  final int blackCount;
  final List<LogEvent> logEvents;

  WorkManagerState({
    this.redCount = 0,
    this.blackCount = 0,
    this.logEvents = const [],
  });

  WorkManagerState copyWith({
    int? redCount,
    int? blackCount,
    List<LogEvent>? logEvents,
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
  final NumberUsecase _numberUsecase;

  WorkManagerCubit(this._numberUsecase)
      : super(WorkManagerState(blackCount: 0, redCount: 0, logEvents: [
        ]));

  void plusOneNumber(String color) {
    _numberUsecase.plusOneNumber(color);
  }

  Future<void> plusOneNumberMock(EventType color) async {
    emit(state.copyWith(
      logEvents: [
        ...state.logEvents,
        LogEvent(DateTime.now(), 0, color, false),
      ],
    ));

    Future.microtask(() async {
      bool isRetry = true;
      while (isRetry) {
        await Future.delayed(Duration(milliseconds: Random().nextInt(3000)));
        if (Random().nextInt(100) < 2) { isRetry = false; }
      }

      switch (color) {
        case EventType.red:
          emit(state.copyWith(
            redCount: state.redCount + 1,
          ));
          break;
        case EventType.black:
          emit(state.copyWith(
            blackCount: state.blackCount + 1,
          ));
          break;
      }
    });
  }

  void addLog(String taskName) {}
}
