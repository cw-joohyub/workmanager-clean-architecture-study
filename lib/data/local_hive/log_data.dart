import 'package:hive/hive.dart';

part 'log_data.g.dart';

@HiveType(typeId: 1)
class LogData {
  LogData({
    required this.color,
    required this.requestedAt,
    required this.lastAttemptedAt,
    required this.finishedAt,
    required this.retryCount,
    required this.hasFinished,
  });

  @HiveField(0)
  final String color;

  @HiveField(1)
  final DateTime requestedAt;

  @HiveField(2)
  final DateTime lastAttemptedAt;

  @HiveField(3)
  final DateTime finishedAt;

  @HiveField(4)
  final int retryCount;

  @HiveField(5)
  final bool hasFinished;
}
