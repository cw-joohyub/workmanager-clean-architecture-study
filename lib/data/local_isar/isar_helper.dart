
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'dt_log.dart';
import 'dt_number.dart';
import 'dt_task.dart';

class IsarHelper {

  static const String _isarInstanceName = 'isarInstance';

  static Future<Isar> getInstance() async {
    Isar? isar = Isar.getInstance(_isarInstanceName);
    isar ??= await _open();
    return isar;
  }

  static Future<Isar> _open() async {
    final dir = await getApplicationDocumentsDirectory();
    return Isar.open(
      [DtNumberSchema ,DtLogSchema ,DtTaskSchema],
      directory: dir.path,
      name: _isarInstanceName,
    );
  }

}