import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../usecase/number_usecase.dart';

enum EventType { red, black }

class LogEvent {
  String id;
  DateTime dateTime;

  // final List<DateTime> tryTimes;
  // int retry;
  EventType eventType;
  bool isSuccess;

  LogEvent(this.id, this.dateTime, this.eventType, this.isSuccess);

// LogEvent(this.id, this.tryTimes, this.retry, this.eventType, this.isSuccess);
}

class WorkManagerState {
  final int redCount;
  final int blackCount;
  final Map<String, LogEvent> logEvents;

  WorkManagerState({
    this.redCount = 0,
    this.blackCount = 0,
    this.logEvents = const {},
  });

  WorkManagerState copyWith({
    int? redCount,
    int? blackCount,
    Map<String, LogEvent>? logEvents,
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
      : super(WorkManagerState(blackCount: 0, redCount: 0, logEvents: {}));

  Future<void> init() async {
    // final redStream = await _numberUsecase.watchChange('red');
    // final blackStream = await _numberUsecase.watchChange('black');
    final logStream = await _numberUsecase.watchLogChanged();

    // redStream?.listen((event) async {
    //   int resultNumber = await _numberUsecase.getLastNumber('red');
    //   emit(state.copyWith(redCount: resultNumber));
    // });
    //
    // blackStream?.listen((event) async {
    //   int resultNumber = await _numberUsecase.getLastNumber('black');
    //   emit(state.copyWith(blackCount: resultNumber));
    // });

    logStream?.listen((event) async {
      Map<String, LogEvent> logEvents = {for (var e in await _numberUsecase.getAllLog()) e.id: e};

      int redCount = await _numberUsecase.getLastNumber('red');
      int blackCount = await _numberUsecase.getLastNumber('black');

      emit(state.copyWith(redCount: redCount, blackCount: blackCount, logEvents: logEvents));
    });
  }

  Future<void> plusOneNumber(String color) async {
    await _numberUsecase.plusOneNumber(color);
  }

// Future<void> plusOneNumberMock(String key, EventType color) async {
//   state.logEvents[key] = LogEvent(key, [DateTime.now()], 0, color, false);
//   emit(state.copyWith(
//     logEvents: state.logEvents,
//   ));
//
//   Future.microtask(() async {
//     bool isRetry = true;
//     while (isRetry) {
//       await Future.delayed(Duration(milliseconds: Random().nextInt(30)));
//       if (Random().nextInt(1000) < 2) {
//         isRetry = false;
//         state.logEvents[key]?.isSuccess = true;
//       } else {
//         state.logEvents[key]?.retry++;
//         emit(state.copyWith(logEvents: state.logEvents));
//       }
//     }
//
//     switch (color) {
//       case EventType.red:
//         emit(state.copyWith(
//           redCount: state.redCount + 1,
//         ));
//         break;
//       case EventType.black:
//         emit(state.copyWith(
//           blackCount: state.blackCount + 1,
//         ));
//         break;
//     }
//   });
// }
}
