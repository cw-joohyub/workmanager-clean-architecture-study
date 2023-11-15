import 'dart:collection';

import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_log.dart';
import 'package:workmanager_clean_architecture_sample/data/work_manager/model/work_manager_constraint.dart';

const String taskId = 'workmanager_task';

class TaskRequester {
  static Future<void> registerWorkManager(
      {WorkManagerConstraint? workManagerConstraint}) async {
    await Workmanager().registerOneOffTask(taskId, taskId,
        inputData: <String, dynamic>{
          'constraint': workManagerConstraint?.toJsonString() ?? '',
        },
        existingWorkPolicy: ExistingWorkPolicy.replace);
  }
}
