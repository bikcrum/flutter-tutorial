import 'package:flutter/material.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/logic/all_logic.dart';
import 'package:power_todolist/model/all_model.dart';

class EditTaskPageModel extends ChangeNotifier {
  BuildContext context;
  EditTaskPageLogic logic;

  MainPageModel mainPageModel;
  TaskDetailPageModel taskDetailPageModel;

  final ScrollController scrollController = ScrollController();
  final TextEditingController textEditingController = TextEditingController();

  TaskPower oldTaskPower;
  TaskIconPower taskIcon;

  String currentTaskName = "";
  int changeTimes = 0;
  List<TaskDetailPower> taskDetails = [];

  DateTime createDate;
  DateTime startDate;
  DateTime deadLine;
  DateTime finishDate;

  bool canAddTaskDetail = false;

  EditTaskPageModel({this.oldTaskPower}) {
    logic = EditTaskPageLogic(this)..initialDataFromOld(oldTaskPower);
  }

  setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
    }
  }

  setMainPageModel(MainPageModel mainPageModel) {
    if (this.mainPageModel == null) {
      this.mainPageModel = mainPageModel;
    }
  }

  void setTaskDetailPageModel(TaskDetailPageModel taskDetailPageModel) {
    if (this.taskDetailPageModel == null) {
      this.taskDetailPageModel = taskDetailPageModel;
    }
  }

  void setTaskIcon(TaskIconPower taskIcon) {
    if (this.taskIcon == null) {
      this.taskIcon = taskIcon;
    }
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController?.removeListener(logic.editListener);
    textEditingController?.dispose();
    scrollController?.dispose();
    debugPrint("EditTaskPageModel disposed");
  }

  void refresh() {
    notifyListeners();
  }
}
