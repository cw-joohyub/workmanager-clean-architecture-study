import 'dart:ui';

import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/data/local_csv/dt_csv_log.dart';
import '../local_csv/csv_log_local_datasource.dart';
import '../local_isar/log_local_datasource.dart';
import '../local_isar/number_local_datasource.dart';
import '../remote/number_remote_datasource.dart';
import '../../di/di.dart';

const plusOneToRedTaskKey = 'plus_one_red3';
const plusOneToBlackTaskKey = 'plus_one_black3';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print('[Workmanager] $task, $inputData');
    getItInit();

    switch (task) {
      case plusOneToRedTaskKey:
        final logKey = inputData!['logKey']!;
        print('logKey - $logKey');
        final result =
            await getIt<NumberRemoteDatasource>().postAddEvent('red');
        await getIt<LogLocalDatasource>().updateLog(logKey, result);

        if (result) {
          await getIt<NumberLocalDatasource>().plusOneNumber('red');

          final sendPort = IsolateNameServer.lookupPortByName("backgroundtask");
          if (sendPort != null) {
            sendPort.send('updateUi');
          }
        }

        final DtCsvLog log = DtCsvLog(
          color: 'red',
          id: logKey.toString(),
          timestamp: DateTime.now().toIso8601String(),
          isFinished: result,
        );
        await getIt<CsvLogLocalDataSource>().appendLog(log);

        return Future.value(result);
      case plusOneToBlackTaskKey:
        final logKey = inputData!['logKey']!;
        final result =
            await getIt<NumberRemoteDatasource>().postAddEvent('black');
        await getIt<LogLocalDatasource>().updateLog(logKey, result);
        if (result) {
          await getIt<NumberLocalDatasource>().plusOneNumber('black');

          final sendPort = IsolateNameServer.lookupPortByName("backgroundtask");
          if (sendPort != null) {
            sendPort.send('updateUi');
          }
        }

        final DtCsvLog log = DtCsvLog(
          color: 'black',
          id: logKey.toString(),
          timestamp: DateTime.now().toIso8601String(),
          isFinished: result,
        );
        await getIt<CsvLogLocalDataSource>().appendLog(log);

        return Future.value(result);
    }
    return Future.value(true);
  });
}
