import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'dt_log.dart';

abstract class LogLocalDatasource {
  Future<void> initDb();

  Future<int> addLog(String color);

  Future<bool> updateLog(int key, bool remoteResult);

  Future<bool> deleteAll();

  Future<Stream<void>?> watchLogChanged();

  Future<List<DtLog>?> getAllLog();
}

@Injectable(as: LogLocalDatasource)
class LogLocalDatasourceImpl extends LogLocalDatasource {
  Isar? isar;
  static const String _isarInstanceName = 'logInstance';

  final DateTime zero = DateTime.fromMicrosecondsSinceEpoch(0);

  @override
  Future<void> initDb() async {
    isar = Isar.getInstance(_isarInstanceName);

    if (isar == null) {
      // try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [DtLogSchema],
        directory: dir.path,
        name: _isarInstanceName,
      );
      // } catch (exception) {
      //   print(exception.toString());
      //   throw Exception();
      // }
    }
  }

  @override
  Future<int> addLog(String color) async {
    if (isar == null) {
      await initDb();
    }
    try {
      final DtLog logData = DtLog()
        ..color = color
        ..requestedAt = DateTime.now()
        ..lastAttemptedAt = zero
        ..finishedAt = zero
        ..retryCount = 0
        ..hasFinished = false;

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

  @override
  Future<bool> updateLog(int key, bool remoteResult) async {
    if (isar == null) {
      await initDb();
    }
    try {
      final DtLog? old = isar?.dtLogs.getSync(key); // get

      if (old == null) {
        return false;
      }

      old
        ..lastAttemptedAt = DateTime.now()
        ..finishedAt = DateTime.now()
        ..retryCount = remoteResult ? old.retryCount : (old.retryCount! + 1)
        ..hasFinished = remoteResult;

      isar?.writeTxnSync(() {
        final id = isar?.dtLogs.putSync(old);
        return id;
      });

      return Future<bool>.value(true);
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<bool> deleteAll() async {
    if (isar == null) {
      await initDb();
    }

    isar?.dtLogs.clearSync();

    return Future<bool>.value(true);
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
}
