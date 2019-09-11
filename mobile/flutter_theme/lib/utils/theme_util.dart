import 'package:flutter/material.dart';
import 'package:flutter_theme/config/global_config.dart';
import 'package:flutter_theme/json/color_power.dart';
import 'package:flutter_theme/json/theme_power.dart';

class ThemeUtil {
  static ThemeUtil _sInstance;

  factory ThemeUtil.shared() {
    if (_sInstance == null) {
      _sInstance = ThemeUtil._internal();
    }
    return _sInstance;
  }

  ThemeUtil._internal();

  ThemeData getTheme(ThemePower themePower) {
    if (themePower.themeType == ThemeType.dark) {
      return ThemeData(
        brightness: Brightness.dark,
        appBarTheme: getAppBarTheme(Colors.grey, themePower.fontSize),
      );
    }

    Color color = ColorPower.toColor(themePower.colorPower);
    return ThemeData(
      primaryColor: color,
      primaryColorDark: getDarkColor(color),
      primaryColorLight: getLightColor(color),
      appBarTheme: getAppBarTheme(Colors.white, themePower.fontSize),
    );
  }

  AppBarTheme getAppBarTheme(Color color, double fontSize) {
    return AppBarTheme(
      iconTheme: IconThemeData(color: color),
      textTheme: TextTheme(
        title: TextStyle(
          color: color,
          fontSize: fontSize,
        ),
      ),
    );
  }

  Color getDarkColor(Color color) {
    int number = 20;
    int red = color.red - number <= 0 ? color.red : color.red - number;
    int green = color.green - number <= 0 ? color.green : color.green - number;
    int blue = color.blue - number <= 0 ? color.blue : color.blue - number;
    return Color.fromRGBO(red, green, blue, 1);
  }

  Color getLightColor(Color color) {
    int number = 30;
    int red = color.red + number >= 255 ? color.red : color.red + number;
    int green = color.green + number >= 255 ? color.green : color.green + number;
    int blue = color.blue + number >= 255 ? color.blue : color.blue + number;
    return Color.fromRGBO(red, green, blue, 1);
  }
}
