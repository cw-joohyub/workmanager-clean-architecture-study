import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/isar_helper.dart';

import 'dt_task.dart';

abstract class IsarTaskDatasource {
  Future<void> initDb();

  Future<DtTask?> pollTask();

  Future<bool> isTaskExists();

  Future<int> getTaskRetryCount(String taskId);

  Future<int> writeTaskResult(int id, TaskStatus status);

  Future<int> addTask(String taskId, {Map<String, dynamic>? data});

  Future<int> addOpenedTask(DtTask task);

  Future<List<DtTask>?> getTaskList();

  Stream<List<DtTask>> getTaskListStream();

  Future<void> deleteAllTask();

  Future<int> cancelTask(int id);

  Future<DateTime?> getLastTaskTime();

  Future<void> checkActiveTasks();
}

@LazySingleton(as: IsarTaskDatasource)
class IsarTaskDatasourceImpl extends IsarTaskDatasource {
  Isar? isar;

  @override
  Future<void> initDb() async {
    isar ??= await IsarHelper.getInstance();
  }

  @override
  Future<DtTask?> pollTask() async {
    await initDb();

    DtTask? task = isar?.writeTxnSync(() {
      return isar?.dtTasks.filter().taskStatusEqualTo(TaskStatus.open).findFirstSync();
    });

    if (task != null) {
      task.taskStatus = TaskStatus.inProgress;
      isar?.writeTxnSync(() {
        isar?.dtTasks.putSync(task);
      });
    }
    return task;
  }

  @override
  Future<bool> isTaskExists() async {
    await initDb();

    return isar?.dtTasks.where().filter().taskStatusEqualTo(TaskStatus.open).countSync() != 0;
  }

  @override
  Future<int> getTaskRetryCount(String taskId) async {
    await initDb();

    return isar?.txnSync(() =>
            isar?.dtTasks
                .where()
                .filter()
                .taskTypeEqualTo(taskId)
                .taskStatusEqualTo(TaskStatus.failed)
                .countSync() ??
            0) ??
        0;
  }

  @override
  Future<int> writeTaskResult(int id, TaskStatus status) async {
    await initDb();

    return isar?.writeTxnSync(() {
          DtTask? task = isar?.dtTasks.filter().idEqualTo(id).findFirstSync();
          if (task != null) {
            task.dateTime = DateTime.now();
            task.taskStatus = status;

            return isar?.dtTasks.putSync(task);
          }
          return 0;
        }) ??
        0;
  }

  @override
  Future<int> addTask(String taskId, {Map<String, dynamic>? data}) async {
    await initDb();

    DtTask task = DtTask(
      taskType: taskId,
      dateTime: DateTime.now(),
      taskStatus: TaskStatus.open,
    );
    isar?.writeTxnSync(() {
      return isar?.dtTasks.putSync(task);
    });
    return 0;
  }

  @override
  Future<List<DtTask>?> getTaskList() async {
    await initDb();

    return isar?.dtTasks.where().findAll();
  }

  @override
  Stream<List<DtTask>> getTaskListStream() async* {
    await initDb();

    yield* isar?.dtTasks.watchLazy().asyncMap((_) async {
          return await isar?.dtTasks.where().findAll() ?? [];
        }) ??
        const Stream.empty();
  }

  @override
  Future<void> deleteAllTask() async {
    initDb();

    isar?.writeTxnSync(() {
      return isar?.dtTasks.clearSync();
    });
  }

  @override
  Future<int> cancelTask(int id) async {
    initDb();

    return isar?.writeTxnSync(() {
          DtTask? task = isar?.dtTasks.filter().idEqualTo(id).findFirstSync();
          if (task != null) {
            task.taskStatus = TaskStatus.canceled;
            return isar?.dtTasks.putSync(task);
          }
          return 0;
        }) ??
        0;
  }

  @override
  Future<DateTime?> getLastTaskTime() async {
    initDb();

    return isar?.dtTasks.where().sortByDateTime().findFirstSync()?.dateTime;
  }

  @override
  Future<void> checkActiveTasks() async {
    await initDb();

    // 같은 task id 로 group by 하고, 가장 최근의 TaskStatus 가 inProgress 인 것을 찾는다.
    isar?.dtTasks
        .where()
        .filter()
        .taskStatusEqualTo(TaskStatus.inProgress)
        .findAll()
        .then((openTaskList) {
      if (openTaskList.isNotEmpty) {
        // inProgress 인 것이 있으면, Open 상태로 바꾼다.
        openTaskList.sort((a, b) => b.dateTime.compareTo(a.dateTime));
        for (DtTask task in openTaskList) {
          task.taskStatus = TaskStatus.open;
          isar?.writeTxnSync(() {
            isar?.dtTasks.putSync(task);
          });
        }
      }
    });
    return;
  }

  @override
  Future<int> addOpenedTask(DtTask task) async {
    await initDb();

    DtTask result =
        DtTask(taskType: task.taskType, dateTime: DateTime.now(), taskStatus: TaskStatus.open);

    isar?.writeTxnSync(() {
      return isar?.dtTasks.putSync(result);
    });

    return 0;
  }
}
