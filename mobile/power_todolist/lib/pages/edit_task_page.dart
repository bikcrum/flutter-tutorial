import 'dart:math';

import 'package:flutter/material.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:provider/provider.dart';

class EditTaskPage extends StatelessWidget {
  final TaskIconPower taskIconPower;
  final TaskDetailPageModel taskDetailPageModel;

  EditTaskPage(
    this.taskIconPower, {
    this.taskDetailPageModel,
  });

  @override
  Widget build(BuildContext context) {
    final GlobalModel globalModel = Provider.of<GlobalModel>(context);
    final EditTaskPageModel model = Provider.of<EditTaskPageModel>(context)
      ..setContext(context)
      ..setMainPageModel(globalModel.mainPageModel)
      ..setTaskDetailPageModel(taskDetailPageModel)
      ..setTaskIcon(taskIconPower);

    final bgColor = globalModel.logic.getBgInDark();
    final iconData = IconPower.toIconData(taskIconPower.iconPower);
    final iconColor = ColorPower.toColor(taskIconPower.colorPower);
    final textColor = globalModel.logic.isDarkNow() ? Color.fromRGBO(130, 130, 130, 1) : Colors.black;
    final hintTextColor = globalModel.logic.isDarkNow() ? Color.fromRGBO(130, 130, 130, 1) : Colors.grey;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: iconColor),
        backgroundColor: bgColor,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: iconColor,
            ),
            tooltip: MyLocalizations.of(context).submit,
            onPressed: model.logic.onSubmitTap,
          )
        ],
        title: Container(
          height: 49,
          child: Form(
            autovalidate: false,
            child: Theme(
              data: ThemeData(platform: TargetPlatform.android),
              child: TextFormField(
                maxLines: 1,
                style: TextStyle(color: textColor),
                textAlign: TextAlign.center,
                validator: (text) {
//                  model.currentTaskName = text;
                  return null;
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: model.logic.getHintTitle(),
                  hintStyle: TextStyle(color: hintTextColor),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 50, right: 50),
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overScroll) {
                  overScroll.disallowGlow();
                },
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 100),
                  itemCount: model.taskDetails.length,
                  controller: model.scrollController,
                  itemBuilder: (ctx, index) {
                    return Dismissible(
                      key: ValueKey(index + Random().nextDouble()),
                      background: Container(
                        alignment: Alignment.centerLeft,
                        color: iconColor,
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      secondaryBackground: Container(
                        alignment: Alignment.centerRight,
                        color: iconColor,
                        padding: EdgeInsets.only(right: 10),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10, top: 10),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: iconColor,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: Text(
                                model.taskDetails[index].taskDetailName,
                                style: TextStyle(
                                  color: Color.fromRGBO(130, 130, 130, 1),
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.arrow_upward,
                                color: iconColor,
                              ),
                              onPressed: () => model.logic.moveToTop(index, model.taskDetails),
                            ),
                          ],
                        ),
                      ),
                      onDismissed: (d) => model.logic.removeItem(index),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                width: MediaQuery.of(context).size.width,
                color: bgColor,
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 1,
                      color: Colors.grey.withOpacity(0.5),
                    ),
                    Theme(
                      data: ThemeData(platform: TargetPlatform.android),
                      child: TextField(
                        controller: model.textEditingController..addListener(model.logic.editListener),
                        autofocus: model.taskDetails.length > 0 ? false : true,
                        style: TextStyle(
                          color: textColor,
                        ),
                        decoration: InputDecoration(
                            hintText: MyLocalizations.of(context).addTask,
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: hintTextColor,
                            ),
                            prefixIcon: Icon(
                              iconData,
                              color: iconColor,
                            ),
                            suffixIcon: GestureDetector(
                              onTap: model.logic.submitOneItem,
                              child: Container(
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: model.canAddTaskDetail ? iconColor : Colors.grey.withOpacity(0.4)),
                                child: Icon(
                                  Icons.arrow_upward,
                                  color: bgColor,
                                  size: 20,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          model.logic.getIconText(
                            icon: Icon(
                              Icons.timer,
                              color: iconColor,
                            ),
                            text: model.logic.getStartTimeText(),
                            onTap: () => model.logic.pickStartTime(globalModel),
                          ),
                          model.logic.getIconText(
                            icon: Icon(
                              Icons.timelapse,
                              color: iconColor,
                            ),
                            text: model.logic.getEndTimeText(),
                            onTap: () => model.logic.pickEndTime(globalModel),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
