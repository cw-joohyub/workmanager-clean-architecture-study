import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:workmanager/workmanager.dart';

import '../cubit/work_manager_cubit.dart';
import 'log_list_tile.dart';

class RemainEventLogPanel extends StatelessWidget {
  const RemainEventLogPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final WorkManagerState state = context.watch<WorkManagerCubit>().state;

    return GlassContainer(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.withOpacity(0.60),
          Colors.deepPurpleAccent.withOpacity(0.20)
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
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Remain Event Log')
              .textColor(Colors.white)
              .textScale(2)
              .bold()
              .padding(left: 20, top: 20),
          SizedBox(
            width: 400,
            height: 280,
            child: ListView(
              children: state.logEvents.values
                  .where((List<LogEvent> e) => !e.last.isSuccess)
                  .map((List<LogEvent> e) {
                return LogListTile(
                    datetime: e.first.dateTime,
                    retry: e.where((LogEvent e) => !e.isSuccess).length-1,
                    eventType: e.first.eventType,
                    isSuccess: e.last.isSuccess);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
