import 'dart:math';
import 'package:dart_ping/dart_ping.dart';
import 'package:injectable/injectable.dart';

const int successRate = 100;
const int fakeDelayMilliseconds = 10;

@injectable
class NumberRemoteDatasource {
  Future<bool> postAddEvent(String color) async {
    // final PingData result = await Ping('google.com', count: 1).stream.first;
    //
    // print('result - $result');
    // if (result.error != null) {
    //   print('error! - ${result.error}');
    //   return false;
    // }
    return Future<bool>.delayed(const Duration(milliseconds: fakeDelayMilliseconds), () {
      return Random().nextInt(100) < successRate;
    });

    // return Future<bool>.delayed(const Duration(milliseconds: fakeDelayMilliseconds), () {
    //
    //
    //   return Random().nextInt(100) <= successRate;
    // });
  }
}
