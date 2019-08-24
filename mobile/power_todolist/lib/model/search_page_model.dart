import 'package:flutter/material.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/logic/all_logic.dart';

class SearchPageModel extends ChangeNotifier {
  BuildContext context;
  SearchPageLogic logic;

  final TextEditingController textEditingController = TextEditingController();

  List<TaskPower> searchTasks = [];

  int currentTapIndex = 0;
  bool isSearching = false;
  LoadingFlag loadingFlag = LoadingFlag.idle;

  SearchPageModel() {
    logic = SearchPageLogic(this);
  }

  setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
    }
  }

  @override
  void dispose() {
    textEditingController?.dispose();
    super.dispose();
    debugPrint("SearchPageModel disposed");
  }

  void refresh() {
    notifyListeners();
  }
}
