import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/dt_log.dart';
import 'package:workmanager_clean_architecture_sample/data/mapper/log_event_mapper.dart';
import 'package:workmanager_clean_architecture_sample/presentation/cubit/work_manager_cubit.dart';

import '../../di/di.dart';
import '../local_isar/log_local_datasource.dart';
import '../local_isar/number_local_datasource.dart';
import '../work_manager/work_manager.dart';

@injectable
class NumberRepository {
  NumberRepository(this._numberLocalDatasource, this._logLocalDatasource);

  static int successRate = 100;
  static int fakeDelayMilliseconds = 10;
  static bool isImprovedAppend = false;
  static bool isPeriodicTask = false;

  final NumberLocalDatasource _numberLocalDatasource;
  final LogLocalDatasource _logLocalDatasource;

  static void setOption(
      {int? successRate, int? fakeDelayMilliseconds, bool? isImprovedAppend, bool? isPeriodicTask}) {
    NumberRepository.successRate = successRate ?? NumberRepository.successRate;
    NumberRepository.fakeDelayMilliseconds =
        fakeDelayMilliseconds ?? NumberRepository.fakeDelayMilliseconds;
    NumberRepository.isImprovedAppend =
        isImprovedAppend ?? NumberRepository.isImprovedAppend;
    NumberRepository.isPeriodicTask =
        isPeriodicTask ?? NumberRepository.isPeriodicTask;
  }

  Future<int> getNumber(String color) async {
    return _numberLocalDatasource.getNumber(color);
  }

  Future<Stream<void>?> watchChange(String color) {
    print('watchChange - $color');

    return _numberLocalDatasource.watchChange(color);
  }

  Future<Stream<void>?> watchLogChanged() =>
      _logLocalDatasource.watchLogChanged();

  Future<List<LogEvent>> getAllLog() async {
    List<DtLog>? dtLogList = await _logLocalDatasource.getAllLog();

    if (dtLogList == null) {
      return [];
    }

    List<LogEvent> result = dtLogList
        .map((DtLog log) => LogEventMapper().mapToLogEvent(log))
        .toList();

    return result;
  }

  Future<int> getLastNumber(String color) async {
    return await _logLocalDatasource.getAllCount(color);

    // return await _numberLocalDatasource.getNumber(color);
  }

  Future<void> postPlusOne(String color) async {
    final String taskKey =
        color == 'red' ? plusOneToRedTaskKey : plusOneToBlackTaskKey;
    // final int logKey = await _logLocalDatasource.addLog(color);

    // print('postPlusOne : $color, $logKey');

    //Work Unique keys
    // Workmanager().registerOneOffTask('$taskKey$logKey', taskKey,
    //     inputData: <String, dynamic>{
    //       'logKey': logKey,
    //     },
    //     // constraints: Constraints(networkType: NetworkType.connected),
    //     backoffPolicy: BackoffPolicy.linear,
    //     backoffPolicyDelay: const Duration(milliseconds: 500),
    //     initialDelay: const Duration(milliseconds: 100),
    //     existingWorkPolicy: ExistingWorkPolicy.append,
    //     outOfQuotaPolicy: OutOfQuotaPolicy.run_as_non_expedited_work_request,);

    // Work Unique keys

    String logKey = const Uuid().v4();
    // for (int i = 0; i < 3; i++) {
    await getIt<LogLocalDatasource>().addLog(color, logKey, false);

    if (isPeriodicTask) {
      Workmanager().registerPeriodicTask(
        iosTest,
        iosTest,
        inputData: <String, dynamic>{
          'color': color,
          'taskKey': taskKey,
          'logKey': logKey,
          'successRate': successRate,
          'fakeDelayMilliseconds': fakeDelayMilliseconds,
          'isImprovedAppend': isImprovedAppend,
          'isPeriodicTask': isPeriodicTask,
        },
        frequency: const Duration(seconds: 5),
        // constraints: Constraints(networkType: NetworkType.connected),
        backoffPolicy: BackoffPolicy.linear,
        backoffPolicyDelay: const Duration(milliseconds: 500),
        initialDelay: const Duration(milliseconds: 100),
        existingWorkPolicy: ExistingWorkPolicy.append,
        // outOfQuotaPolicy: OutOfQuotaPolicy.run_as_non_expedited_work_request,
      );
    }else {

      Workmanager().registerOneOffTask(
        iosTest,
        iosTest,
        inputData: <String, dynamic>{
          'color': color,
          'taskKey': taskKey,
          'logKey': logKey,
          'successRate': successRate,
          'fakeDelayMilliseconds': fakeDelayMilliseconds,
          'isImprovedAppend': isImprovedAppend,
          'isPeriodicTask': isPeriodicTask,
        },
        // constraints: Constraints(networkType: NetworkType.connected),
        backoffPolicy: BackoffPolicy.linear,
        backoffPolicyDelay: const Duration(milliseconds: 500),
        initialDelay: const Duration(milliseconds: 100),
        existingWorkPolicy: ExistingWorkPolicy.append,
        // outOfQuotaPolicy: OutOfQuotaPolicy.run_as_non_expedited_work_request,
      );
    }
  }
}
