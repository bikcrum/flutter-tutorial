import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/material_picker.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/utils/all_util.dart';

class ThemePageLogic {
  final ThemePageModel _model;

  ThemePageLogic(this._model);

  void getThemeList() async {
    final list = await ThemeUtil.getInstance().getThemeListWithCache(_model.context);
    _model.themes.clear();
    _model.themes.addAll(list);
    if (list.length == 7) {
      _model.isDeleting = false;
    }
    _model.refresh();
  }

  void createCustomTheme() {
    _showColorPicker();
  }

  removeIcon(int index) {
    SharedUtil.instance.readAndRemoveList(Keys.themePowers, index - 7);
    getThemeList();
  }

  void _showColorPicker() {
    final context = _model.context;
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            elevation: 0.0,
            title: Text(MyLocalizations.of(context).pickAColor),
            content: SingleChildScrollView(
              child: MaterialPicker(
                pickerColor: Theme.of(context).primaryColor,
                onColorChanged: (color) {
                  _model.customColor = color;
                },
                enableLabel: true,
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  MyLocalizations.of(context).cancel,
                  style: TextStyle(color: Colors.redAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(MyLocalizations.of(context).ok),
                onPressed: () async {
                  final powers = await SharedUtil.instance.readList(Keys.themePowers) ?? [];
                  if (powers.length >= 10) {
                    _showCanNotAddTheme();
                    return;
                  }
                  ThemePower themePower = ThemePower(
                    themeName: MyLocalizations.of(context).customTheme + " ${powers.length + 1}",
                    themeType: MyLocalizations.of(context).customTheme + " ${powers.length + 1}",
                    colorPower: ColorPower.fromColor(_model.customColor),
                  );
                  final data = jsonEncode(themePower.toMap());
                  powers.add(data);
                  SharedUtil.instance.saveStringList(Keys.themePowers, powers);
                  getThemeList();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showCanNotAddTheme() {
    showDialog(
        context: _model.context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            content: Text(MyLocalizations.of(_model.context).canNotAddMoreTheme),
          );
        });
  }
}
