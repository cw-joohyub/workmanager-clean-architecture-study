import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architectue_sample/usecase/red_usecase.dart';

import 'di/di.dart';

const redTaskKey = 'red_task';
const blackTaskKey = 'black_task';

void main() {
  getItInit();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  Workmanager().initialize(callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
}

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    print("Native called background task: $task"); //simpleTask will be emitted here.
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildCountView(),
          const SizedBox(height: 20),
          _buildButtonView(),
          const SizedBox(height: 20),
          _buildLogListView(),
        ],
      ),
    );
  }

  Widget _buildCountView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Container(
            color: Colors.red,
            height: 200,
            child: Center(
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.black,
            height: 200,
            child: Center(
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonView() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          onPressed: () {
            Workmanager().registerOneOffTask(
              redTaskKey,
              redTaskKey,
              constraints: Constraints(networkType: NetworkType.connected),
            );
          },
          child: Text(
            '+1 to Red (after 1s)',
            style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          onPressed: () {
            Workmanager().registerOneOffTask(
              blackTaskKey,
              blackTaskKey,
              constraints: Constraints(networkType: NetworkType.connected),
            );
          },
          child: Text(
            '+1 to Black (after 1s)',
            style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _buildLogListView() {
    return Expanded(
      child: ListView(
        children: List<Widget>.generate(10, (index) {
          return ListTile(
            title: Text('Log $index'),
          );
        }),
      ),
    );
  }
}
