import 'package:isar/isar.dart';

part 'dt_task.g.dart';

enum EventType { red, black }

enum TaskStatus { open, inProgress, done, canceled }

extension TaskStatusExtension on TaskStatus {
  String taskStatusToString() {
    switch (this) {
      case TaskStatus.open:
        return 'open';
      case TaskStatus.inProgress:
        return 'inProgress';
      case TaskStatus.done:
        return 'done';
      case TaskStatus.canceled:
        return 'canceled';
      default:
        throw ArgumentError('Invalid TaskStatus value: $this');
    }
  }
}

extension StringTaskStatusExtension on String {
  TaskStatus toTaskStatus() {
    switch (this) {
      case 'open':
        return TaskStatus.open;
      case 'inProgress':
        return TaskStatus.inProgress;
      case 'done':
        return TaskStatus.done;
      case 'canceled':
        return TaskStatus.canceled;
      default:
        throw ArgumentError('Invalid TaskStatus string: $this');
    }
  }
}

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
