import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/utils/all_util.dart';

class IconListUtil {
  static IconListUtil _instance;

  static IconListUtil getInstance() {
    if (_instance == null) {
      _instance = IconListUtil._internal();
    }
    return _instance;
  }

  IconListUtil._internal();

  List<TaskIconPower> getDefaultTaskIcons(BuildContext context) {
    return [
      TaskIconPower(taskName: MyLocalizations.of(context).music, iconPower: IconPower.fromIconData(Icons.music_note), colorPower: ColorPower.fromColor(MyThemeColor.coffeeColor)),
      TaskIconPower(taskName: MyLocalizations.of(context).game, iconPower: IconPower.fromIconData(Icons.videogame_asset), colorPower: ColorPower.fromColor(MyThemeColor.cyanColor)),
      TaskIconPower(taskName: MyLocalizations.of(context).read, iconPower: IconPower.fromIconData(Icons.book), colorPower: ColorPower.fromColor(MyThemeColor.defaultColor)),
      TaskIconPower(taskName: MyLocalizations.of(context).sports, iconPower: IconPower.fromIconData(Icons.directions_run), colorPower: ColorPower.fromColor(MyThemeColor.greenColor)),
      TaskIconPower(taskName: MyLocalizations.of(context).travel, iconPower: IconPower.fromIconData(Icons.drive_eta), colorPower: ColorPower.fromColor(MyThemeColor.darkColor)),
      TaskIconPower(taskName: MyLocalizations.of(context).work, iconPower: IconPower.fromIconData(Icons.work), colorPower: ColorPower.fromColor(MyThemeColor.blueGrayColor)),
    ];
  }

  Future<List<TaskIconPower>> getIconWithCache(BuildContext context) async {
    List<String> strings = await SharedUtil.instance.readList(Keys.taskIconPowers);
    List<TaskIconPower> list = [];
    for (var o in strings) {
      final data = jsonDecode(o);
      TaskIconPower taskIconPower = TaskIconPower.fromMap(data);
      list.add(taskIconPower);
    }
    final defaultList = getDefaultTaskIcons(context);
    return List.from(defaultList + list);
  }
}
