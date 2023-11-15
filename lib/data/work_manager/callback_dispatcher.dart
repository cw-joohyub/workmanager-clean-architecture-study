import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/data/work_manager/task_requester.dart';
import 'package:workmanager_clean_architecture_sample/data/work_manager/model/work_manager_constraint.dart';
import 'package:workmanager_clean_architecture_sample/data/work_manager/work_executor.dart';

import '../../di/di.dart';
import '../local_isar/dt_task.dart';
import '../local_isar/isar_task_datasource.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  getItInit();
  Workmanager().executeTask((task, inputData) async {
    print('[WorkcallbackDispatcher/workmanager] $task, $inputData');
    await getIt<IsarTaskDatasource>().initDb();

    final DtTask? pollTask = await getIt<IsarTaskDatasource>().pollTask();

    if (pollTask == null) {
      return Future.value(true);
    }

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

    // final int retryCount = constraint.retryCount!;
    // int currentCount = await getIt<IsarTaskDatasource>().getTaskRetryCount(task);

    // if (currentCount == 0) {
    //   await Future<void>.delayed(constraint.initialDelay!);
    // }

    bool apiResult = await getIt<WorkExecutor>().execute(task, inputData);

    if (!apiResult) {
      // if (currentCount < retryCount - 1) {
      //   await handleRetry(task, pollTask, constraint);
      // } else {
      await handleTaskFailure(task, pollTask, constraint);
      // }
    } else {
      await handleTaskSuccess(task, pollTask, constraint);
    }

    return Future.value(true);
  });
}

Future<void> handleRetry(String task, DtTask pollTask, WorkManagerConstraint constraint) async {
  await getIt<IsarTaskDatasource>().writeTaskResult(pollTask.taskId, TaskStatus.failed);
  await getIt<IsarTaskDatasource>().addOpenedTask(pollTask);

  await Future<void>.delayed(constraint.restartDuration!);
  await TaskRequester().registerWorkManager(taskId: task, workManagerConstraint: constraint);
}

Future<void> handleTaskFailure(
    String task, DtTask pollTask, WorkManagerConstraint constraint) async {
  await getIt<IsarTaskDatasource>().writeTaskResult(pollTask.taskId, TaskStatus.open);

  final bool isResultExist = await getIt<IsarTaskDatasource>().isTaskExists();
  if (isResultExist) {
    await TaskRequester().registerWorkManager(taskId: task, workManagerConstraint: constraint);
  }
}

Future<void> handleTaskSuccess(
    String task, DtTask pollTask, WorkManagerConstraint constraint) async {
  await getIt<IsarTaskDatasource>().writeTaskResult(pollTask.taskId, TaskStatus.done);

  final bool isResultExist = await getIt<IsarTaskDatasource>().isTaskExists();
  if (isResultExist) {
    await TaskRequester().registerWorkManager(taskId: task, workManagerConstraint: constraint);
  }
}

//TODO(nm-JihunCha): legacy
// import 'package:workmanager/workmanager.dart';
// import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';
// import 'package:workmanager_clean_architecture_sample/data/util/task_requester.dart';
// import 'package:workmanager_clean_architecture_sample/data/util/work_manager_constraint.dart';
// import '../../di/di.dart';
//
// import '../local_isar/isar_task_datasource.dart';
// import '../remote/number_remote_datasource.dart';
//
// @pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
// void callbackDispatcher() {
//   //post Number
//   Future<bool> postNumberCount(EventType eventType) async {
//     final isSuccess = await getIt<NumberRemoteDatasource>().postAddEvent(10, 0);
//     // final LogLocalDatasource logLocalDatasource = getIt<LogLocalDatasource>();
//     // await logLocalDatasource.addLog(eventType.name, logKey, isSuccess);
//
//     return isSuccess;
//   }
//
//   //post Task
//   Future<bool> postTask(DtTask task) async {
//     final isSuccess = await getIt<NumberRemoteDatasource>().postAddEvent(10, 50);
//
//     return isSuccess;
//   }
//
//   Workmanager().executeTask((task, inputData) async {
//     print('[WorkcallbackDispatcher/workmanager] $task, $inputData');
//
//     getItInit();
//     await getIt<IsarTaskDatasource>().initDb();
//
//     final DtTask? pollTask = await getIt<IsarTaskDatasource>().pollTask();
//
//     if (pollTask == null) {
//       return Future.value(true);
//     }
//
//     final String taskKeyString = pollTask.taskKey;
//     final EventType taskKey = taskKeyString == 'red' ? EventType.red : EventType.black;
//
//     switch (taskKey) {
//       case EventType.red:
//       case EventType.black:
//         WorkManagerConstraint constraint;
//
//         try {
//           constraint = WorkManagerConstraint.fromJsonString(inputData?['constraint'] ?? '');
//         } catch (e) {
//           constraint = WorkManagerConstraint(
//             initialDelay: null,
//             restartDuration: null,
//             isNetworkCheck: null,
//             retryCount: null,
//           );
//         }
//
//         final int retryCount = constraint.retryCount!;
//         int currentCount = await getIt<IsarTaskDatasource>().getTaskRetryCount(pollTask.taskKey);
//
//         if (currentCount == 0) {
//           await Future<void>.delayed(constraint.initialDelay!);
//         }
//
//         final apiResult = await postNumberCount(taskKey);
//
//         if (!apiResult) {
//           if (currentCount < retryCount - 1) {
//             await getIt<IsarTaskDatasource>().writeTaskResult(pollTask.taskKey, TaskStatus.failed);
//             await getIt<IsarTaskDatasource>().addOpenedTask(pollTask);
//
//             await Future<void>.delayed(constraint.restartDuration!);
//             await TaskRequester().registerWorkManager(workManagerConstraint: constraint);
//           } else {
//             await getIt<IsarTaskDatasource>().writeTaskResult(pollTask.taskKey, TaskStatus.failed);
//
//             final bool isResultExist = await getIt<IsarTaskDatasource>().isTaskExists();
//             if (isResultExist) {
//               await TaskRequester().registerWorkManager(workManagerConstraint: constraint);
//             }
//           }
//         } else {
//           await getIt<IsarTaskDatasource>().writeTaskResult(pollTask.taskKey, TaskStatus.done);
//
//           final bool isResultExist = await getIt<IsarTaskDatasource>().isTaskExists();
//           if (isResultExist) {
//             await TaskRequester().registerWorkManager(workManagerConstraint: constraint);
//           }
//         }
//     }
//
//     return Future.value(true);
//   });
// }
