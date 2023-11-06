extension DurationMeasurement on Duration {
  static Duration measure(void Function() codeBlock) {
    final stopwatch = Stopwatch()..start();  // 스톱워치 시작
    codeBlock();  // 코드 블록 실행
    stopwatch.stop();  // 스톱워치 중지
    return stopwatch.elapsed;  // 경과 시간 반환
  }
}