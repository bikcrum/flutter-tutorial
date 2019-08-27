import 'package:flutter/material.dart';

import '../logic/main_page_logic.dart';

class MainPageModel extends ChangeNotifier {
  MainPageLogic logic;

  int taskNumbers = 0;

  MainPageModel() {
    logic = MainPageLogic(this);
  }

  void refresh() {
    notifyListeners();
  }
}
