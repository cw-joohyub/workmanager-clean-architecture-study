import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:workmanager_clean_architectue_sample/presentation/cubit/work_manager_cubit.dart';
import 'package:workmanager_clean_architectue_sample/presentation/widget/log_list_tile.dart';

import '../util/gaps.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => WorkManagerCubit(),
        child: BlocBuilder<WorkManagerCubit, WorkManagerState>(
          builder: (BuildContext context, WorkManagerState state) {
            WorkManagerCubit cubit = context.read<WorkManagerCubit>();

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
                  _buildButtonView(cubit),
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
            colors: [
              Colors.red.withOpacity(0.40),
              Colors.red.withOpacity(0.10)
            ],
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
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.apply(color: Colors.white),
            ),
          ),
        ),
        GlassContainer(
          borderRadius: BorderRadius.circular(20),
          height: 180,
          width: 180,
          color: Colors.black,
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.40),
              Colors.black.withOpacity(0.10)
            ],
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
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.apply(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonView(WorkManagerCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GFButton(
          onPressed: () {
            // Workmanager().registerOneOffTask(
            //   redTaskKey,
            //   redTaskKey,
            //   constraints: Constraints(networkType: NetworkType.connected),
            // );
          },
          color: Colors.red,
          size: GFSize.LARGE,
          text: '+1 to Red (after 1s)',
        ),
        GFButton(
          onPressed: () {
            // Workmanager().registerOneOffTask(
            //   blackTaskKey,
            //   blackTaskKey,
            //   constraints: Constraints(networkType: NetworkType.connected),
            // );
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
              datetime: e.time,
              retry: e.retry,
              eventType: e.eventType,
              isSuccess: e.isSuccess);
        }).toList(),
      ),
    );
  }
}
