import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/presentation/main_screen.dart';

import 'data/util/callback_dispatcher.dart';
import 'di/di.dart';

void main() async {
  getItInit();
  WidgetsFlutterBinding.ensureInitialized();
  Workmanager().initialize(callbackDispatcher, // The top level function, aka callbackDispatcher
      isInDebugMode:
      true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
  );
  runApp(const MyApp());
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

/*class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late NumberRepository _numberRepository;
  final ReceivePort _port = ReceivePort();

  int redCount = 0;
  int blackCount = 0;

  @override
  void initState() {
    _numberRepository = getIt<NumberRepository>();
    IsolateNameServer.registerPortWithName(_port.sendPort, "backgroundtask");
    // await _numberRepository.init();
    _port.listen((dynamic data) {
      reload();
    });

    reload();

    super.initState();
  }


  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('backgroundtask');
    super.dispose();
  }


  Future<void> reload() async {
    print ('_MyHomePageState : reload');
    final newRedCount = await _numberRepository.getNumber('red');
    final newBlackCount = await _numberRepository.getNumber('black');

    setState(() {
      redCount = newRedCount;
      blackCount = newBlackCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child:  Text(
                '${(redCount ?? 0)}',
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
                  '${(blackCount ?? 0)}',
                  style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),
                ),
              )),
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
            // _numberRepository.postPlusOne('red');

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
            _numberRepository.postPlusOne('black');
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
}*/
