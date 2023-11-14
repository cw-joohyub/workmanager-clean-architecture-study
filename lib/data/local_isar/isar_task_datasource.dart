import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/isar_helper.dart';

import 'dt_task.dart';

abstract class IsarTaskDatasource {
  Future<void> initDb();
  DtTask? pollTask();
  int writeTaskResult(String taskId, TaskStatus status);
  int addTask(EventType type, {Map<String, dynamic>? data});
  Stream<List<DtTask>> getTaskList();
  void deleteAllTask();
  int cancelTask(String taskKey, EventType eventType);
  DateTime? getLastTaskTime();
  void checkActiveTasks();
}

@LazySingleton(as: IsarTaskDatasource)
class IsarTaskDatasourceImpl extends IsarTaskDatasource {
  Isar? isar;

  @override
  Future<void> initDb() async {
    isar ??= await IsarHelper.getInstance();
  }

  @override
  DtTask? pollTask() {
    initDb();

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
  int writeTaskResult(String taskId, TaskStatus status) {
    initDb();

    return isar?.writeTxnSync(() {
      DtTask? task = isar?.dtTasks.filter().taskKeyEqualTo(taskId).findFirstSync();
      if (task != null) {
        task.dateTime = DateTime.now();
        task.taskStatus = status;
        return isar?.dtTasks.putSync(task);
      }
      return 0;
    }) ?? 0;
  }

  @override
  int addTask(EventType type, {Map<String, dynamic>? data}) {
    initDb();

    DtTask task = DtTask(
      taskKey: const Uuid().v4(),
      eventType: type,
      dateTime: DateTime.now(),
      taskStatus: TaskStatus.open,
    );
    isar?.writeTxnSync(() {
      return isar?.dtTasks.putSync(task);
    });
    return 0;
  }

  @override
  Stream<List<DtTask>> getTaskList() {
    initDb();

    return isar?.dtTasks.watchLazy().asyncMap((_) async {
          return await isar?.dtTasks.where().findAll() ?? [];
        }) ??
        const Stream.empty();
  }

  @override
  void deleteAllTask() {
    initDb();

    isar?.writeTxnSync(() {
      return isar?.dtTasks.clearSync();
    });
  }

  @override
  int cancelTask(String taskKey, EventType eventType) {
    initDb();

    return isar?.writeTxnSync(() {
          DtTask newTask = DtTask(
            taskKey: taskKey,
            eventType: eventType,
            dateTime: DateTime.now(),
            taskStatus: TaskStatus.canceled,
          );

          return isar?.dtTasks.putSync(newTask);
        }) ??
        0;
  }

  @override
  DateTime? getLastTaskTime() {
    initDb();

    return isar?.dtTasks.where().sortByDateTime().findFirstSync()?.dateTime;
  }

  @override
  void checkActiveTasks() {
    initDb();

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
}
