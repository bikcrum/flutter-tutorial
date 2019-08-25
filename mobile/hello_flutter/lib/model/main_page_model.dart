import 'package:flutter/material.dart';
import 'package:hello_flutter/logic/main_page_logic.dart';

class MainPageModel extends ChangeNotifier {
  MainPageLogic logic;

  String title = "";
  int counter = 0;

  MainPageModel(this.title) {
    this.logic = MainPageLogic(this);
  }

  void refresh() {
    notifyListeners();
  }
}
