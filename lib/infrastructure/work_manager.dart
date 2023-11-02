import 'dart:math';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architectue_sample/presentation/cubit/work_manager_cubit.dart';

import '../di/di.dart';
import '../usecase/black_usecase.dart';
import '../usecase/number_usecase.dart';

const redTaskKey = 'red_task';
const blackTaskKey = 'black_task';

const redTaskRetryKey = 'red_task_retry';
const blackTaskRetryKey = 'black_task_retry';

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Native called background task: $task"); //simpleTask will be emitted here.
    //TODO(nm-JihunCha): getIt을 여기서 해줘야하나...
    getItInit();
    Random random = Random();
    int probability = random.nextInt(2);
    final prefs = await SharedPreferences.getInstance();
    switch (task) {
      case redTaskKey:
        if (probability != 0) {
          WorkManagerCubit(getIt<NumberUsecase>()).plusOneNumber(inputData!['taskName']);
          // getIt<RedUsecase>().addLog(inputData['taskName'], prefs.getInt(redTaskKey));

          return true;
        } else {
          if (!prefs.containsKey(redTaskRetryKey)) {
            prefs.setInt(redTaskRetryKey, 1);
          } else {
            int retryCount = prefs.getInt(redTaskRetryKey)!;
            print('retryCount - $retryCount');

            if (retryCount > 2) {
              //addlog
              return Future.error('failed');
            }

            prefs.setInt(redTaskRetryKey, retryCount + 1);
            return false;
          }

          return false;
        }
      case blackTaskKey:
        if (probability != 0) {
          WorkManagerCubit(getIt<NumberUsecase>()).plusOneNumber(inputData!['taskName']);
          // getIt<BlackUsecase>().addLog(inputData['taskName'], prefs.getInt(blackTaskKey)!);
          return true;
        } else {
          if (!prefs.containsKey(blackTaskRetryKey)) {
            prefs.setInt(blackTaskRetryKey, 1);
          } else {
            int retryCount = prefs.getInt(blackTaskRetryKey)!;
            print('retryCount - $retryCount');

            if (retryCount > 2) {
              //addlog
              return Future.error('failed');
            }

            prefs.setInt(blackTaskRetryKey, retryCount + 1);
            return false;
          }

          return false;
        }
    }
    return true;
  });
}
