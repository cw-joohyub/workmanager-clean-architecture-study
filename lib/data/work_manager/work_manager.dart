import 'dart:ui';

import 'package:workmanager/workmanager.dart';
import '../local/log_local_datasource.dart';
import '../remote/number_remote_datasource.dart';
import '../../di/di.dart';

import '../local/number_local_datasource.dart';

const plusOneToRedTaskKey = 'plus_one_red';
const plusOneToBlackTaskKey = 'plus_one_black2';

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print('[Workmanager] $task, $inputData');

    getItInit();
    // await getIt<NumberLocalDatasource>().initDb();
    // await getIt<LogLocalDatasource>().initDb();

    switch (task) {

      case plusOneToRedTaskKey:
        final logKey = inputData!['logKey']!;
        final result = await getIt<NumberRemoteDatasource>().postAddEvent('red');
        await getIt<LogLocalDatasource>().updateLog(logKey, result);

        if (result) {
          await getIt<NumberLocalDatasource>().plusOneNumber('red');

          final sendPort = IsolateNameServer.lookupPortByName("backgroundtask");
          if (sendPort != null) {
            sendPort.send('updateUi');
          }
        }
        return Future.value(result);
      case plusOneToBlackTaskKey:
        final logKey = inputData!['logKey']!;
        final result = await getIt<NumberRemoteDatasource>().postAddEvent('black');
        await getIt<LogLocalDatasource>().updateLog(logKey, result);
        if (result) {
          await getIt<NumberLocalDatasource>().plusOneNumber('black');

          final sendPort = IsolateNameServer.lookupPortByName("backgroundtask");
          if (sendPort != null) {
            sendPort.send('updateUi');
          }
        }
        return Future.value(result);
    }
    return Future.value(true);
  });
}
