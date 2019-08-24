import 'package:flutter/material.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/database/database.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/utils/all_util.dart';

class EditTaskPageLogic {
  final EditTaskPageModel _model;

  EditTaskPageLogic(this._model);

  initialDataFromOld(TaskPower oldTaskPower) {
    if (oldTaskPower != null) {
      _model.taskDetails.clear();
      _model.taskDetails.addAll(oldTaskPower.detailList);
      if (oldTaskPower.deadLine != null) _model.deadLine = DateTime.parse(oldTaskPower.deadLine);
      if (oldTaskPower.startDate != null) _model.startDate = DateTime.parse(oldTaskPower.startDate);
      _model.createDate = DateTime.parse(oldTaskPower.createDate);
      if (oldTaskPower.finishDate.isNotEmpty) _model.finishDate = DateTime.parse(oldTaskPower.finishDate);
      _model.changeTimes = oldTaskPower.changeTimes ?? 0;
      _model.taskIcon = oldTaskPower.taskIconPower;
      _model.currentTaskName = oldTaskPower.taskName;
      print("--->>>" + _model.currentTaskName);
    }
  }

  bool isEditOldTask() {
    return _model.oldTaskPower != null;
  }

  String getHintTitle() {
    bool isEdit = isEditOldTask();
    final context = _model.context;
    String defaultTitle = "${MyLocalizations.of(context).defaultTitle}:${_model.taskIcon.taskName}";
    String oldTaskTitle = "${_model?.oldTaskPower?.taskName}";
    return isEdit ? oldTaskTitle : defaultTitle;
  }

  void editListener() {
    final text = _model.textEditingController.text;
    if (text.isEmpty && _model.canAddTaskDetail == true) {
      _model.canAddTaskDetail = false;
      _model.refresh();
    } else if (text.isNotEmpty && _model.canAddTaskDetail == false) {
      _model.canAddTaskDetail = true;
      _model.refresh();
    }
  }

  void submitOneItem() {
    String text = _model.textEditingController.text;
    if (text.isEmpty) return;
    _model.taskDetails.add(TaskDetailPower(taskDetailName: text));
    _model.refresh();
    final scroller = _model.scrollController;
    Future.delayed(Duration(milliseconds: 100), () {
      _model.textEditingController.clear();
      scroller?.animateTo(scroller?.position?.maxScrollExtent, duration: Duration(milliseconds: 200), curve: Curves.easeInOutSine);
    });
  }

