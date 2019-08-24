import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/utils/all_util.dart';

class ThemeUtil {
  static ThemeUtil _instance;

  static ThemeUtil getInstance() {
    if (_instance == null) {
      _instance = ThemeUtil._internal();
    }
    return _instance;
  }

  ThemeUtil._internal();

  getTheme(ThemePower themePower) {
    if (themePower.themeType == MyTheme.darkTheme) {
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

  AppBarTheme getAppBarTheme(Color color, double fontSize) {
    return AppBarTheme(
      iconTheme: IconThemeData(color: color),
      textTheme: TextTheme(title: TextStyle(color: color, fontSize: fontSize)),
    );
  }

  Future<List<ThemePower>> getThemeListWithCache(BuildContext context) async {
    List<String> strings = await SharedUtil.instance.readList(Keys.themePowers);
    List<ThemePower> list = [];
    for (var o in strings) {
      final data = jsonDecode(o);
      ThemePower themePower = ThemePower.fromMap(data);
      list.add(themePower);
    }
    final defaultList = defaultThemePowers(context);
    return List.from(defaultList + list);
  }

  List<ThemePower> defaultThemePowers(BuildContext context) => [
        ThemePower(
          themeName: MyLocalizations.of(context).pink,
          colorPower: ColorPower.fromColor(MyThemeColor.defaultColor),
          themeType: MyTheme.defaultTheme,
        ),
        ThemePower(
          themeName: MyLocalizations.of(context).dark,
          colorPower: ColorPower.fromColor(MyThemeColor.darkColor),
          themeType: MyTheme.darkTheme,
        ),
        ThemePower(
          themeName: MyLocalizations.of(context).coffee,
          colorPower: ColorPower.fromColor(MyThemeColor.coffeeColor),
          themeType: MyTheme.coffeeTheme,
        ),
        ThemePower(
          themeName: MyLocalizations.of(context).green,
          colorPower: ColorPower.fromColor(MyThemeColor.greenColor),
          themeType: MyTheme.greenTheme,
        ),
        ThemePower(
          themeName: MyLocalizations.of(context).purple,
          colorPower: ColorPower.fromColor(MyThemeColor.purpleColor),
          themeType: MyTheme.purpleTheme,
        ),
        ThemePower(
          themeName: MyLocalizations.of(context).cyan,
          colorPower: ColorPower.fromColor(MyThemeColor.cyanColor),
          themeType: MyTheme.cyanTheme,
        ),
        ThemePower(
          themeName: MyLocalizations.of(context).blueGray,
          colorPower: ColorPower.fromColor(MyThemeColor.blueGrayColor),
          themeType: MyTheme.blueGrayTheme,
        ),
      ];
}

class MyTheme {
  static const String defaultTheme = "pink";
  static const String darkTheme = "dark";
  static const String coffeeTheme = "coffee";
  static const String cyanTheme = "cyan";
  static const String purpleTheme = "purple";
  static const String greenTheme = "green";
  static const String blueGrayTheme = "blueGray";
}

class MyThemeColor {
  static const Color defaultColor = Color.fromRGBO(246, 200, 200, 1);
  static const Color darkColor = Colors.grey;
  static const Color coffeeColor = Color.fromRGBO(228, 183, 160, 1);
  static const Color cyanColor = Color.fromRGBO(143, 227, 235, 1);
  static const Color greenColor = Color.fromRGBO(151, 215, 178, 1);
  static const Color purpleColor = Color.fromRGBO(205, 188, 255, 1);
  static const Color blueGrayColor = Color.fromRGBO(135, 170, 171, 1);
}

class MyThemeFontSize {
  static const double defaultFontSize = 20;
  static const double darkFontSize = 20;
  static const double coffeeFontSize = 20;
  static const double cyanFontSize = 20;
  static const double purpleFontSize = 20;
  static const double greenFontSize = 20;
  static const double blueGrayFontSize = 20;
}
