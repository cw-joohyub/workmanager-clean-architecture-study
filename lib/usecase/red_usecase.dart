import 'package:injectable/injectable.dart';

abstract class RedUsecase {
  void doSomething();
}

@Injectable(as: RedUsecase)
class RedUsecaseImpl extends RedUsecase {
  @override
  void doSomething() {
    print('RedUsecaseImpl/doSomething');
  }
}