  Widget getIconText({Icon icon, String text, VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.grey.withOpacity(0.2)),
        child: Row(
          children: <Widget>[
            icon,
            SizedBox(
              width: 4,
            ),
            Text(text),
          ],
        ),
      ),
    );
  }

  String getStartTimeText() {
    if (_model.startDate != null) {
      final time = _model.startDate;
      return "${time.year}-${time.month}-${time.day}";
    }
    return MyLocalizations.of(_model.context).startDate;
  }

  String getEndTimeText() {
    if (_model.deadLine != null) {
      final time = _model.deadLine;
      return "${time.year}-${time.month}-${time.day}";
    }
    return MyLocalizations.of(_model.context).deadline;
  }

  void pickStartTime(GlobalModel globalModel) {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = initialDate.add(Duration(days: 1));
    DateTime lastDate = initialDate.add(Duration(days: 365));
    showDP(firstDate, initialDate, lastDate, globalModel.logic.isDarkNow()).then(
      (day) {
        if (day == null) return;
        if (_model.deadLine != null) {
          if (day.isAfter(_model.deadLine)) {
            showDialog(
                context: _model.context,
                builder: (ctx) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    content: Text(MyLocalizations.of(_model.context).startAfterEnd),
                  );
                });
            return;
          }
        }
        _model.startDate = day;
        _model.refresh();
      },
    );
  }

  void pickEndTime(GlobalModel globalModel) {
    DateTime initialDate = _model.startDate ?? DateTime.now();
    initialDate = initialDate.add(Duration(days: 1));
    DateTime firstDate = initialDate;
    DateTime lastDate = initialDate.add(Duration(days: 365));
    showDP(firstDate, initialDate, lastDate, globalModel.logic.isDarkNow()).then(
      (day) {
        if (day == null) return;
        if (_model.startDate != null) {
          if (day.isBefore(_model.startDate)) {
            showDialog(
                context: _model.context,
                builder: (ctx) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    content: Text(MyLocalizations.of(_model.context).endBeforeStart),
                  );
                });
            return;
          }
        }
        _model.deadLine = day;
        _model.refresh();
      },
    );
  }

  Future<DateTime> showDP(DateTime firstDate, DateTime initialDate, DateTime lastDate, bool isDarkNow) {
    return showDatePicker(
      context: _model.context,
      initialDate: firstDate,
      firstDate: initialDate,
      lastDate: lastDate,
      builder: (BuildContext context, Widget child) {
        final color = ColorPower.toColor(_model.taskIcon.colorPower);
        return Theme(
          child: child,
          data: isDarkNow
              ? ThemeData.dark()
              : ThemeData(
                  primaryColor: color,
                  accentColor: color,
                  backgroundColor: Colors.white,
                  buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.accent),
                ),
        );
      },
    );
  }

  void removeItem(int index) {
    _model.taskDetails.removeAt(index);
    _model.refresh();
  }

  void moveToTop(int index, List list) {
    final item = list[index];
    list.removeAt(index);
    list.insert(0, item);
    _model.refresh();
  }

  void onSubmitTap() {
    bool isEdit = isEditOldTask();
    isEdit ? submitOldTask() : submitNewTask();
  }

  void submitNewTask() async {
    if (_model.taskDetails.length == 0) {
      showDialog(
          context: _model.context,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Text(MyLocalizations.of(_model.context).writeAtLeastOneTaskItem),
            );
          });
      return;
    }

    TaskPower taskPower = await transformDataToPower();
    await DBProvider.db.createTask(taskPower);
    await _model.mainPageModel.logic.getTasks();
    _model.refresh();
    Navigator.of(_model.context).pop();
  }

  void submitOldTask() async {
    if (_model.taskDetails.length == 0) {
      showDialog(
          context: _model.context,
          builder: (ctx) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              content: Text(MyLocalizations.of(_model.context).writeAtLeastOneTaskItem),
            );
          });
      return;
    }
    TaskPower taskPower = await transformDataToPower(
      id: _model.oldTaskPower.id,
      overallProgress: _getOverallProgress(),
    );
    taskPower.changeTimes++;
    DBProvider.db.updateTask(taskPower);
    await _model.mainPageModel.logic.getTasks();
    _model.mainPageModel.refresh();
    if (_model.taskDetailPageModel != null) {
      _model.taskDetailPageModel.isExiting = true;
      _model.taskDetailPageModel.refresh();
    }
    Navigator.of(_model.context).popUntil((route) => route.isFirst);
  }

  Future<TaskPower> transformDataToPower({int id, double overallProgress = 0.0}) async {
    final account = await SharedUtil.instance.getString(Keys.account) ?? "default";
    final taskName = _model.currentTaskName.isEmpty ? _model.taskIcon.taskName : _model.currentTaskName;
    final createDate = _model?.createDate?.toIso8601String() ?? DateTime.now().toIso8601String();
    TaskPower taskPower = TaskPower(
      taskName: taskName,
      account: account,
      taskType: _model.taskIcon.taskName,
      taskDetailNum: _model.taskDetails.length,
      createDate: createDate,
      startDate: _model.startDate?.toIso8601String(),
      deadLine: _model.deadLine?.toIso8601String(),
      detailList: _model.taskDetails,
      taskIconPower: _model.taskIcon,
      changeTimes: _model.changeTimes,
      overallProgress: overallProgress,
      finishDate: _model?.finishDate?.toIso8601String() ?? "",
    );
    if (id != null) {
      taskPower.id = id;
    }
    return taskPower;
  }

  double _getOverallProgress() {
    int length = _model.taskDetails.length;
    double overallProgress = 0.0;
    for (int i = 0; i < length; i++) {
      overallProgress += _model.taskDetails[i].itemProgress / length;
    }
    return overallProgress;
  }
}
