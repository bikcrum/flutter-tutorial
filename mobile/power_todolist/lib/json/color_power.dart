import 'dart:ui';

import 'package:flutter/material.dart';

class ColorPower {
  int red;
  int green;
  int blue;
  double opacity;

  ColorPower({this.red, this.green, this.blue, this.opacity});

  static fromColor(Color color) {
    ColorPower colorData = ColorPower();
    colorData.red = color.red;
    colorData.blue = color.blue;
    colorData.green = color.green;
    colorData.opacity = color.opacity;
    return colorData;
  }

  static Color toColor(ColorPower power) {
    return Color.fromRGBO(power.red, power.green, power.blue, power.opacity);
  }

  static ColorPower fromMap(Map<String, dynamic> map) {
    ColorPower power = new ColorPower();
    power.red = int.parse(map['red']);
    power.green = int.parse(map['green']);
    power.blue = int.parse(map['blue']);
    power.opacity = double.parse(map['opacity']);
    return power;
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'red': red.toString(),
      'green': green.toString(),
      'blue': blue.toString(),
      'opacity': opacity.toString()
    };
  }
}
