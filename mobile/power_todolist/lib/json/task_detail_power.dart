class TaskDetailPower {
  String taskDetailName;
  double itemProgress;

  TaskDetailPower({this.taskDetailName = "", this.itemProgress = 0.0});

  static TaskDetailPower fromMap(Map<String, dynamic> map) {
    TaskDetailPower taskDetailPower = new TaskDetailPower();
    taskDetailPower.taskDetailName = map['taskDetailName'];
    taskDetailPower.itemProgress = double.parse(map['itemProgress']);
    return taskDetailPower;
  }

  static List<TaskDetailPower> fromMapList(dynamic mapList) {
    List<TaskDetailPower> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'taskDetailName': taskDetailName,
      'itemProgress': itemProgress.toString()
    };
  }
}
