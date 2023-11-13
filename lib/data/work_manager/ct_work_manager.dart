import 'package:isar/isar.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_task.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/isar_helper.dart';

class CTWorkManager {
  Isar? isar;

  Future<void> initDb() async {
    isar = await IsarHelper.getInstance();
  }

  int addTask(DtTask task) {
    isar?.writeTxnSync(() {
      return isar?.dtTasks.putSync(task);
    });
    return 0;
  }

  Stream<List<DtTask>> getTaskList() {
    return isar?.dtTasks.watchLazy().asyncMap((_) async {
          return await isar?.dtTasks.where().findAll() ?? [];
        }) ??
        const Stream.empty();
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
    // todo: implement
    return;
  }
}
