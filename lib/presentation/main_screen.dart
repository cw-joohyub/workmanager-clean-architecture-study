import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:workmanager_clean_architecture_sample/di/di.dart';
import 'package:workmanager_clean_architecture_sample/presentation/cubit/work_manager_cubit.dart';
import 'package:workmanager_clean_architecture_sample/presentation/widget/event_log_panel.dart';
import 'package:workmanager_clean_architecture_sample/presentation/widget/option_panel.dart';
import 'package:workmanager_clean_architecture_sample/presentation/widget/remain_event_log_panel.dart';

import '../data/local_isar/dt_task.dart';
import '../util/gaps.dart';
import 'widget/counter_panel.dart';
import 'widget/success_rate_plot.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => getIt<WorkManagerCubit>()..init(),
        child: BlocBuilder<WorkManagerCubit, WorkManagerState>(
          builder: (BuildContext context, WorkManagerState state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text('WorkManager Demo'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Gaps.vGap10,
                    [const CounterPanel(EventType.red), const CounterPanel(EventType.black)]
                        .toRow(mainAxisAlignment: MainAxisAlignment.spaceAround),
                    Gaps.vGap20,
                    [
                      _buildWorkStartButton(context, EventType.red),
                      _buildWorkStartButton(context, EventType.black)
                    ].toRow(mainAxisAlignment: MainAxisAlignment.spaceAround),
                    const OptionPanel(),
                    GFCarousel(
                        height: 350,
                        passiveIndicator: Colors.grey,
                        activeIndicator: Colors.black,
                        hasPagination: true,
                        items: [
                          const EventLogPanel(),
                          SuccessRatePlot(),
                          const RemainEventLogPanel()
                        ]),
                    Gaps.vGap20,
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget _buildWorkStartButton(BuildContext context, EventType type) {
    final WorkManagerCubit cubit = context.read<WorkManagerCubit>();
    return GFButton(
      onPressed: () {
        cubit.plusOneNumber(type);
      },
      onLongPress: () async {
        for (int i = 0; i < 50; i++) {
          cubit.plusOneNumber(type);
        }
      },
      color: type == EventType.red ? Colors.red : Colors.black,
      size: GFSize.LARGE,
      text: '+1 to ${type.name} (after 1s)',
    );
  }
}
