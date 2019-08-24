import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/config/provider_config.dart';
import 'package:power_todolist/database/database.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';

class DoneTaskPageLogic {
  final DoneTaskPageModel _model;

  DoneTaskPageLogic(this._model);

  Future getDoneTasks() async {
    final tasks = await DBProvider.db.getTasks(isDone: true);
    if (tasks.length == 0) {
      _model.loadingFlag = LoadingFlag.empty;
      _model.doneTasks.clear();
      return;
    }
    _model.doneTasks.clear();
    _model.doneTasks.addAll(tasks);
    _model.loadingFlag = LoadingFlag.success;
  }

  String getTimeText(String date) {
    if (date.isEmpty) {
      date = DateTime.now().toIso8601String();
    }
    DateTime time = DateTime.parse(date);
    return "${time.year}-${time.month}-${time.day}";
  }

  String getDiffTimeText(String dateStart, String dateEnd) {
    if (dateEnd.isEmpty) {
      dateEnd = DateTime.now().toIso8601String();
    }
    DateTime timeStart = DateTime.parse(dateStart);
    DateTime timeEnd = DateTime.parse(dateEnd);
    Duration diff = timeEnd.difference(timeStart);
    final context = _model.context;
    return diff.inDays == 0 ? "${MyLocalizations.of(context).hours(diff.inHours.abs())}" : "${MyLocalizations.of(context).days(diff.inDays.abs())}";
  }

  void onTaskTap(int index, TaskPower task) {
    _model.currentTapIndex = index;
    Navigator.of(_model.context).push(
      new CupertinoPageRoute(
        builder: (ctx) {
          return ProviderConfig.getInstance().getTaskDetailPage(
            task.id,
            task,
            doneTaskPageModel: _model,
          );
        },
      ),
    );
  }
}
