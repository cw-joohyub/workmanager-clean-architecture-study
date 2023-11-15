import 'dart:collection';

import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_log.dart';
import 'package:workmanager_clean_architecture_sample/data/work_manager/model/work_manager_constraint.dart';

class TaskRequester {
  static final TaskRequester instance = TaskRequester._internal();

  factory TaskRequester() => instance;

  TaskRequester._internal();

  //TODO(nm-JihunCha): need to change data model
  final Queue<DtLog> _logQueue = Queue();

  Future<void> registerWorkManager(
      {required String taskId, WorkManagerConstraint? workManagerConstraint}) async {
    await Workmanager().registerOneOffTask(taskId, taskId,
        inputData: <String, dynamic>{
          'constraint': workManagerConstraint?.toJsonString() ?? '',
        },
        existingWorkPolicy: ExistingWorkPolicy.replace);
  }
}
