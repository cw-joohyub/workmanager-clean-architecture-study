import 'dart:convert';

import 'package:workmanager/workmanager.dart';

class WorkManagerConstraint {
  final Duration? initialDelay;
  final Duration? restartDuration;
  final bool? isNetworkCheck;
  final int? retryCount;
  final BackoffPolicy? backOffPolicy;

  const WorkManagerConstraint({
    Duration? initialDelay,
    Duration? restartDuration,
    bool? isNetworkCheck,
    int? retryCount,
    BackoffPolicy? backOffPolicy,
  })  : initialDelay = initialDelay ?? const Duration(milliseconds: 500),
        restartDuration = restartDuration ?? const Duration(seconds: 1),
        isNetworkCheck = isNetworkCheck ?? false,
        retryCount = retryCount ?? 3,
        backOffPolicy = backOffPolicy ?? BackoffPolicy.exponential;

  factory WorkManagerConstraint.fromDefault() {
    return const WorkManagerConstraint(
      initialDelay: Duration(milliseconds: 500),
      restartDuration: Duration(seconds: 1),
      isNetworkCheck: false,
      retryCount: 3,
      backOffPolicy: BackoffPolicy.exponential,
    );
  }

  @override
  String toString() {
    return 'WorkManagerConstraint{initialDelay: $initialDelay, '
        'restartDuration: $restartDuration, isNetworkCheck: $isNetworkCheck, '
        'retryCount: $retryCount, backOffPolicy: $backOffPolicy}';
  }

  Map<String, dynamic> toJson() {
    return {
      'initialDelay': initialDelay?.inMilliseconds,
      'restartDuration': restartDuration?.inMilliseconds,
      'isNetworkCheck': isNetworkCheck,
      'retryCount': retryCount,
      'backOffPolicy': backOffPolicy?.toString().split('.')[1] ?? '',
      // Interpolation with null check
    };
  }

  factory WorkManagerConstraint.fromJson(Map<String, dynamic> json) {
    return WorkManagerConstraint(
      initialDelay:
          json['initialDelay'] != null ? Duration(milliseconds: json['initialDelay']) : null,
      restartDuration:
          json['restartDuration'] != null ? Duration(milliseconds: json['restartDuration']) : null,
      isNetworkCheck: json['isNetworkCheck'] is bool
          ? json['isNetworkCheck'] as bool
          : json['isNetworkCheck'] is String
              ? json['isNetworkCheck'].toLowerCase() == 'true'
              : false,
      retryCount: json['retryCount'] ?? 0,
      backOffPolicy: json['backOffPolicy'] != null
          ? BackoffPolicy.values.firstWhere(
              (e) => e.toString() == 'BackoffPolicy.${json['backOffPolicy']}',
              orElse: () => BackoffPolicy.exponential,
            )
          : BackoffPolicy.exponential,
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory WorkManagerConstraint.fromJsonString(String jsonString) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return WorkManagerConstraint.fromJson(jsonMap);
  }
}
