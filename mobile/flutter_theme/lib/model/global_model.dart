import 'package:flutter/material.dart';
import 'package:flutter_theme/json/color_power.dart';
import 'package:flutter_theme/json/theme_power.dart';

class GlobalModel extends ChangeNotifier {

  ThemePower currentThemePower = ThemePower(
    colorPower: ColorPower.fromColor(Colors.lightBlue),
  );

  String appName = 'Theme Demo';

  void refresh() {
    notifyListeners();
  }
}
