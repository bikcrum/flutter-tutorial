import 'dart:convert';

import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/json/all_power.dart';

class TaskPower {
  int id;
  String taskName;
  String taskType;
  String account;
  int taskStatus;
  int taskDetailNum = 0;
  double overallProgress;
  int changeTimes;
  String createDate;
  String finishDate;
  String startDate;
  String deadLine;

  TaskIconPower taskIconPower;
  List<TaskDetailPower> detailList = [];

  TaskPower({this.taskName = "", this.taskType = "", this.taskStatus = TaskStatus.todo, this.taskDetailNum, this.overallProgress = 0.0, this.changeTimes = 0, this.createDate = "", this.finishDate = "", this.account = "default", this.startDate = "", this.deadLine = "", this.taskIconPower, this.detailList});

  static TaskPower fromMap(Map<String, dynamic> map) {
    TaskPower taskPower = new TaskPower();
    taskPower.id = map['id'];
    taskPower.taskName = map['taskName'];
    taskPower.taskType = map['taskType'];
    taskPower.taskDetailNum = map['taskDetailNum'];
    taskPower.taskStatus = map['taskStatus'];
    taskPower.account = map['account'];
    taskPower.changeTimes = map['changeTimes'] ?? 0;
    taskPower.overallProgress = double.parse(map['overallProgress']);
    taskPower.createDate = map['createDate'];
    taskPower.finishDate = map['finishDate'];
    taskPower.startDate = map['startDate'];
    taskPower.deadLine = map['deadLine'];
    if (map['taskIconPower'] is String) {
      var taskIconPower = jsonDecode(map['taskIconPower']);
      taskPower.taskIconPower = TaskIconPower.fromMap(taskIconPower);
    } else {
      taskPower.taskIconPower = TaskIconPower.fromMap(map['taskIconPower']);
    }
    if (map['detailList'] is String) {
      var detailList = jsonDecode(map['detailList']);
      taskPower.detailList = TaskDetailPower.fromMapList(detailList);
    } else {
      taskPower.detailList = TaskDetailPower.fromMapList(map['detailList']);
    }
    return taskPower;
  }

  static List<TaskPower> fromMapList(dynamic mapList) {
    List<TaskPower> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'taskType': taskType,
      'taskStatus': taskStatus,
      'taskDetailNum': taskDetailNum,
      'overallProgress': (overallProgress >= 1.0 ? 1.0 : overallProgress).toString(),
      'createDate': createDate,
      'account': account,
      'changeTimes': changeTimes ?? 0,
      'finishDate': finishDate,
      'startDate': startDate,
      'deadLine': deadLine,
      'taskIconPower': jsonEncode(taskIconPower.toMap()),
      'detailList': jsonEncode(List.generate(detailList.length, (index) {
        return detailList[index].toMap();
      }))
    };
  }
}
