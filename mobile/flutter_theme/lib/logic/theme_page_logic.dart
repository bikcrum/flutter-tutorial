
import 'package:flutter/material.dart';
import 'package:flutter_theme/config/global_config.dart';
import 'package:flutter_theme/json/color_power.dart';
import 'package:flutter_theme/json/theme_power.dart';
import 'package:flutter_theme/model/global_model.dart';
import 'package:flutter_theme/model/theme_page_model.dart';
import 'package:provider/provider.dart';

class ThemePageLogic {

  final ThemePageModel _model;

  ThemePageLogic(this._model);

  void loadTheme() {
    _model.themes.add(_createTheme(Colors.lightBlue));
    _model.themes.add(_createTheme(Colors.red));
    _model.themes.add(_createTheme(Colors.black, ThemeType.dark));
    _model.themes.add(_createTheme(Colors.grey));
    _model.themes.add(_createTheme(Colors.green));
    _model.themes.add(_createTheme(Colors.amberAccent));
    _model.themes.add(_createTheme(Colors.blueAccent));
    _model.themes.add(_createTheme(Colors.amber));
    _model.themes.add(_createTheme(Colors.deepPurpleAccent));
    _model.themes.add(_createTheme(Colors.redAccent));
    _model.themes.add(_createTheme(Colors.deepPurple));
    _model.themes.add(_createTheme(Colors.deepOrange));
    _model.themes.add(_createTheme(Colors.pinkAccent));
    _model.themes.add(_createTheme(Colors.cyan));
    _model.themes.add(_createTheme(Colors.deepOrangeAccent));
    _model.themes.add(_createTheme(Colors.orange));
    _model.themes.add(_createTheme(Colors.brown));
    _model.themes.add(_createTheme(Colors.yellow));
  }

  ThemePower _createTheme(Color color, [ThemeType type = ThemeType.light]) {
    return ThemePower(colorPower: ColorPower.fromColor(color), themeType: type);
  }

  void updateTheme(GlobalModel globalModel, ThemePower theme) {
    globalModel.currentThemePower = theme;
    globalModel.refresh();
  }

}