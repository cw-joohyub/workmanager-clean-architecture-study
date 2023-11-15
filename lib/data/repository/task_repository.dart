import 'package:injectable/injectable.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';
import 'package:workmanager_clean_architecture_sample/data/util/work_manager_constraint.dart';
import 'package:workmanager_clean_architecture_sample/data/work_manager/ct_work_manager.dart';

import '../util/task_requester.dart';

@injectable
class TaskRepository {
  TaskRepository(this._ctWorkManager);

  static int successRate = 100;
  static int fakeDelayMilliseconds = 10;
  static bool isImprovedAppend = false;
  static bool isPeriodicTask = false;

  final CTWorkManager _ctWorkManager;

  static void setOption(
      {int? successRate,
      int? fakeDelayMilliseconds,
      bool? isImprovedAppend,
      bool? isPeriodicTask}) {
    TaskRepository.successRate = successRate ?? TaskRepository.successRate;
    TaskRepository.fakeDelayMilliseconds =
        fakeDelayMilliseconds ?? TaskRepository.fakeDelayMilliseconds;
    TaskRepository.isImprovedAppend = isImprovedAppend ?? TaskRepository.isImprovedAppend;
    TaskRepository.isPeriodicTask = isPeriodicTask ?? TaskRepository.isPeriodicTask;
  }

  Stream<List<DtTask>> watchTaskChange() {
    return _ctWorkManager.getTaskList();
  }

  Future<int> getWorkCount(EventType color) async {
    await for (List<DtTask> taskList in watchTaskChange()) {
      int count = 0;
      for (var element in taskList) {
        if (element.eventType == color && element.taskStatus == TaskStatus.done) {
          count++;
        }
      }
      return count;
    }
    return 0;
  }

  Future<void> postPlusOne(EventType color) async {
    await _ctWorkManager.addTask(color);
    await TaskRequester().registerWorkManager();
  }
}
