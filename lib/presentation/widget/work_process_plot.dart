
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';

import '../cubit/work_manager_cubit.dart';

class WorkProcessPlot extends StatelessWidget {
  WorkProcessPlot({super.key});

  final FlTitlesData plotTitleData = FlTitlesData(
    bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, _) {
            switch (value.toInt()) {
              case 0:
                return const Text('Red');
              case 1:
                return const Text('Black');
              default:
                return const Text('');
            }
          },
        )),
    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
  );

  @override
  Widget build(BuildContext context) {
    final WorkManagerState state = context.read<WorkManagerCubit>().state;

    return GlassContainer(
      height: 300,
      width: 350,
      padding: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(20),
      gradient: LinearGradient(
        colors: [Colors.grey.withOpacity(0.60), Colors.grey.withOpacity(0.20)],
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
      child: BarChart(BarChartData(
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        titlesData: plotTitleData,
        barGroups: <BarChartGroupData>[
          BarChartGroupData(x: 0, barRods: [
            BarChartRodData(
                color: Colors.red,
                toY: state.logEvents
                    .where((element) => element.eventType == EventType.red)
                    .length
                    .toDouble(),
                width: 20,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            BarChartRodData(
                color: Colors.greenAccent,
                toY: state.redCount.toDouble(),
                width: 20,
                borderRadius: const BorderRadius.all(Radius.circular(10)))
          ]),
          BarChartGroupData(x: 1, barRods: [
            BarChartRodData(
                color: Colors.black,
                toY: state.logEvents
                    .where((element) => element.eventType == EventType.black)
                    .length
                    .toDouble(),
                width: 20,
                borderRadius: const BorderRadius.all(Radius.circular(10))),
            BarChartRodData(
                color: Colors.greenAccent,
                toY: state.blackCount.toDouble(),
                width: 20,
                borderRadius: const BorderRadius.all(Radius.circular(10)))
          ]),
        ],
      )),
    );
  }


}
