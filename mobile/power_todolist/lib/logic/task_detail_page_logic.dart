import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:power_todolist/config/provider_config.dart';
import 'package:power_todolist/database/database.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/model/all_model.dart';

class TaskDetailPageLogic {
  final TaskDetailPageModel _model;

  TaskDetailPageLogic(this._model);

  void editTask(MainPageModel mainPageModel) {
    Navigator.of(_model.context).push(
      new CupertinoPageRoute(
        builder: (ctx) {
          return ProviderConfig.getInstance().getEditTaskPage(
            _model.taskPower.taskIconPower,
            taskPower: _model.taskPower,
            taskDetailPageModel: _model,
          );
        },
      ),
    );
  }

  void deleteTask(MainPageModel mainPageModel) {
    removeTask(mainPageModel);
    DBProvider.db.deleteTask(_model.taskPower.id);
    _model.refresh();
    final doneTaskPageModel = _model.doneTaskPageModel;
    if (doneTaskPageModel != null) {
      doneTaskPageModel.doneTasks.removeAt(doneTaskPageModel.currentTapIndex);
      doneTaskPageModel.refresh();
    }
    final searchPageModel = _model.searchPageModel;
    if (searchPageModel != null) {
      searchPageModel.searchTasks.removeAt(searchPageModel.currentTapIndex);
      searchPageModel.refresh();
    }
    exitPage(isDeleting: true);
  }

  void removeTask(MainPageModel mainPageModel) {
    for (var i = 0; i < mainPageModel.tasks.length; i++) {
      var task = mainPageModel.tasks[i];
      if (task.id == _model.taskPower.id) {
        mainPageModel.tasks.removeAt(i);
        return;
      }
    }
  }

  void refreshProgress(TaskDetailPower taskDetailPower, progress, MainPageModel model) {
    taskDetailPower.itemProgress = progress;
    _getOverallProgress();
    model.refresh();
    _model.refresh();
  }

  void exitPage({bool isDeleting = false}) {
    final context = _model.context;
    final mainPageModel = _model.globalModel.mainPageModel;
    bool needUpdate = needUpdateDatabase();
    if (needUpdate && !isDeleting) {
      if (_model.taskPower.overallProgress >= 1.0) {
        _model.taskPower.finishDate = DateTime.now().toIso8601String();
        Future.delayed(
          Duration(
            milliseconds: 800,
          ),
          () {
            removeTask(mainPageModel);
            mainPageModel.refresh();
          },
        );
      }
      _model.taskPower.changeTimes++;
      DBProvider.db.updateTask(_model.taskPower).then((value) {
        if (_model.doneTaskPageModel != null) {
          mainPageModel.logic.getTasks();
          _model.doneTaskPageModel.logic.getDoneTasks().then((value) {
            _model.doneTaskPageModel.refresh();
            Navigator.of(context).pop();
          });
        } else if (_model.searchPageModel != null) {
          _model.isExiting = true;
          _model.refresh();
          mainPageModel.logic.getTasks();
          _model.searchPageModel.logic.onEditingComplete();
          Navigator.of(context).pop();
        } else {
          _model.isExiting = true;
          _model.refresh();
          Navigator.of(context).pop();
        }
      });
      return;
    }
    _model.isExiting = true;
    _model.refresh();
    Navigator.of(context).pop();
  }

  bool needUpdateDatabase() {
    return _model.progress != _model.taskPower.overallProgress;
  }

  double _getOverallProgress() {
    int length = _model.taskPower.detailList.length;
    double overallProgress = 0.0;
    for (int i = 0; i < length; i++) {
      overallProgress += _model.taskPower.detailList[i].itemProgress / length;
    }
    _model.taskPower.overallProgress = overallProgress > 0.999 ? 1.0 : overallProgress;
    return overallProgress;
  }
}
