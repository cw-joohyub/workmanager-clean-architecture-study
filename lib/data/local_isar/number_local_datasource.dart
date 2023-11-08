import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'dt_log.dart';
import 'dt_number.dart';

abstract class NumberLocalDatasource {
  Future<void> initDb();

  Future<Stream<void>?> watchChange(String color);

  Future<bool> setNumber(String color, int number);

  Future<int> getNumber(String color);

  Future<bool> plusOneNumber(String color);

  Future<bool> deleteAll();
}

@Injectable(as: NumberLocalDatasource)
class NumberLocalDatasourceImpl extends NumberLocalDatasource {
  Isar? isar;
  static const String _isarInstanceName = 'numberInstance';

  final DateTime zero = DateTime.fromMicrosecondsSinceEpoch(0);

  @override
  Future<void> initDb() async {
    isar = Isar.getInstance(_isarInstanceName);

    if (isar == null) {
      // try {
      final dir = await getApplicationDocumentsDirectory();
      isar = await Isar.open(
        [DtNumberSchema, DtLogSchema],
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
  Future<bool> setNumber(String color, int number) async {
    if (isar == null) {
      await initDb();
    }
    try {
      final DtNumber numberData = DtNumber()
        ..id = _getId(color)
        ..value = number;

      await isar?.writeTxnSync(() async {
        isar?.dtNumbers.putSync(numberData);
      });

      return false;
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  @override
  Future<int> getNumber(String color) async {
    if (isar == null) {
      await initDb();
    }
    try {
      // final DtNumber? numberData = isar?.dtNumbers.getSync(_getId(color)); // get

      final List<DtNumber>? resultList = await isar?.dtNumbers.where().findAll();

      print('getNumber ${resultList?.last.toString()}');
      return resultList?.last.value ?? 0;
    } catch (e) {
      print('getNumber/exception $e');
      throw Exception();
    }
  }

  @override
  Future<Stream<void>?> watchChange(String color) async {
    if (isar == null) {
      await initDb();
    }

    return isar?.dtNumbers.watchLazy();
    // return isar?.dtNumbers.watchLazy(_getId(color)).map<int>((DtNumber? number) {
    //   print('watchChange/result - $color / ${number?.id} / ${number?.value}');
    //   return number?.value ?? 0;
    // });
  }

  @override
  Future<bool> plusOneNumber(String color) async {
    if (isar == null) {
      await initDb();
    }
    try {
      // final DtNumber? old = await isar?.dtNumbers.getSync(_getId(color)); // get
      // final List<DtNumber>? resultList = isar?.dtNumbers.where().findAllSync();

      isar?.writeTxnSync(() {
        final DtNumber newNumberData;
        final bool? isEmpty = isar?.dtNumbers.where().isEmptySync();

        if (isEmpty != null && isEmpty) {
          newNumberData = DtNumber()
            ..id = 0
            ..value = 1;
        } else {
          final List<DtNumber>? resultList = isar?.dtNumbers.where().findAllSync();
          newNumberData = DtNumber()..value = (resultList!.last.value! + 1);
        }

        isar?.dtNumbers.putSync(newNumberData);
        return true;
      });

      return Future<bool>.value(true);
    } catch (exception) {
      print('test - ${exception.toString()}');
      throw Exception();
    }
  }

  @override
  Future<bool> deleteAll() async {
    if (isar == null) {
      await initDb();
    }

    isar?.dtNumbers.clearSync();

    return Future<bool>.value(true);
  }

  int _getId(String color) {
    if (color == 'red') {
      return 0;
    } else {
      return 1;
    }
  }
}
