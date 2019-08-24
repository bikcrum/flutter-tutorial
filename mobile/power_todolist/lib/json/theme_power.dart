import 'package:power_todolist/json/color_power.dart';

class ThemePower {
  String themeName;
  String themeType;
  ColorPower colorPower;
  double fontSize;

  ThemePower({this.themeName, this.themeType, this.colorPower, this.fontSize});

  static ThemePower fromMap(Map<String, dynamic> map) {
    ThemePower power = new ThemePower();
    power.themeName = map['themeName'];
    power.colorPower = ColorPower.fromMap(map['colorPower']);
    power.themeType = map['themeType'];
    return power;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'themeName': themeName,
      'colorPower': colorPower.toMap(),
      'themeType': themeType
    };
  }
}
