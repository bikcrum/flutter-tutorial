
import 'package:flutter/material.dart';
import 'package:flutter_theme/json/theme_power.dart';
import 'package:flutter_theme/logic/theme_page_logic.dart';

class ThemePageModel extends ChangeNotifier {

  ThemePageLogic logic;
  final List<ThemePower> themes = [];

  ThemePageModel() {
    logic = ThemePageLogic(this);
    logic.loadTheme();
  }

}