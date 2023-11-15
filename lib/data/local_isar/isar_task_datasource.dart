import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/isar_helper.dart';

import 'dt_task.dart';

abstract class IsarTaskDatasource {
  Future<void> initDb();

  Future<DtTask?> pollTask();

  Future<bool> isTaskExists();

  Future<int> getTaskRetryCount(String taskKey);

  Future<int> writeTaskResult(String taskId, TaskStatus status);

  Future<int> addTask(EventType type, {Map<String, dynamic>? data});

  Future<int> addOpenedTask(DtTask task);

  Future<List<DtTask>?> getTaskList();

  Stream<List<DtTask>> getTaskListStream();

  Future<void> deleteAllTask();

  Future<int> cancelTask(String taskKey, EventType eventType);

  Future<DateTime?> getLastTaskTime();

  Future<void> checkActiveTasks();

  Future<List<DtTask>> testCode();
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
  Future<int> getTaskRetryCount(String taskKey) async {
    await initDb();

    return isar?.txnSync(() =>
            isar?.dtTasks
                .where()
                .filter()
                .taskKeyEqualTo(taskKey)
                .taskStatusEqualTo(TaskStatus.failed)
                .countSync() ??
            0) ??
        0;
  }

  @override
  Future<int> writeTaskResult(String taskId, TaskStatus status) async {
    await initDb();

    return isar?.writeTxnSync(() {
          DtTask? task = isar?.dtTasks.filter().taskKeyEqualTo(taskId).findAllSync().last;
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
  Future<int> addTask(EventType type, {Map<String, dynamic>? data}) async {
    await initDb();

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
  Future<int> cancelTask(String taskKey, EventType eventType) async {
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

    DtTask result = DtTask(
        taskKey: task.taskKey,
        eventType: task.eventType,
        dateTime: DateTime.now(),
        taskStatus: TaskStatus.open);

    isar?.writeTxnSync(() {
      return isar?.dtTasks.putSync(result);
    });

    return 0;
  }

  @override
  Future<List<DtTask>> testCode() async {
    await initDb();

    List<DtTask>? result = await isar?.dtTasks.where().distinctByTaskKey().findAll();

    print('result - $result');

    // await isar?.dtTasks.buildQuery(
    //   whereClauses: [
    //     // WhereClause(),
    //   ],
    //   filter: FilterGroup.and(
    //     [
    //       FilterCondition(
    //           type: FilterConditionType.contains,
    //           property: 'property',
    //           caseSensitive: false,
    //           include1: true,
    //           include2: true),
    //     ],
    //   ),
    // );
    return [];
  }
}
