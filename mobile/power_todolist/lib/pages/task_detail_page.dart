import 'dart:io';

import 'package:flutter/material.dart';
import 'package:power_todolist/items/task_detail_item.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/widgets/all_widget.dart';
import 'package:provider/provider.dart';

class TaskDetailPage extends StatelessWidget {
  TaskDetailPage();

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    final mainPageModel = globalModel.mainPageModel;
    final model = Provider.of<TaskDetailPageModel>(context)
      ..setContext(context)
      ..setGlobalModel(globalModel);

    final taskColor = globalModel.isCardChangeWithBg ? Theme.of(context).primaryColor : ColorPower.toColor(model.taskPower.taskIconPower.colorPower);

    final int heroTag = model.heroTag;
    final size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        model.logic.exitPage();
      },
      child: Stack(
        children: <Widget>[
          Hero(
            tag: "task_bg${heroTag}",
            child: Container(
                decoration: BoxDecoration(
              color: globalModel.logic.getBgInDark(),
              borderRadius: BorderRadius.circular(15.0),
            )),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              iconTheme: IconThemeData(color: taskColor),
              leading: model.isAnimationComplete && !model.isExiting
                  ? IconButton(
                      icon: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
                      onPressed: model.logic.exitPage,
                    )
                  : SizedBox(),
              elevation: 0,
              backgroundColor: Colors.transparent,
              actions: <Widget>[
                Hero(
                  tag: "task_more${heroTag}",
                  child: Material(
                    color: Colors.transparent,
                    child: PopMenuBtWidget(
                      iconColor: taskColor,
                      onDelete: () => model.logic.deleteTask(mainPageModel),
                      onEdit: () => model.logic.editTask(mainPageModel),
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 50, top: size.width > size.height ? 0 : 20, right: 50),
                  child: TaskInfoWidget(
                    heroTag,
                    taskPower: model.taskPower,
                    isCardChangeWithBg: globalModel.isCardChangeWithBg,
                    isExisting: model.isExiting,
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    child: !model.isExiting
                        ? NotificationListener<OverscrollIndicatorNotification>(
                            onNotification: (overScroll) {
                              overScroll.disallowGlow();
                            },
                            child: ListView(
                              children: List.generate(
                                model?.taskPower?.detailList?.length ?? 0,
                                (index) {
                                  TaskDetailPower taskDetailPower = model.taskPower.detailList[index];
                                  return Container(
                                    margin: EdgeInsets.only(bottom: index == model.taskPower.detailList.length - 1 ? 20 : 0, left: 50, right: 50),
                                    child: TaskDetailItem(
                                      index: index,
                                      showAnimation: model.doneTaskPageModel == null,
                                      itemProgress: taskDetailPower.itemProgress,
                                      itemName: taskDetailPower.taskDetailName,
                                      iconColor: taskColor,
                                      onProgressChanged: (progress) {
                                        model.logic.refreshProgress(taskDetailPower, progress, mainPageModel);
                                        model.refresh();
                                      },
                                      onChecked: (progress) {
                                        model.logic.refreshProgress(taskDetailPower, progress, mainPageModel);
                                        model.refresh();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ))
                        : SizedBox(),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
