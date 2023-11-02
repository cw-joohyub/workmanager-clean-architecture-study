import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:workmanager/workmanager.dart';

import '../local/log_local_datasource.dart';
import '../local/number_data.dart';
import '../local/number_local_datasource.dart';
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

  Future<void> init() async {
    await _numberLocalDatasource.initDb();
    await _logLocalDatasource.initDb();
  }

  Future<int> getNumber(String color) async {
    return _numberLocalDatasource.getNumber(color);
  }

  Future<void> postPlusOne(String color) async {
    final String taskKey = color == 'red' ? plusOneToRedTaskKey : plusOneToBlackTaskKey;
    final int logKey = await _logLocalDatasource.addLog(color);

    print('postPlusOne : $color / $logKey / $taskKey');

    Workmanager().registerOneOffTask(
      taskKey, taskKey,
      inputData: <String, dynamic>{
        'logKey': logKey,
      },
      // constraints: Constraints(networkType: NetworkType.connected),
      backoffPolicy: BackoffPolicy.linear,
      backoffPolicyDelay: const Duration(milliseconds: 100),
      initialDelay: const Duration(milliseconds: 100),
      existingWorkPolicy: ExistingWorkPolicy.append,
    );
  }
}
