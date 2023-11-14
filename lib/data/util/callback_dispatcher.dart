import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';
import 'package:workmanager_clean_architecture_sample/data/util/task_requester.dart';
import 'package:workmanager_clean_architecture_sample/data/util/work_manager_constraint.dart';
import '../../di/di.dart';

import '../local_isar/log_local_datasource.dart';
import '../remote/number_remote_datasource.dart';

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  //post Number
  Future<bool> postNumberCount(EventType eventType, String logKey, int retryCount) async {
    final isSuccess = await getIt<NumberRemoteDatasource>().postAddEvent(10, 0);
    final LogLocalDatasource logLocalDatasource = getIt<LogLocalDatasource>();
    await logLocalDatasource.addLog(eventType.name, logKey, isSuccess);

    return isSuccess;
  }

  //post Task
  Future<bool> postTask(DtTask task) async {
    final isSuccess = await getIt<NumberRemoteDatasource>().postAddEvent(10, 50);

    return isSuccess;
  }

  Workmanager().executeTask((task, inputData) async {
    print('[WorkcallbackDispatcher/workmanager] $task, $inputData');

    getItInit();

    final String taskKeyString = inputData!['taskKey']!;
    final EventType taskKey = taskKeyString == 'red' ? EventType.red : EventType.black;

    final String taskStatusString = inputData['taskStatus'];
    final TaskStatus taskStatus = taskStatusString.toTaskStatus();

    switch (taskKey) {
      case EventType.red:
      case EventType.black:
        final String logKey = inputData['logKey']!;
        WorkManagerConstraint constraint;

        try {
          constraint = WorkManagerConstraint.fromJsonString(inputData['constraint'] ?? '');
        } catch (e) {
          constraint = WorkManagerConstraint(
            initialDelay: null,
            restartDuration: null,
            isNetworkCheck: null,
            retryCount: null,
          );
        }

        final int retryCount = constraint.retryCount!;

        int currentCount = inputData['retryCount'] ?? 0;

        final apiResult = await postNumberCount(taskKey, logKey, 0);

        if (!apiResult) {
          //retry Count up
          if (currentCount < retryCount) {
            currentCount += 1;

            await Future<void>.delayed(constraint.restartDuration!);
            print(
                'taskKeyString - $taskKeyString, taskStatus - $taskStatus, currentCount - $currentCount, constraint - $constraint');
            TaskRequester()
                .registerWorkManager(taskKeyString, taskStatus, currentCount, constraint);
          }
        }

        return Future.value(true);
    }
  });
}
