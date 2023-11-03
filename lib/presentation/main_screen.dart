import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/di/di.dart';
import 'package:workmanager_clean_architecture_sample/presentation/cubit/work_manager_cubit.dart';
import 'package:workmanager_clean_architecture_sample/presentation/widget/log_list_tile.dart';
import 'package:workmanager_clean_architecture_sample/usecase/number_usecase.dart';

import '../data/work_manager/work_manager.dart';
import '../util/gaps.dart';

const redTaskKey = 'red_task';
const blackTaskKey = 'black_task';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => getIt<WorkManagerCubit>()..init(),
        child: BlocBuilder<WorkManagerCubit, WorkManagerState>(
          builder: (BuildContext context, WorkManagerState state) {
            // WorkManagerCubit cubit = context.read<WorkManagerCubit>();

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('WorkManager Demo'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Gaps.vGap10,
                  _buildCountView(context, state),
                  const SizedBox(height: 20),
                  _buildButtonView(context),
                  const SizedBox(height: 20),
                  _buildLogListView(state),
                ],
              ),
            );
          },
        ));
  }

  Widget _buildCountView(BuildContext context, WorkManagerState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GlassContainer(
          borderRadius: BorderRadius.circular(20),
          height: 180,
          width: 180,
          color: Colors.red,
          gradient: LinearGradient(
            colors: [Colors.red.withOpacity(0.40), Colors.red.withOpacity(0.10)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderGradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.60),
              Colors.white.withOpacity(0.10),
              Colors.black12.withOpacity(0.01),
              Colors.black12.withOpacity(0.1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.39, 0.40, 1.0],
          ),
          child: Center(
            child: Text(
              '${state.redCount}',
              style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),
            ),
          ),
        ),
        GlassContainer(
          borderRadius: BorderRadius.circular(20),
          height: 180,
          width: 180,
          color: Colors.black,
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.40), Colors.black.withOpacity(0.10)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderGradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.60),
              Colors.white.withOpacity(0.10),
              Colors.black12.withOpacity(0.01),
              Colors.black12.withOpacity(0.1)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.39, 0.40, 1.0],
          ),
          child: Center(
            child: Text(
              '${state.blackCount}',
              style: Theme.of(context).textTheme.headlineMedium?.apply(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonView(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        GFButton(
          onPressed: () {
            Workmanager().initialize(
                callbackDispatcher, // The top level function, aka callbackDispatcher
                isInDebugMode:
                true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
            );          },
          color: Colors.amber,
          size: GFSize.MEDIUM,
          text: 'WM Reset',
        ),

        GFButton(
          onPressed: () {
            context.read<WorkManagerCubit>().plusOneNumber('red');
          },
          color: Colors.red,
          size: GFSize.LARGE,
          text: '+1 to Red (after 1s)',
        ),
        GFButton(
          onPressed: () {
            context.read<WorkManagerCubit>().plusOneNumber('black');
          },
          color: Colors.black,
          size: GFSize.LARGE,
          text: '+1 to Black (after 1s)',
        ),
      ],
    );
  }

  Widget _buildLogListView(WorkManagerState state) {
    return Expanded(
      child: ListView(
        children: state.logEvents.map((LogEvent e) {
          return LogListTile(
              datetime: e.time, retry: e.retry, eventType: e.eventType, isSuccess: e.isSuccess);
        }).toList(),
      ),
    );
  }
}
