import 'dart:math';
import 'package:injectable/injectable.dart';

const int successRate = 70;
const int fakeDelayMilliseconds = 10;

@injectable
class NumberRemoteDatasource {
  Future<bool> postAddEvent(String color) async {
    return Future<bool>.delayed(const Duration(milliseconds: fakeDelayMilliseconds), () {
      return Random().nextInt(100) <= successRate;
    });
  }
}
