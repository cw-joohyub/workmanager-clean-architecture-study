import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:workmanager_clean_architectue_sample/presentation/cubit/work_manager_cubit.dart';
import 'package:workmanager_clean_architectue_sample/presentation/widget/counter_panel.dart';
import 'package:workmanager_clean_architectue_sample/presentation/widget/log_list_tile.dart';
import 'package:workmanager_clean_architectue_sample/presentation/widget/work_process_plot.dart';

import '../di/di.dart';
import '../util/gaps.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => getIt<WorkManagerCubit>(),
        child: BlocBuilder<WorkManagerCubit, WorkManagerState>(
          builder: (BuildContext context, WorkManagerState state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('WorkManager Demo'),
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Gaps.vGap10,
                  [
                    const CounterPanel(EventType.red),
                    const CounterPanel(EventType.black)
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround),
                  const SizedBox(height: 20),
                  [
                    _buildWorkStartButton(context, EventType.red),
                    _buildWorkStartButton(context, EventType.black)
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: [
                      _buildLogListView(state),
                      Gaps.hGap10,
                      WorkProcessPlot(),
                      Gaps.hGap30,
                    ].toRow(),
                  )
                ],
              ),
            );
          },
        ));
  }

  Widget _buildWorkStartButton(BuildContext context, EventType type) {
    final WorkManagerCubit cubit = context.read<WorkManagerCubit>();

    return GFButton(
      onPressed: () {
        cubit.plusOneNumberMock(type);
      },
      onLongPress: () {
        for (int i = 0; i < 100; i++) {
          cubit.plusOneNumberMock(type);
        }
      },
      color: type == EventType.red ? Colors.red : Colors.black,
      size: GFSize.LARGE,
      text: '+1 to ${type.name} (after 1s)',
    );
  }

  Widget _buildLogListView(WorkManagerState state) {
    return SizedBox(
      width: 400,
      height: 300,
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
