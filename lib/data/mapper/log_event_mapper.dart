import '../../presentation/cubit/work_manager_cubit.dart';
import '../local_isar/dt_log.dart';
import '../local_isar/dt_task.dart';

class LogEventMapper {
  LogEvent mapToLogEvent(DtTask dtTask) {
    return LogEvent(
      dtTask.taskId ?? '',
      // [dtLog.requestedAt ?? DateTime.now(), dtLog.lastAttemptedAt ?? DateTime.now()],
      // dtLog.retryCount ?? 0,
      dtTask.dateTime ?? DateTime.now(),
      // dtTask.eventType = dtTask.eventType,
      dtTask.taskStatus,
    );
  }

  DtTask mapToDtLog(LogEvent logEvent) {
    return DtTask(
      taskId: logEvent.id,
      dateTime: logEvent.dateTime,
      // eventType: logEvent.eventType,
      taskStatus: logEvent.status,
    );
  }
}
