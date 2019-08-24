import 'package:flutter/material.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/logic/all_logic.dart';

class ThemePageModel extends ChangeNotifier {
  ThemePageLogic logic;
  BuildContext context;
  Color customColor = Colors.black;

  List<ThemePower> themes = [];
  bool isDeleting = false;

  ThemePageModel() {
    logic = ThemePageLogic(this);
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      logic.getThemeList();
    }
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("ThemePageModel disposed");
  }

  void refresh() {
    notifyListeners();
  }
}
