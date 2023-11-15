import 'package:injectable/injectable.dart';
import 'package:workmanager_clean_architecture_sample/data/remote/number_remote_datasource.dart';

import '../../di/di.dart';

abstract class WorkExecutor {
  Future<bool> execute(task, inputData);
}

@Injectable(as: WorkExecutor)
class WorkExecutorImpl implements WorkExecutor {
  @override
  Future<bool> execute(task, inputData) async {
    print('[WorkExecutor/execute] $task, $inputData');

    switch (task) {
      case 'red':
      case 'black':
        final isSuccess = await getIt<NumberRemoteDatasource>().postAddEvent(10, 70);

        return isSuccess;
      default:
        break;
    }

    return Future.value(true);
  }
}
