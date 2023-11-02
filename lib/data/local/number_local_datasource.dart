import 'dart:io';

import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'number_data.dart';

abstract class NumberLocalDatasource {
  Future<bool> initDb();

  Future<bool> setNumber(String color, int number);
  Future<int> getNumber(String color);
  Future<bool> plusOneNumber(String color);

  Future<bool> deleteAll();
}

@Injectable(as: NumberLocalDatasource)
class NumberLocalDatasourceImpl extends NumberLocalDatasource {
  bool isInitialized = false;
  final String _kBox = 'number_data_box';

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
      if (!Hive.isAdapterRegistered(0)) {
        Hive.registerAdapter(NumberDataAdapter());
      }
      await Hive.openBox<NumberData>(_kBox);
      isInitialized = true;

      Box<NumberData> numberBox = Hive.box<NumberData>(_kBox);

      if(!numberBox.containsKey('red')) {
        numberBox.put('red', NumberData(value: 0));
        numberBox.put('black', NumberData(value: 0));
      }

      return true;
    } catch (_) {
      throw Exception();
    }
  }


  @override
  Future<bool> setNumber(String color, int number) async {
    if (!isInitialized) {
      await initDb();
    }
    try {
      final Box<NumberData> numberBox = Hive.box<NumberData>(_kBox);
      final NumberData numberData = NumberData(value: number);

      await numberBox.put(color, numberData);
      return Future<bool>.value(true);
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future<int> getNumber(String color) async {
    if (!isInitialized) {
      await initDb();
    }
    try {
      final Box<NumberData> numberBox = Hive.box<NumberData>(_kBox);
      final NumberData numberData = numberBox.get(color)!;
      return numberData.value;
    } catch (_) {
      throw Exception();
    }
  }

  @override
  Future<bool> plusOneNumber(String color) async {
    print('plusOneNumber : $color');
    if (!isInitialized) {
      await initDb();
    }
    try {
      final Box<NumberData> numberBox = Hive.box<NumberData>(_kBox);
      NumberData old = numberBox.get(color)!;

      final NumberData newNumberData = NumberData(value: old.value + 1);
      await numberBox.put(color, newNumberData);

      print('Hive : plusOneNumber - $color done : newData(${newNumberData.value}) ');

      return Future<bool>.value(true);
    } catch (exception) {
      print (exception.toString());
      throw Exception();
    }
  }

  @override
  Future<bool> deleteAll() async {
    if (!isInitialized) {
      await initDb();
    }
    final Box<NumberData> numberBox = Hive.box<NumberData>(_kBox);
    await numberBox.clear();
    return Future<bool>.value(true);
  }
}
