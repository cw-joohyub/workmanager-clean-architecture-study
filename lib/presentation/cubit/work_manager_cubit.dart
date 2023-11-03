import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../usecase/black_usecase.dart';
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

  factory WorkManagerState.copyOf(WorkManagerState state) {
    return WorkManagerState(
      redCount: state.redCount,
      blackCount: state.blackCount,
      logEvents: state.logEvents,
    );
  }

  WorkManagerState copyWith({int? redCount,
    int? blackCount,
    List<LogEvent>? logEvents}) {
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
    LogEvent(DateTime.now(), 0, EventType.red, true),
    LogEvent(DateTime.now(), 1, EventType.black, false),
    LogEvent(DateTime.now(), 2, EventType.red, true),
    LogEvent(DateTime.now(), 3, EventType.black, false),
    LogEvent(DateTime.now(), 2, EventType.red, true),
    LogEvent(DateTime.now(), 0, EventType.red, true),
    LogEvent(DateTime.now(), 1, EventType.black, false),
    LogEvent(DateTime.now(), 2, EventType.red, true),
    LogEvent(DateTime.now(), 3, EventType.black, false),
    LogEvent(DateTime.now(), 2, EventType.red, true),
  ]));


  Future<void> init() async {
    final redStream = await _numberUsecase.watchChange('red');
    final blackStream = await _numberUsecase.watchChange('black');

    redStream?.listen((int number) {
      emit(state.copyWith(redCount: number));
    });

    blackStream?.listen((int number) {
      emit(state.copyWith(blackCount: number));
    });
  }

  void plusOneNumber(String color) {
    _numberUsecase.plusOneNumber(color);
  }

  void addLog(String taskName) {}
}
