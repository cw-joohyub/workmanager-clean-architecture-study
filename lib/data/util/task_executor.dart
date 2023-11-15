import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';
import 'package:workmanager_clean_architecture_sample/data/util/task_requester.dart';
import 'package:workmanager_clean_architecture_sample/data/util/work_manager_constraint.dart';
import '../../di/di.dart';

import '../local_isar/isar_task_datasource.dart';
import '../remote/number_remote_datasource.dart';

class TaskExecutor {
  final NumberRemoteDatasource _remoteDatasource;

  TaskExecutor(this._remoteDatasource);

  Future<bool> postNumberCount(EventType eventType) async {
    final isSuccess = await _remoteDatasource.postAddEvent(10, 0);
    // Add your logging logic here if needed
    return isSuccess;
  }

  Future<bool> postTask(DtTask task) async {
    final isSuccess = await _remoteDatasource.postAddEvent(10, 50);
    return isSuccess;
  }

  Future<void> executeTask(String task, Map<String, dynamic>? inputData) async {
    await getIt<IsarTaskDatasource>().initDb();

    final DtTask? pollTask = await getIt<IsarTaskDatasource>().pollTask();

    if (pollTask == null) {
      return;
    }

    final String taskKeyString = pollTask.taskKey;
    final EventType taskKey = taskKeyString == 'red' ? EventType.red : EventType.black;

    switch (taskKey) {
      case EventType.red:
      case EventType.black:
        await processTask(taskKey, inputData, pollTask);
        break;
    }
  }

  Future<void> processTask(
    EventType taskKey,
    Map<String, dynamic>? inputData,
    DtTask pollTask,
  ) async {
    WorkManagerConstraint constraint;

    try {
      constraint = WorkManagerConstraint.fromJsonString(inputData?['constraint'] ?? '');
    } catch (e) {
      constraint = WorkManagerConstraint(
        initialDelay: null,
        restartDuration: null,
        isNetworkCheck: null,
        retryCount: null,
      );
    }

    final int retryCount = constraint.retryCount!;
    int currentCount = await getIt<IsarTaskDatasource>().getTaskRetryCount(pollTask.taskKey);

    if (currentCount == 0) {
      await Future<void>.delayed(constraint.initialDelay!);
    }

    final apiResult = await postNumberCount(taskKey);

    if (!apiResult) {
      if (currentCount < retryCount - 1) {
        await handleRetry(pollTask, constraint);
      } else {
        await handleTaskFailure(pollTask, constraint);
      }
    } else {
      await handleTaskSuccess(pollTask, constraint);
    }
  }

  Future<void> handleRetry(DtTask pollTask, WorkManagerConstraint constraint) async {
    await getIt<IsarTaskDatasource>().writeTaskResult(pollTask.taskKey, TaskStatus.failed);
    await getIt<IsarTaskDatasource>().addOpenedTask(pollTask);

    await Future<void>.delayed(constraint.restartDuration!);
    await TaskRequester().registerWorkManager(workManagerConstraint: constraint);
  }

  Future<void> handleTaskFailure(DtTask pollTask, WorkManagerConstraint constraint) async {
    await getIt<IsarTaskDatasource>().writeTaskResult(pollTask.taskKey, TaskStatus.failed);

    final bool isResultExist = await getIt<IsarTaskDatasource>().isTaskExists();
    if (isResultExist) {
      await TaskRequester().registerWorkManager(workManagerConstraint: constraint);
    }
  }

  Future<void> handleTaskSuccess(DtTask pollTask, WorkManagerConstraint constraint) async {
    await getIt<IsarTaskDatasource>().writeTaskResult(pollTask.taskKey, TaskStatus.done);

    final bool isResultExist = await getIt<IsarTaskDatasource>().isTaskExists();
    if (isResultExist) {
      await TaskRequester().registerWorkManager(workManagerConstraint: constraint);
    }
  }
}

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   final taskExecutor = TaskExecutor(getIt<NumberRemoteDatasource>());
//   Workmanager().executeTask((task, inputData) async {
//     print('[WorkcallbackDispatcher/workmanager] $task, $inputData');
//     await taskExecutor.executeTask(task, inputData);
//     return Future.value(true);
//   });
// }
