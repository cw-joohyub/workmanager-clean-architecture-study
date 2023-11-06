import 'package:isar/isar.dart';

part 'dt_log.g.dart';

@collection
class DtLog {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? color;

  DateTime? requestedAt;

  DateTime? lastAttemptedAt;

  DateTime? finishedAt;

  int? retryCount;

  bool? hasFinished;

  @override
  String toString() {
    return 'DtLog{id: $id, color: $color, requestedAt: $requestedAt, lastAttemptedAt: $lastAttemptedAt, finishedAt: $finishedAt, retryCount: $retryCount, hasFinished: $hasFinished}';
  }
}
