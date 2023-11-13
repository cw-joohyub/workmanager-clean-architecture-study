import 'dart:ui';

import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/data/local_csv/dt_csv_log.dart';
import 'package:workmanager_clean_architecture_sample/presentation/cubit/work_manager_cubit.dart';

import '../../di/di.dart';
import '../local_csv/csv_log_local_datasource.dart';
import '../local_isar/log_local_datasource.dart';
import '../remote/number_remote_datasource.dart';

const plusOneToRedTaskKey = 'plus_one_red3';
const plusOneToBlackTaskKey = 'plus_one_black3';
const iosTest = 'be.tramckrijte.workmanagerExample.taskId';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print('[Workmanager] $task, $inputData');
    getItInit();

    final String color = inputData!['color']!;
    // final String taskKey = inputData['taskKey']!;
    EventType eventType = color == 'red' ? EventType.red : EventType.black;

    final int successRate = inputData['successRate'] ?? 100;
    final int fakeDelayMilliseconds = inputData['fakeDelayMilliseconds'] ?? 10;
    final bool isImprovedAppend = inputData['isImprovedAppend'] ?? false;
    final bool isPeriodicTask = inputData['isPeriodicTask'] ?? false;

    final LogLocalDatasource logLocalDatasource = getIt<LogLocalDatasource>();
    final CsvLogLocalDataSource csvLogLocalDataSource =
        getIt<CsvLogLocalDataSource>();

    final logKey = inputData['logKey']!;
    print('logKey - $logKey');
    final isSuccess = await getIt<NumberRemoteDatasource>()
        .postAddEvent(eventType.name, fakeDelayMilliseconds, successRate);
    await logLocalDatasource.addLog(eventType.name, logKey, isSuccess);

    final sendPort = IsolateNameServer.lookupPortByName("backgroundtask");
    sendPort?.send('updateUi');

    final DtCsvLog log = DtCsvLog(
      color: eventType.name,
      id: logKey.toString(),
      timestamp: DateTime.now().toIso8601String(),
      isFinished: isSuccess,
    );
    await csvLogLocalDataSource.appendLog(log);

    final int failureCount = await logLocalDatasource.getFailureCount(logKey.toString());
    if (!isSuccess && failureCount > 0 && isImprovedAppend && !isPeriodicTask) {
      Workmanager().registerOneOffTask(
        iosTest,
        iosTest,
        inputData: <String, dynamic>{
          'color': color,
          'logKey': logKey,
          'successRate': successRate,
          'fakeDelayMilliseconds': fakeDelayMilliseconds,
          'isImprovedAppend': isImprovedAppend,
        },
        backoffPolicy: BackoffPolicy.linear,
        backoffPolicyDelay: const Duration(milliseconds: 500),
        initialDelay: const Duration(milliseconds: 100),
        existingWorkPolicy: ExistingWorkPolicy.append,
      );

      return Future.value(true);
    }

    return Future.value(isSuccess);
  });
}
