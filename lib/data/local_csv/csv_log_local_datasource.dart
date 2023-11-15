import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';

import 'dt_csv_log.dart';

@injectable
class CsvLogLocalDataSource {

  static const String filePath = 'log.csv';

  // CsvLogLocalDataSource();

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> appendLog(DtCsvLog log) async {
    final file = File('${await _localPath}/$filePath');
    final logLine = _convertLogToCsvLine(log);

    // Check if the file exists, if not create it and add a header line
    if (!await file.exists()) {
      await file.create();
      await file.writeAsString('color,id,timestamp,isFinished,desc\n');
    }

    // Append the log line to the file
    await file.writeAsString(logLine, mode: FileMode.append);
  }

  String _convertLogToCsvLine(DtCsvLog log) {
    List<String> values = [
      log.color,
      log.id,
      log.timestamp,
      log.isFinished.toString(),
      log.desc ?? ''
    ];

    // Escape commas and double quotes in CSV
    var csvValues = values.map(_escapeCsvValue).toList();
    return '${csvValues.join(',')}\n';
  }

  String _escapeCsvValue(String value) {
    // If the value contains a comma, newline or double quote, enclose it in double quotes
    if (value.contains(',') || value.contains('\n') || value.contains('"')) {
      // Replace any existing double quotes with two double quotes (standard CSV escaping)
      value = value.replaceAll('"', '""');
      // Enclose in double quotes
      return '"$value"';
    }
    return value;
  }
}