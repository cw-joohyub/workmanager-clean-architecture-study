import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:styled_widget/styled_widget.dart';
import '../cubit/work_manager_cubit.dart';

class CounterPanel extends StatefulWidget {
  const CounterPanel(this.eventType, {super.key});

  final EventType eventType;

  @override
  State<CounterPanel> createState() => _CounterPanelState();
}

class _CounterPanelState extends State<CounterPanel> {

  late LinearGradient targetGradient = widget.eventType == EventType.red
      ? LinearGradient(
          colors: [Colors.red.withOpacity(0.60), Colors.red.withOpacity(0.20)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )
      : LinearGradient(
          colors: [
            Colors.black.withOpacity(0.60),
            Colors.black.withOpacity(0.20)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

  late LinearGradient targetBorderGradient = widget.eventType == EventType.red
      ? LinearGradient(
          colors: [
            Colors.white.withOpacity(0.60),
            Colors.white.withOpacity(0.10),
            Colors.black12.withOpacity(0.01),
            Colors.black12.withOpacity(0.1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.39, 0.40, 1.0],
        )
      : LinearGradient(
          colors: [
            Colors.white.withOpacity(0.60),
            Colors.white.withOpacity(0.10),
            Colors.black12.withOpacity(0.01),
            Colors.black12.withOpacity(0.1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.0, 0.39, 0.40, 1.0],
        );

  @override
  void initState() {
    super.initState();
    // animation 관련 처리
  }

  @override
  Widget build(BuildContext context) {
    final WorkManagerState state = context.watch<WorkManagerCubit>().state;

    final int doneCount =
    widget.eventType == EventType.red ? state.redCount : state.blackCount;

    final int totalCount = state.logEvents
        .values
        .where((element) => element.eventType == widget.eventType)
        .length;

    final String percentage =
        '${totalCount == 0 ? 0 : (doneCount / totalCount.toDouble() * 100).round()}%';

    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      height: 180,
      width: 180,
      color: Colors.red,
      gradient: targetGradient,
      borderGradient: targetBorderGradient,
      child: Center(
        child: Text('$doneCount\n$percentage',
            style: Theme.of(context)
                .textTheme
                .headlineMedium
                ?.apply(color: Colors.white),
            textAlign: TextAlign.center)
            .bold(),
      ),
    );
  }


}
