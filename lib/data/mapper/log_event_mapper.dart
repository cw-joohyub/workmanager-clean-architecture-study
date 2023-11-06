import '../../presentation/cubit/work_manager_cubit.dart';
import '../local_isar/dt_log.dart';

class LogEventMapper {
  LogEvent mapToLogEvent(DtLog dtLog) {
    return LogEvent(
      dtLog.requestedAt ?? DateTime.now(),
      dtLog.retryCount ?? 0,
      dtLog.color! == 'red' ? EventType.red : EventType.black,
      dtLog.hasFinished ?? false,
    );
  }

  DtLog mapToDtLog(LogEvent logEvent) {
    final dtLog = DtLog();
    dtLog.requestedAt = logEvent.time;
    dtLog.retryCount = logEvent.retry;
    dtLog.hasFinished = logEvent.isSuccess;
    return dtLog;
  }
}
