import 'dart:convert';

class WorkManagerConstraint {
  final Duration? initialDelay;
  final Duration? restartDuration;
  final bool? isNetworkCheck;
  final int? retryCount;

  WorkManagerConstraint({
    Duration? initialDelay,
    Duration? restartDuration,
    bool? isNetworkCheck,
    int? retryCount,
  })  : initialDelay = initialDelay ?? const Duration(milliseconds: 500),
        restartDuration = restartDuration ?? const Duration(seconds: 1),
        isNetworkCheck = isNetworkCheck ?? false,
        retryCount = retryCount ?? 3;

  Map<String, dynamic> toJson() {
    return {
      'initialDelay': initialDelay?.inMilliseconds,
      'restartDuration': restartDuration?.inMilliseconds,
      'isNetworkCheck': isNetworkCheck,
      'retryCount': retryCount,
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
