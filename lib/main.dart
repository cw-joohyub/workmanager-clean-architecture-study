import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architectue_sample/presentation/main_screen.dart';

import 'di/di.dart';
import 'infrastructure/work_manager.dart';

void main() {
  getItInit();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  Workmanager().initialize(
      callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

