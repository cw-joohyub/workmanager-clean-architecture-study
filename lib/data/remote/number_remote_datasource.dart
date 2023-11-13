import 'dart:math';

import 'package:injectable/injectable.dart';

@injectable
class NumberRemoteDatasource {

  Future<bool> postAddEvent(String color, int fakeDelayMilliseconds, int successRate) async {
    // final PingData result = await Ping('google.com', count: 1).stream.first;
    //
    // print('result - $result');
    // if (result.error != null) {
    //   print('error! - ${result.error}');
    //   return false;
    // }
    return Future<bool>.delayed(Duration(milliseconds: fakeDelayMilliseconds), () {
      return Random().nextInt(100) < successRate;
    });

    // return Future<bool>.delayed(const Duration(milliseconds: fakeDelayMilliseconds), () {
    //
    //
    //   return Random().nextInt(100) <= successRate;
    // });
  }
}
