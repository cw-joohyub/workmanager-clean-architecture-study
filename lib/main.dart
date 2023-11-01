import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
          true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
      );
  runApp(const MyApp());
}

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    print("Native called background task: $task"); //simpleTask will be emitted here.
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
            Workmanager().registerOneOffTask("task-identifier", "simpleTask");
          },
          child: Text(
            '+1 to Red (after 1s)',
            style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
          onPressed: () {},
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
