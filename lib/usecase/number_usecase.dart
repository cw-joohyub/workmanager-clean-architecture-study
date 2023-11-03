import 'package:injectable/injectable.dart';

// import 'package:workmanager_clean_architecture_sample/data/repository/sync_repository.dart';
import 'package:workmanager_clean_architecture_sample/presentation/cubit/work_manager_cubit.dart';

import '../data/repository/number_repository.dart';

abstract class NumberUsecase {

  Future<Stream<int>?> watchChange(String color);

  void plusOneNumber(String color);


  // Future<int> getCount();

  LogEvent addLog(String taskName, int retryCount);
}

@Injectable(as: NumberUsecase)
class NumberUsecaseImpl extends NumberUsecase {
  NumberUsecaseImpl(this._numberRepository);

  final NumberRepository _numberRepository;

  @override
  Future<Stream<int>?> watchChange(String color) => _numberRepository.watchChange(color);

  @override
  void plusOneNumber(String color) {
    _numberRepository.postPlusOne(color);
  }

  @override
  LogEvent addLog(String taskName, int retryCount) {
    DateTime timeStamp = DateTime.now();
    print('RedUsecaseImpl/addLog - $taskName, $timeStamp $retryCount');
    // _numberRepository.addLog(taskName, timeStamp, retryCount);

    return LogEvent(timeStamp, retryCount + 1, EventType.red, true);
  }

// @override
// Future<int> getCount() {
// return _numberRepository.getRedCount();
// }
}
