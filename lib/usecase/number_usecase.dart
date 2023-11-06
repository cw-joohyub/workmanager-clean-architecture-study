import 'package:injectable/injectable.dart';

// import 'package:workmanager_clean_architecture_sample/data/repository/sync_repository.dart';
import 'package:workmanager_clean_architecture_sample/presentation/cubit/work_manager_cubit.dart';

import '../data/repository/number_repository.dart';

abstract class NumberUsecase {
  Future<Stream<int>?> watchChange(String color);

  Future<Stream<void>?> watchLogChanged();

  Future<void> plusOneNumber(String color);

  LogEvent addLog(String taskName, int retryCount);

  Future<List<LogEvent>> getAllLog();
}

@Injectable(as: NumberUsecase)
class NumberUsecaseImpl extends NumberUsecase {
  NumberUsecaseImpl(this._numberRepository);

  final NumberRepository _numberRepository;

  @override
  Future<Stream<int>?> watchChange(String color) => _numberRepository.watchChange(color);

  @override
  Future<void> plusOneNumber(String color) async {
    await _numberRepository.postPlusOne(color);
  }

  @override
  Future<Stream<void>?> watchLogChanged() => _numberRepository.watchLogChanged();

  @override
  LogEvent addLog(String taskName, int retryCount) {
    DateTime timeStamp = DateTime.now();
    print('RedUsecaseImpl/addLog - $taskName, $timeStamp $retryCount');
    // _numberRepository.addLog(taskName, timeStamp, retryCount);

    return LogEvent(timeStamp, retryCount + 1, EventType.red, true);
  }

  @override
  Future<List<LogEvent>> getAllLog() async {
    return await _numberRepository.getAllLog();
  }

// @override
// Future<int> getCount() {
// return _numberRepository.getRedCount();
// }
}
