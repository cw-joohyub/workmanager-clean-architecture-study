import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/types/gf_toggle_type.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:workmanager/workmanager.dart';
import 'package:workmanager_clean_architecture_sample/data/repository/task_repository.dart';
import 'package:workmanager_clean_architecture_sample/di/di.dart';
import 'package:workmanager_clean_architecture_sample/util/gaps.dart';

import '../../data/local_isar/log_local_datasource.dart';

class OptionPanel extends StatefulWidget {
  const OptionPanel({super.key});

  @override
  State<OptionPanel> createState() => _OptionPanelState();
}

class _OptionPanelState extends State<OptionPanel> {
  int successRate = 100;
  int fakeDelayMilliseconds = 10;
  bool isImprovedAppend = false;
  bool isPeriodicTask = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Option',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Gaps.hGap10,
        Text('successRate : $successRate').center(),
        GFProgressBar(
          leading: InkWell(
              onTap: () {
                setState(() {
                  if (successRate > 0) {
                    successRate -= 10;
                  }
                });
                TaskRepository.setOption(
                    successRate: (successRate).toInt());
              },
              child: const Icon(CupertinoIcons.arrow_down)),
          trailing: InkWell(
              onTap: () {
                setState(() {
                  if (successRate < 100) {
                    successRate += 10;
                  }
                });
                TaskRepository.setOption(
                    successRate: (successRate).toInt());
              },
              child: const Icon(CupertinoIcons.arrow_up)),
          percentage: successRate / 100,
          onProgressChanged: (double progress) {
            setState(() {
              successRate = (progress * 100).toInt();
            });
            TaskRepository.setOption(
                successRate: (successRate).toInt());
          },
        ),
        Text('fakeDelayMilliseconds : $fakeDelayMilliseconds').center(),
        GFProgressBar(
          leading: InkWell(
              onTap: () {
                setState(() {
                  if (fakeDelayMilliseconds > 100) {
                    fakeDelayMilliseconds -= 100;
                  }
                });
                TaskRepository.setOption(
                    fakeDelayMilliseconds: fakeDelayMilliseconds);
              },
              child: const Icon(CupertinoIcons.arrow_down)),
          trailing: InkWell(
              onTap: () {
                setState(() {
                  if (fakeDelayMilliseconds < 4900) {
                    fakeDelayMilliseconds += 100;
                  }
                });
                TaskRepository.setOption(
                    fakeDelayMilliseconds: fakeDelayMilliseconds);
              },
              child: const Icon(CupertinoIcons.arrow_up)),
          percentage: fakeDelayMilliseconds / 5000,
          onProgressChanged: (double progress) {
            setState(() {
              fakeDelayMilliseconds = (progress * 5000).toInt();
            });
            TaskRepository.setOption(
                fakeDelayMilliseconds: fakeDelayMilliseconds);
          },
        ),

        Text('ImprovedAppend : $isImprovedAppend').center(),
        GFToggle(
          onChanged: (value) {
            setState(() {
              isImprovedAppend = value!;
            });
            TaskRepository.setOption(
                isImprovedAppend: isImprovedAppend);
          },
          value: isImprovedAppend,
          type: GFToggleType.android,
          enabledTrackColor: Colors.green,
          disabledTrackColor: Colors.red,
          enabledThumbColor: Colors.white,
          disabledThumbColor: Colors.white,
        ).center(),
        Text('PeriodicTask : $isPeriodicTask').center(),
        GFToggle(
          onChanged: (value) {
            setState(() {
              isPeriodicTask = value!;
            });
            TaskRepository.setOption(
                isPeriodicTask: isPeriodicTask);
          },
          value: isPeriodicTask,
          type: GFToggleType.android,
          enabledTrackColor: Colors.green,
          disabledTrackColor: Colors.red,
          enabledThumbColor: Colors.white,
          disabledThumbColor: Colors.white,
        ).center(),
        GFButton(onPressed: (){
          Workmanager().printScheduledTasks();
        }, text: 'Print Scheduled Tasks', color: Colors.black38).center(),
        GFButton(onPressed: (){
          getIt<LogLocalDatasource>().deleteAll();
          Workmanager().cancelAll();
          // Workmanager().initialize(callbackDispatcher);
        }, text: 'Clear All Logs', color: Colors.black38).center(),
      ],
    ).padding(all: 20);
  }
}
