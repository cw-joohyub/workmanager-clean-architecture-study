import 'dart:collection';

import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_log.dart';
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

  Future<void> registerWorkManager(
      {required String taskId, WorkManagerConstraint? workManagerConstraint}) async {
    await Workmanager().registerOneOffTask(taskId, taskId,
        inputData: <String, dynamic>{
          'constraint': workManagerConstraint?.toJsonString() ?? '',
        },
        existingWorkPolicy: ExistingWorkPolicy.replace);
  }
}
