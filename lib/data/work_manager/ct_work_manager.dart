import 'package:injectable/injectable.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/isar_task_datasource.dart';

@injectable
class CTWorkManager {
  CTWorkManager(this._isarTaskDatasource);

  final IsarTaskDatasource _isarTaskDatasource;

  Future<int> addTask(EventType type, {Map<String, dynamic>? data}) {
    return _isarTaskDatasource.addTask(type, data: data);
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

  Future<int> cancelTask(String taskKey, EventType eventType) {
    return _isarTaskDatasource.cancelTask(taskKey, eventType);
  }

  Future<DateTime?> getLastTaskTime() {
    return _isarTaskDatasource.getLastTaskTime();
  }

  void checkActiveTasks() {
    _isarTaskDatasource.checkActiveTasks();
  }
}
