import 'package:isar/isar.dart';

part 'dt_task.g.dart';

enum EventType { red, black }

enum TaskStatus { open, inProgress, done, canceled }

@collection
class DtTask {
  Id id = Isar.autoIncrement;
  String taskKey;
  @enumerated
  EventType eventType;
  DateTime dateTime;
  @enumerated
  TaskStatus taskStatus;

  DtTask({
    required this.taskKey,
    required this.eventType,
    required this.dateTime,
    required this.taskStatus,
  });

  @override
  String toString() {
    return 'DtTask{id: $id, taskKey: $taskKey, eventType: $eventType, dateTime: $dateTime, taskStatus: $taskStatus}';
  }
}
