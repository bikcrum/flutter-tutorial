import 'package:flutter/material.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/logic/all_logic.dart';

class DoneTaskPageModel extends ChangeNotifier {
  BuildContext context;
  DoneTaskPageLogic logic;

  List<TaskPower> doneTasks = [];

  int currentTapIndex = 0;
  LoadingFlag loadingFlag = LoadingFlag.loading;

  DoneTaskPageModel() {
    logic = DoneTaskPageLogic(this);
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      Future.wait(
        [
          logic.getDoneTasks(),
        ],
      ).then((value) {
        refresh();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("DoneTaskPageModel dispose");
  }

  void refresh() {
    notifyListeners();
  }
}
