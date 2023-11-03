import 'package:injectable/injectable.dart';
import 'package:workmanager/workmanager.dart';

import '../local_isar/log_local_datasource.dart';
import '../local_isar/number_local_datasource.dart';
import '../work_manager/work_manager.dart';

// abstract class SyncRepository {
//
// }
//
// @Injectable(as: SyncRepository)
@injectable
class NumberRepository {
  NumberRepository(this._numberLocalDatasource, this._logLocalDatasource);

  final NumberLocalDatasource _numberLocalDatasource;
  final LogLocalDatasource _logLocalDatasource;

  Future<int> getNumber(String color) async {
    return _numberLocalDatasource.getNumber(color);
  }

  Future<Stream<int>?> watchChange(String color) => _numberLocalDatasource.watchChange(color);

  Future<void> postPlusOne(String color) async {
    final String taskKey = color == 'red' ? plusOneToRedTaskKey : plusOneToBlackTaskKey;
    final int logKey = await _logLocalDatasource.addLog(color);

    print('postPlusOne : $color, $logKey');

    Workmanager().registerOneOffTask(
      '$taskKey$logKey', taskKey,
      inputData: <String, dynamic>{
        'logKey': logKey,
      },
      // constraints: Constraints(networkType: NetworkType.connected),
      backoffPolicy: BackoffPolicy.linear,
      backoffPolicyDelay: const Duration(milliseconds: 500),
      initialDelay: const Duration(milliseconds: 100),
      existingWorkPolicy: ExistingWorkPolicy.replace,
    );
  }
}
