import 'package:workmanager/workmanager.dart';

import '../di/di.dart';
import '../usecase/red_usecase.dart';

const redTaskKey = 'red_task';
const blackTaskKey = 'black_task';

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print(
        "Native called background task: $task"); //simpleTask will be emitted here.
    //TODO(nm-JihunCha): getIt을 여기서 해줘야하나...
    getItInit();

    switch (task) {
      case redTaskKey:
        getIt<RedUsecase>().doSomething();
        break;
      case blackTaskKey:
        print('blackTaskKey');
        break;
    }
    return Future.value(true);
  });
}
