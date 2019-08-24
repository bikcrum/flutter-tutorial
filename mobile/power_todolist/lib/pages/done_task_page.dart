import 'dart:math';

import 'package:flutter/material.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/utils/all_util.dart';
import 'package:power_todolist/widgets/all_widget.dart';
import 'package:provider/provider.dart';

class DoneTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<DoneTaskPageModel>(context)..setContext(context);
    final globalModel = Provider.of<GlobalModel>(context);
    final size = MediaQuery.of(context).size;
    final minSize = min(size.width, size.height);
    final itemHeight = minSize / 4;
    final textSize = itemHeight / 10;

    final textColor = globalModel.logic.getWhiteInDark();
    bool isDartNow = globalModel.currentThemePower.themeType == MyTheme.darkTheme;
    final bgColor = isDartNow ? ColorPower.toColor(globalModel.currentThemePower.colorPower) : Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: globalModel.logic.getBgInDark(),
        title: Text(
          MyLocalizations.of(context).doneList,
          style: TextStyle(
            color: bgColor,
          ),
        ),
        iconTheme: IconThemeData(
          color: bgColor,
        ),
      ),
      body: Container(
        color: globalModel.logic.getBgInDark(),
        alignment: Alignment.center,
        child: model.doneTasks.length > 0
            ? ListView.builder(
                itemCount: model.doneTasks.length,
                itemBuilder: (ctx, index) {
                  final task = model.doneTasks[index];
                  final colorPower = task.taskIconPower.colorPower;
                  final iconPower = task.taskIconPower.iconPower;
                  final color = isDartNow ? Colors.black.withOpacity(0.2) : ColorPower.toColor(colorPower);

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      InkWell(
                        onTap: () => model.logic.onTaskTap(index, task),
                        child: Container(
                          height: itemHeight,
                          width: itemHeight * 1.3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              color: color,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width: itemHeight,
                                    child: Text(
                                      task.taskName,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: textSize + 8,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "${MyLocalizations.of(context).taskNum}:${task.taskDetailNum}",
                                    style: TextStyle(
                                      fontSize: textSize,
                                      color: textColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "${MyLocalizations.of(context).createDate}:${model.logic.getTimeText(task.createDate)}",
                                    style: TextStyle(
                                      fontSize: textSize,
                                      color: textColor,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: 20,
                        color: color,
                      ),
                      Column(
                        children: <Widget>[
                          index == 0
                              ? SizedBox(
                                  height: itemHeight / 2,
                                )
                              : Container(
                                  color: color,
                                  width: 2,
                                  height: itemHeight / 2,
                                ),
                          Container(
                            width: itemHeight / 3,
                            height: itemHeight / 3,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: color,
                                ),
                                shape: BoxShape.circle),
                            child: Icon(
                              IconPower.toIconData(iconPower),
                              color: color,
                            ),
                          ),
                          index == model.doneTasks.length - 1
                              ? SizedBox(
                                  height: itemHeight / 2,
                                )
                              : Container(
                                  color: color,
                                  width: 2,
                                  height: itemHeight / 2,
                                ),
                        ],
                      ),
                      Container(
                        height: 1,
                        width: 20,
                        color: color,
                      ),
                      InkWell(
                        onTap: () => model.logic.onTaskTap(index, task),
                        child: Container(
                          height: itemHeight,
                          width: itemHeight * 1.3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width: itemHeight,
                                    child: Text(
                                      "${MyLocalizations.of(context).spendTime}:${model.logic.getDiffTimeText(task.createDate, task.finishDate)}",
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: textSize,
                                        color: textColor,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    "${MyLocalizations.of(context).changedTimes}:${task.changeTimes}",
                                    style: TextStyle(
                                      fontSize: textSize,
                                      color: textColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  Text(
                                    "${MyLocalizations.of(context).completeDate}:${model.logic.getTimeText(task.finishDate)}",
                                    style: TextStyle(
                                      fontSize: textSize,
                                      color: textColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ],
                              ),
                              color: color,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              )
            : LoadingWidget(
                progressColor: globalModel.logic.getPrimaryGreyInDark(context),
                textColor: globalModel.logic.getPrimaryGreyInDark(context),
                flag: model.loadingFlag,
                errorCallBack: () {},
                emptyText: MyLocalizations.of(context).toFinishTask,
              ),
      ),
    );
  }
}
