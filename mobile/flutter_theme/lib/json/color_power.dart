import 'dart:ui';

import 'package:flutter/material.dart';

class ColorPower {
  int red;
  int green;
  int blue;
  double opacity;

  ColorPower({this.red, this.green, this.blue, this.opacity});

  factory ColorPower.fromColor(Color color) {
    ColorPower colorData = ColorPower();
    colorData.red = color.red;
    colorData.blue = color.blue;
    colorData.green = color.green;
    colorData.opacity = color.opacity;
    return colorData;
  }

  factory ColorPower.fromMap(Map<String, dynamic> map) {
    ColorPower power = new ColorPower();
    power.red = int.parse(map['red']);
    power.green = int.parse(map['green']);
    power.blue = int.parse(map['blue']);
    power.opacity = double.parse(map['opacity']);
    return power;
  }

  static Color toColor(ColorPower power) {
    return power.color();
  }

  Color color() {
    return Color.fromRGBO(red, green, blue, opacity);
  }

  Map<dynamic, dynamic> toMap() {
    return {
      'red': red.toString(),
      'green': green.toString(),
      'blue': blue.toString(),
      'opacity': opacity.toString()
    };
  }

  @override
  bool operator ==(other) {
    return red == other.red
        && green == other.green
        && blue == other.blue
        && opacity == other.opacity;
  }

  @override
  int get hashCode => super.hashCode;
}
