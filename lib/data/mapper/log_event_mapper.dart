import '../../presentation/cubit/work_manager_cubit.dart';
import '../local_isar/dt_log.dart';

class LogEventMapper {
  LogEvent mapToLogEvent(DtLog dtLog) {
    return LogEvent(
      dtLog.id.toString(),
      [dtLog.requestedAt ?? DateTime.now(), dtLog.lastAttemptedAt ?? DateTime.now()],
      dtLog.retryCount ?? 0,
      dtLog.color! == 'red' ? EventType.red : EventType.black,
      dtLog.hasFinished ?? false,
    );
  }

  DtLog mapToDtLog(LogEvent logEvent) {
    final dtLog = DtLog();
    dtLog.color = logEvent.eventType == EventType.red ? 'red' : 'black';
    dtLog.requestedAt = logEvent.tryTimes.isEmpty ? DateTime.now() : logEvent.tryTimes[0];
    dtLog.retryCount = logEvent.retry;
    dtLog.hasFinished = logEvent.isSuccess;
    return dtLog;
  }
}
