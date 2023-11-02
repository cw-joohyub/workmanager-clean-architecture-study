import 'package:flutter/material.dart';
import 'package:getwidget/components/avatar/gf_avatar.dart';
import 'package:getwidget/components/list_tile/gf_list_tile.dart';
import 'package:getwidget/size/gf_size.dart';
import 'package:styled_widget/styled_widget.dart';

import '../cubit/work_manager_cubit.dart';

class LogListTile extends StatelessWidget {
  final DateTime datetime;
  final int retry;
  final EventType eventType;
  final bool isSuccess;

  const LogListTile(
      {Key? key,
      required this.datetime,
      required this.retry,
      required this.eventType,
      required this.isSuccess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formattedDate =
        '${datetime.year}-${datetime.month.toString().padLeft(2, '0')}'
        '-${datetime.day.toString().padLeft(2, '0')} '
        '${datetime.hour.toString().padLeft(2, '0')}:'
        '${datetime.minute.toString().padLeft(2, '0')}:'
        '${datetime.second.toString().padLeft(2, '0')}.'
        '${datetime.millisecond.toString().padLeft(3, '0')}';

    return GFListTile(
      avatar: GFAvatar(
        size: GFSize.SMALL,
        backgroundColor: eventType == EventType.red ? Colors.red : Colors.black,
        child: Text(eventType == EventType.red ? 'R' : 'B',
            style: const TextStyle(color: Colors.white)),
      ),
      title: Text('$formattedDate / retry : $retry').bold(),
      icon: isSuccess ? const Icon(
        Icons.check_circle,
        color: Colors.greenAccent) : null,
    );
  }
}
