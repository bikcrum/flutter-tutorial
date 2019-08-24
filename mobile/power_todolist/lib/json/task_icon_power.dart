import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:power_todolist/json/all_power.dart';

class TaskIconPower {
  String taskName;
  IconPower iconPower;
  ColorPower colorPower;

  TaskIconPower({this.taskName, this.iconPower, this.colorPower});

  static TaskIconPower fromMap(Map<String, dynamic> map) {
    TaskIconPower power = new TaskIconPower();
    power.taskName = map['taskName'];
    power.colorPower = ColorPower.fromMap(map['colorPower']);
    power.iconPower = IconPower.fromMap(map['iconPower']);
    return power;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'taskName': taskName,
      'iconPower': iconPower.toMap(),
      'colorPower': colorPower.toMap()
    };
  }
}

class IconPower {
  int codePoint;
  String fontFamily;
  String fontPackage;
  String iconName;
  bool matchTextDirection;

  IconPower({this.codePoint, this.fontFamily, this.fontPackage, this.iconName, this.matchTextDirection});

  static IconData toIconData(IconPower icon) {
    return IconData(
      icon.codePoint,
      fontFamily: icon.fontFamily,
    );
  }

  static IconPower fromIconData(IconData iconData) {
    return IconPower(
      codePoint: iconData.codePoint,
      fontFamily: iconData.fontFamily,
      fontPackage: iconData.fontPackage,
      matchTextDirection: iconData.matchTextDirection,
    );
  }

  static IconPower fromMap(Map<String, dynamic> map) {
    IconPower power = new IconPower();
    power.codePoint = int.parse(map['codePoint']);
    power.fontFamily = map['fontFamily'];
    power.fontPackage = map['fontPackage'];
    power.iconName = map['iconName'];
    power.matchTextDirection = map['matchTextDirection'] == 'ture';
    return power;
  }

  static List<IconPower> fromMapList(dynamic mapList) {
    List<IconPower> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }

  static Future<List<IconPower>> loadAsset() async {
    String json = await rootBundle.loadString('local_json/icon_json.json');
    return IconPower.fromMapList(jsonDecode(json));
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'codePoint': codePoint.toString(),
      'fontFamily': fontFamily ?? "",
      'fontPackage': fontPackage ?? "",
      'iconName': iconName ?? "",
      'matchTextDirection': matchTextDirection.toString()
    };
  }
}
