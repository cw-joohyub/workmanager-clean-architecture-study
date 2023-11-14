import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/isar_helper.dart';

@lazySingleton
class CTWorkManager {
  Isar? isar;

  Future<void> initDb() async {
    isar = await IsarHelper.getInstance();
  }

  int addTask(EventType type, {Map<String, dynamic>? data}) {
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

  Stream<List<DtTask>> getTaskList() {
    return isar?.dtTasks.watchLazy().asyncMap((_) async {
          return await isar?.dtTasks.where().findAll() ?? [];
        }) ?? const Stream.empty();
  }

  void deleteAllTask() {
    isar?.writeTxnSync(() {
      return isar?.dtTasks.clearSync();
    });
  }

  int cancelTask(String taskKey, EventType eventType) {
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

  DateTime? getLastTaskTime() {
    return isar?.dtTasks.where().sortByDateTime().findFirstSync()?.dateTime;
  }

  void checkActiveTasks() {
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
