import 'package:isar/isar.dart';

part 'dt_task.g.dart';

enum TaskStatus { open, inProgress, done, canceled, failed }

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
      case TaskStatus.failed:
        return 'failed';
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
      case 'failed':
        return TaskStatus.failed;
      default:
        throw ArgumentError('Invalid TaskStatus string: $this');
    }
  }
}

@collection
class DtTask {
  Id id = Isar.autoIncrement;
  String taskId;
  DateTime dateTime;
  @enumerated
  TaskStatus taskStatus;

  DtTask({
    required this.taskId,
    required this.dateTime,
    required this.taskStatus,
  });

  @override
  String toString() {
    return 'DtTask{id: $id, taskId: $taskId, dateTime: $dateTime, taskStatus: $taskStatus}';
  }
}
