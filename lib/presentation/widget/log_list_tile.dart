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
  final bool isInvalid;

  const LogListTile(
      {Key? key,
      required this.datetime,
      required this.retry,
      required this.eventType,
      required this.isSuccess,
      this.isInvalid = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime lastDatetime = datetime;
    final String lastFormattedDate =
        '${lastDatetime.year}-${lastDatetime.month.toString().padLeft(2, '0')}'
        '-${lastDatetime.day.toString().padLeft(2, '0')} '
        '${lastDatetime.hour.toString().padLeft(2, '0')}:'
        '${lastDatetime.minute.toString().padLeft(2, '0')}:'
        '${lastDatetime.second.toString().padLeft(2, '0')}.'
        '${lastDatetime.millisecond.toString().padLeft(3, '0')}';

    Icon? icon = isSuccess
        ? const Icon(
            Icons.check_circle,
            color: Colors.greenAccent)
        : null;

    if(isInvalid) {
      icon = const Icon(
      Icons.error,
      color: Colors.redAccent);
    }

    return GFListTile(
      avatar: GFAvatar(
        size: GFSize.SMALL,
        backgroundColor: eventType == EventType.red ? Colors.red : Colors.black,
        child: Text(eventType == EventType.red ? 'R' : 'B',
            style: const TextStyle(color: Colors.white)),
      ),
      title: Text('$lastFormattedDate / retry : $retry').bold(),
      icon: icon,
    );
  }
}
