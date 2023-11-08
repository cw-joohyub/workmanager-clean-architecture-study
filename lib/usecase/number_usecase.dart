import 'package:injectable/injectable.dart';

import 'package:workmanager_clean_architecture_sample/presentation/cubit/work_manager_cubit.dart';

import '../data/repository/number_repository.dart';

abstract class NumberUsecase {
  Future<Stream<void>?> watchChange(String color);

  Future<Stream<void>?> watchLogChanged();

  Future<void> plusOneNumber(String color);

  LogEvent addLog(String taskName, int retryCount);

  Future<List<LogEvent>> getAllLog();

  Future<int> getLastNumber(String color);
}

@Injectable(as: NumberUsecase)
class NumberUsecaseImpl extends NumberUsecase {
  NumberUsecaseImpl(this._numberRepository);

  final NumberRepository _numberRepository;

  @override
  Future<Stream<void>?> watchChange(String color) => _numberRepository.watchChange(color);

  @override
  Future<void> plusOneNumber(String color) async {
    await _numberRepository.postPlusOne(color);
  }

  @override
  Future<Stream<void>?> watchLogChanged() => _numberRepository.watchLogChanged();

  @override
  LogEvent addLog(String taskName, int retryCount) {
    DateTime timeStamp = DateTime.now();
    print('NumberUsecaseImpl/addLog - $taskName, $timeStamp $retryCount');
    // _numberRepository.addLog(taskName, timeStamp, retryCount);

    return LogEvent(taskName, [timeStamp], retryCount + 1, EventType.red, true);
  }

  @override
  Future<List<LogEvent>> getAllLog() async {
    return await _numberRepository.getAllLog();
  }

  @override
  Future<int> getLastNumber(String color) async {
    return await _numberRepository.getLastNumber(color);
  }
}
