import 'package:flutter/material.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/widgets/popmenu_bottom_widget.dart';

class TaskInfoWidget extends StatelessWidget {
  final int index;
  final double space;
  final TaskPower taskPower;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final bool isCardChangeWithBg;
  final bool isExisting;

  TaskInfoWidget(
    this.index, {
    this.space = 20,
    this.taskPower,
    this.onDelete,
    this.onEdit,
    this.isCardChangeWithBg = false,
    this.isExisting = false,
  });

  @override
  Widget build(BuildContext context) {
    final taskColor = isCardChangeWithBg ? Theme.of(context).primaryColor : ColorPower.toColor(taskPower.taskIconPower.colorPower);
    final taskIconData = IconPower.toIconData(taskPower.taskIconPower.iconPower);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(top: 16),
                child: Hero(
                  tag: "task_icon${index}",
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: taskColor,
                        ),
                        shape: BoxShape.circle),
                    child: Icon(
                      taskIconData,
                      color: taskColor,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.centerRight,
                child: Container(
                  width: 42,
                  height: 42,
                  margin: EdgeInsets.only(top: 16),
                  child: space == 20
                      ? SizedBox()
                      : Hero(
                          tag: "task_more${index}",
                          child: Material(
                            color: Colors.transparent,
                            child: PopMenuBtWidget(
                              iconColor: taskColor,
                              onDelete: onDelete,
                              onEdit: onEdit,
                            ),
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: space,
        ),
        Column(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 8,
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Hero(
                        tag: "task_title${index}",
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            "${taskPower.taskName} ",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: taskPower.overallProgress >= 1.0 && !isExisting
                          ? Hero(
                              tag: "task_complete${index}",
                              child: Icon(
                                Icons.check_circle,
                                size: 24,
                                color: Colors.greenAccent,
                              ),
                            )
                          : getStatusWidget(context, taskColor),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              alignment: Alignment.bottomLeft,
              child: Hero(
                tag: "task_items${index}",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    "${MyLocalizations.of(context).itemNumber(taskPower.taskDetailNum)}",
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Hero(
                tag: "task_progress${index}",
                child: Material(
                    color: Colors.transparent,
                    child: Text(
                      "${(taskPower.overallProgress * 100).toInt()}%",
                      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            Hero(
              tag: "task_progressbar${index}",
              child: Container(
                height: 10,
                margin: EdgeInsets.only(top: 12, bottom: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(taskColor),
                    value: taskPower.overallProgress,
                    backgroundColor: Color.fromRGBO(224, 224, 224, 1),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget getStatusWidget(BuildContext context, Color taskColor) {
    final startDate = taskPower.startDate ?? "";
    final deadLine = taskPower.deadLine ?? "";
    final now = DateTime.now();
    if (startDate.isNotEmpty && deadLine.isNotEmpty) {
      final begin = DateTime.parse(startDate);
      final end = DateTime.parse(deadLine);
      if (now.isBefore(begin)) {
        return getBeginIcon(begin, now, context, taskColor);
      }
      if (now.isAfter(begin) && now.isBefore(end)) {
        return getEndIcon(end, now, context, taskColor);
      }
    } else if (startDate.isNotEmpty) {
      final begin = DateTime.parse(startDate);
      if (now.isBefore(begin)) {
        return getBeginIcon(begin, now, context, taskColor);
      }
    } else if (deadLine.isNotEmpty) {
      final end = DateTime.parse(deadLine);
      if (now.isBefore(end)) {
        return getEndIcon(end, now, context, taskColor);
      }
    }
    return SizedBox();
  }

  Widget getBeginIcon(DateTime begin, DateTime now, BuildContext context, Color taskColor) {
    int days = begin.difference(now).inDays;
    int hours = begin.difference(now).inHours;
    bool showHour = days == 0;
    return Row(
      children: <Widget>[
        Hero(
          tag: "time_icon${index}",
          child: Icon(
            Icons.timer,
            color: taskColor,
          ),
        ),
        Expanded(
          child: Hero(
            tag: "time_text${index}",
            child: Material(
              color: Colors.transparent,
              child: Text(
                showHour ? MyLocalizations.of(context).hours(hours) : MyLocalizations.of(context).days(days),
                style: TextStyle(
                  color: taskColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget getEndIcon(DateTime end, DateTime now, BuildContext context, Color taskColor) {
    int days = end.difference(now).inDays;
    int hours = end.difference(now).inHours;
    bool showHour = days == 0;
    return Row(
      children: <Widget>[
        Hero(
          tag: "time_icon${index}",
          child: Icon(
            Icons.timelapse,
            color: taskColor,
          ),
        ),
        Expanded(
          child: Hero(
            tag: "time_text${index}",
            child: Material(
              color: Colors.transparent,
              child: Text(
                showHour ? MyLocalizations.of(context).hours(hours) : MyLocalizations.of(context).days(days),
                style: TextStyle(
                  color: taskColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
