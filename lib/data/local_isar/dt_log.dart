import 'package:isar/isar.dart';

part 'dt_log.g.dart';

@collection
class DtLog {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? logKey;

  String? color;

  // DateTime? requestedAt;
  //
  // DateTime? lastAttemptedAt;
  //
  // DateTime? finishedAt;

  DateTime? dateTime;

  // int? retryCount;

  bool? hasFinished;

  @override
  String toString() {
    return 'DtLog{id: $id, logKey : $logKey, color: $color, requestedAt: $dateTime, hasFinished: $hasFinished}';
  }

// @override
// String toString() {
//   return 'DtLog{id: $id, color: $color, requestedAt: $requestedAt, lastAttemptedAt: $lastAttemptedAt, finishedAt: $finishedAt, retryCount: $retryCount, hasFinished: $hasFinished}';
// }
}
