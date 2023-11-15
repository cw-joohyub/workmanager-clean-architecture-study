import 'package:injectable/injectable.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';
import 'package:workmanager_clean_architecture_sample/data/work_manager/work_manager_plus.dart';

@injectable
class TaskRepository {
  TaskRepository(this._ctWorkManager);

  static int successRate = 100;
  static int fakeDelayMilliseconds = 10;
  static bool isImprovedAppend = false;
  static bool isPeriodicTask = false;

  final WorkManagerPlus _ctWorkManager;

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

  Stream<List<DtTask>> getTaskListStream() {
    return _ctWorkManager.getTaskListStream();
  }

  Future<List<DtTask>?> getTaskList() {
    return _ctWorkManager.getTaskList();
  }

  Future<void> postPlusOne(String taskId) async {
    await _ctWorkManager.addTask(taskId);
      // workManagerConstraint: WorkManagerConstraint(
      //   initialDelay: null,
      //   restartDuration: Duration(seconds: 2),
      //   isNetworkCheck: null,
      //   retryCount: null,
      //   backOffPolicy: BackoffPolicy.linear,
      // ),
  }
}
