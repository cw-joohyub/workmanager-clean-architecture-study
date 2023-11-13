import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager_clean_architecture_sample/data/local_isar/isar_helper.dart';
import 'dt_log.dart';

abstract class LogLocalDatasource {
  Future<void> initDb();

  Future<int> addLog(String color, String logkey, bool remoteResult);

  Future<int> getFailureCount(String logkey);

  // Future<bool> updateLog(int key, bool remoteResult);

  Future<int> deleteAllByLogKey(String logKey);

  Future<bool> deleteAll();

  Future<Stream<void>?> watchLogChanged();

  Future<List<DtLog>?> getAllLog();

  Future<int> getAllCount(String color);
}

@Injectable(as: LogLocalDatasource)
class LogLocalDatasourceImpl extends LogLocalDatasource {
  Isar? isar;

  @override
  Future<void> initDb() async {
    isar = await IsarHelper.getInstance();
  }

  @override
  Future<int> addLog(String color, String logkey, bool remoteResult) async {
    if (isar == null) {
      await initDb();
    }
    try {
      final DtLog logData = DtLog()
        ..color = color
        ..logKey = logkey
        ..dateTime = DateTime.now()
        // ..lastAttemptedAt = zero
        // ..finishedAt = zero
        // ..retryCount = 0
        ..hasFinished = remoteResult;

      return await isar?.writeTxnSync(() {
            final id = isar?.dtLogs.putSync(logData);
            return id;
          }) ??
          0;
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  // @override
  // Future<bool> updateLog(int key, bool remoteResult) async {
  //   if (isar == null) {
  //     await initDb();
  //   }
  //   try {
  //     final DtLog? old = isar?.dtLogs.getSync(key); // get
  //
  //     if (old == null) {
  //       return false;
  //     }
  //
  //     old
  //       // ..lastAttemptedAt = DateTime.now()
  //       // ..finishedAt = DateTime.now()
  //       // ..retryCount = remoteResult ? old.retryCount : (old.retryCount! + 1)
  //       ..hasFinished = remoteResult;
  //
  //     isar?.writeTxnSync(() {
  //       final id = isar?.dtLogs.putSync(old);
  //       return id;
  //     });
  //
  //     return Future<bool>.value(true);
  //   } catch (e) {
  //     print(e);
  //     throw Exception();
  //   }
  // }

  @override
  Future<bool> deleteAll() async {
    if (isar == null) {
      await initDb();
    }

    return await isar?.writeTxnSync(() {
      isar?.dtLogs.clearSync();
      return true;
    }) ?? false;
  }

  @override
  Future<Stream<void>?> watchLogChanged() async {
    if (isar == null) {
      await initDb();
    }

    return isar?.dtLogs.watchLazy();
  }

  @override
  Future<List<DtLog>?> getAllLog() async {
    if (isar == null) {
      await initDb();
    }

    return isar?.dtLogs.where().findAll();
  }

  @override
  Future<int> getAllCount(String color) async {
    if (isar == null) {
      await initDb();
    }

    final int? result = isar?.dtLogs
        .filter()
        .hasFinishedEqualTo(true)
        .and()
        .colorEqualTo(color)
        .findAllSync()
        .length;

    return result ?? 0;
  }

  @override
  Future<int> getFailureCount(String logkey) async {
    if (isar == null) {
      await initDb();
    }

    final int? result = isar?.dtLogs
        .filter()
        .hasFinishedEqualTo(false)
        .and()
        .logKeyEqualTo(logkey)
        .findAllSync()
        .length;

    return result ?? 0;
  }

  @override
  Future<int> deleteAllByLogKey(String logKey) async {
    if (isar == null) {
      await initDb();
    }

    return await isar?.writeTxnSync(() {
          final int? result =
              isar?.dtLogs.filter().logKeyEqualTo(logKey).deleteAllSync();
          return result;
        }) ??
        0;
  }
}
