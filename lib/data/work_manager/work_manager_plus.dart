import 'package:injectable/injectable.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/isar_task_datasource.dart';
import 'package:workmanager_clean_architecture_sample/data/work_manager/task_requester.dart';

import 'model/work_manager_constraint.dart';

@injectable
class WorkManagerPlus {
  WorkManagerPlus(this._isarTaskDatasource, this._taskRequester);

  final IsarTaskDatasource _isarTaskDatasource;
  final TaskRequester _taskRequester;

  Future<void> registerWorkManager(
      {required String taskId, WorkManagerConstraint? workManagerConstraint}) async {
    DateTime? lastDatetime = await getLastTaskTime();

    workManagerConstraint ??= const WorkManagerConstraint(
      initialDelay: null,
      restartDuration: null,
      isNetworkCheck: null,
      retryCount: null,
      backOffPolicy: null,
    );

    if (lastDatetime != null &&
        lastDatetime.difference(DateTime.now()).inSeconds <
            workManagerConstraint.restartDuration!.inSeconds) {
      return;
    }

    await _taskRequester.registerWorkManager(
        taskId: taskId, workManagerConstraint: workManagerConstraint);
  }

  Future<int> addTask(String taskId, {Map<String, dynamic>? data}) async {
    int result = await _isarTaskDatasource.addTask(taskId, data: data);
    registerWorkManager(taskId: taskId);
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

  Future<int> cancelTask(String taskId) {
    return _isarTaskDatasource.cancelTask(taskId);
  }

  Future<DateTime?> getLastTaskTime() {
    return _isarTaskDatasource.getLastTaskTime();
  }

  void checkActiveTasks() {
    _isarTaskDatasource.checkActiveTasks();
  }
}
