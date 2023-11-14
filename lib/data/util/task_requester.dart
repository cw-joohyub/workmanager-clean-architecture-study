import 'dart:collection';

import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_log.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';
import 'package:workmanager_clean_architecture_sample/data/util/work_manager_constraint.dart';

class TaskRequester {
  static final TaskRequester instance = TaskRequester._internal();

  factory TaskRequester() => instance;

  TaskRequester._internal();

  //TODO(nm-JihunCha): need to change data model
  final Queue<DtLog> _logQueue = Queue();

  String plusOneToRedTaskKey = 'plus_one_red3';
  String plusOneToBlackTaskKey = 'plus_one_black3';

  static int successRate = 100;
  static int fakeDelayMilliseconds = 10;
  static bool isImprovedAppend = false;
  static bool isPeriodicTask = false;

  void registerWorkManager(String color, TaskStatus taskStatus, int? retryCount,
      WorkManagerConstraint workManagerConstraint) async {
    String logKey = const Uuid().v4();

    if (retryCount != null && retryCount == 0) {
      await Future<void>.delayed(workManagerConstraint.initialDelay!);
    }
    Workmanager().registerOneOffTask(color, color,
        inputData: <String, dynamic>{
          'taskKey': color,
          'logKey': logKey,
          'taskStatus': taskStatus.taskStatusToString(),
          'retryCount': retryCount ?? 0,
          'constraint': workManagerConstraint.toJsonString() ?? '',
        },
        existingWorkPolicy: ExistingWorkPolicy.replace);
  }
}
