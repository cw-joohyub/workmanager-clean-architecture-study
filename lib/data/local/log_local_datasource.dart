import 'dart:io';

import 'package:flutter/foundation.dart' as foundation;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'log_data.dart';


abstract class LogLocalDatasource {
  Future<bool> initDb();
  Future<int> addLog(String color);
  Future<bool> updateLog(int key, bool remoteResult);
  Future<bool> deleteAll();
}

@Injectable(as: LogLocalDatasource)
class LogLocalDatasourceImpl extends LogLocalDatasource {
  bool isInitialized = false;
  final String _kBox = 'log_box';
  final DateTime zero = DateTime.fromMicrosecondsSinceEpoch(0);

  @override
  Future<bool> initDb() async {
    final String dir = (await getApplicationDocumentsDirectory()).path;

    print ('initDb : $dir');

    if (isInitialized) {
      return true;
    }

    try {
      if (!foundation.kIsWeb) {
        final Directory appDocumentDir = await getApplicationDocumentsDirectory();
        Hive.init(appDocumentDir.path);
      }
      if (!Hive.isAdapterRegistered(1)) {
        Hive.registerAdapter(LogDataAdapter());
      }
      await Hive.openBox<LogData>(_kBox);
      isInitialized = true;
      return true;
    } catch (exception) {
      print(exception.toString());
      throw Exception();
    }
  }


  @override
  Future<int> addLog(String color) async {
    if (!isInitialized) {
      await initDb();
    }
    try {
      final Box<LogData> logBox = Hive.box<LogData>(_kBox);
      final LogData logData = LogData(color: color,
          requestedAt: DateTime.now(),
          lastAttemptedAt: zero,
          finishedAt: zero,
          retryCount: 0,
          hasFinished: false);

      return logBox.add(logData);
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future<bool> updateLog(int key, bool remoteResult) async {
    if (!isInitialized) {
      await initDb();
    }
    try {
      final Box<LogData> logBox = Hive.box<LogData>(_kBox);
      LogData old = logBox.get(key)!;
      final LogData newData;
      if (remoteResult) {
        newData = LogData(
            color: old.color, requestedAt: old.requestedAt, lastAttemptedAt: DateTime.now(),
            finishedAt: DateTime.now(),retryCount: old.retryCount, hasFinished: true);
      } else {
        newData = LogData(
            color: old.color, requestedAt: old.requestedAt, lastAttemptedAt: DateTime.now(),
            finishedAt: old.finishedAt,retryCount: old.retryCount + 1, hasFinished: false);
      }
      await logBox.put(key, newData);

      return Future<bool>.value(true);
    } catch (_) {
      throw Exception();
    }
  }


  @override
  Future<bool> deleteAll() async {
    if (!isInitialized) {
      await initDb();
    }
    final Box<LogData> logBox = Hive.box<LogData>(_kBox);
    await logBox.clear();
    return Future<bool>.value(true);
  }


}