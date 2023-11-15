import 'package:injectable/injectable.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/isar_task_datasource.dart';
import 'package:workmanager_clean_architecture_sample/data/work_manager/task_requester.dart';

import 'model/work_manager_constraint.dart';

@lazySingleton
class WorkManagerPlus {
  WorkManagerPlus(this._isarTaskDatasource);

  final IsarTaskDatasource _isarTaskDatasource;
  WorkManagerConstraint workManagerConstraint =
      WorkManagerConstraint.fromDefault();

  Future<void> notifyWorkManager() async {
    await checkActiveTasks();
    DateTime? lastDatetime = await getLastTaskTime();
    if (lastDatetime != null &&
        lastDatetime.difference(DateTime.now()).inSeconds >
            workManagerConstraint.restartDuration!.inSeconds) {
      return;
    }

    await TaskRequester.registerWorkManager();
  }

  Future<int> addTask(String taskId, {Map<String, dynamic>? data}) async {
    int result = await _isarTaskDatasource.addTask(taskId, data: data);
    await notifyWorkManager();
    return result;
  }

  Stream<List<DtTask>> getTaskListStream() {
    return _isarTaskDatasource.getTaskListStream();
  }

  Future<List<DtTask>?> getTaskList() {
    return _isarTaskDatasource.getTaskList();
  }

  void deleteAllTask() {
    _isarTaskDatasource.deleteAllTask();
  }

  Future<int> cancelTask(int id) {
    return _isarTaskDatasource.cancelTask(id);
  }

  Future<DateTime?> getLastTaskTime() {
    return _isarTaskDatasource.getLastTaskTime();
  }

  Future<void> checkActiveTasks() async {
    _isarTaskDatasource.checkActiveTasks();
  }
}
