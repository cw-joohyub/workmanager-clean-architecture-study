import 'dart:math';

import 'package:injectable/injectable.dart';

@injectable
class NumberRemoteDatasource {
  Future<bool> postAddEvent(int fakeDelayMilliseconds, int successRate) async {
    return Future<bool>.delayed(Duration(milliseconds: fakeDelayMilliseconds), () {
      return Random().nextInt(100) < successRate;
    });
  }
}
