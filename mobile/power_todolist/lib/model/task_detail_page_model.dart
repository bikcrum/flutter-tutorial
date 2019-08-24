import 'dart:async';

import 'package:flutter/material.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/logic/all_logic.dart';
import 'package:power_todolist/model/all_model.dart';

class TaskDetailPageModel extends ChangeNotifier {
  BuildContext context;
  GlobalModel globalModel;
  TaskDetailPageLogic logic;
  DoneTaskPageModel doneTaskPageModel;
  SearchPageModel searchPageModel;

  int heroTag;
  bool isExiting = false;
  bool isAnimationComplete = false;
  double progress;
  Timer timer;
  TaskPower taskPower;

  TaskDetailPageModel(
    TaskPower taskPower, {
    DoneTaskPageModel doneTaskPageModel,
    SearchPageModel searchPageModel,
    int heroTag,
  }) {
    logic = TaskDetailPageLogic(this);
    this.taskPower = taskPower;
    this.heroTag = heroTag;
    this.doneTaskPageModel = doneTaskPageModel;
    this.searchPageModel = searchPageModel;
    this.progress = taskPower.overallProgress;
    if (doneTaskPageModel != null) {
      isAnimationComplete = true;
      return;
    }
    timer = Timer(Duration(seconds: 1), () {
      isAnimationComplete = true;
      notifyListeners();
    });
  }

  void setContext(BuildContext context) async {
    if (this.context == null) {
      this.context = context;
    }
  }

  void setGlobalModel(GlobalModel globalModel) {
    if (this.globalModel == null) {
      this.globalModel = globalModel;
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    debugPrint("TaskDetailPageModel disposed");
    super.dispose();
  }

  void refresh() {
    notifyListeners();
  }
}
