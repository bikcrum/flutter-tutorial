import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/config/provider_config.dart';
import 'package:power_todolist/database/database.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/model/all_model.dart';

class SearchPageLogic {
  final SearchPageModel _model;

  SearchPageLogic(this._model);

  void onEditingComplete() {
    final queryText = _model.textEditingController.text;
    if (queryText.isEmpty) return;
    if (!_model.isSearching) {
      _model.isSearching = true;
      DBProvider.db.queryTask(queryText).then((list) {
        _model.isSearching = false;
        _model.searchTasks.clear();
        _model.searchTasks.addAll(list);
        if (_model.searchTasks.length == 0) {
          _model.loadingFlag = LoadingFlag.empty;
        } else {
          _model.loadingFlag = LoadingFlag.success;
        }
        _model.refresh();
      });
    }
  }

  void onTaskTap(int index, TaskPower taskPower) {
    _model.currentTapIndex = index;
    Navigator.of(_model.context).push(
      new PageRouteBuilder(
        pageBuilder: (ctx, anm, anmS) {
          return ProviderConfig.getInstance().getTaskDetailPage(taskPower.id, taskPower, searchPageModel: _model);
        },
        transitionDuration: Duration(milliseconds: 800),
      ),
    );
  }

  void onEdit(TaskPower taskPower, MainPageModel mainPageModel) {
    Navigator.of(_model.context).push(
      new CupertinoPageRoute(
        builder: (ctx) {
          return ProviderConfig.getInstance().getEditTaskPage(
            taskPower.taskIconPower,
            taskPower: taskPower,
          );
        },
      ),
    );
  }

  void onDelete(GlobalModel globalModel, TaskPower task) {
    DBProvider.db.deleteTask(task.id);
    final mainPageModel = globalModel.mainPageModel;
    removeTask(mainPageModel, task.id);
    onEditingComplete();
  }

  void removeTask(MainPageModel mainPageModel, int id) {
    for (var i = 0; i < mainPageModel.tasks.length; i++) {
      var task = mainPageModel.tasks[i];
      if (task.id == id) {
        mainPageModel.tasks.removeAt(i);
        mainPageModel.refresh();
        return;
      }
    }
  }
}
