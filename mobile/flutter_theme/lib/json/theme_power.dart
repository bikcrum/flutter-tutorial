import 'package:flutter_theme/config/global_config.dart';

import 'color_power.dart';

class ThemePower {
  final ColorPower colorPower;
  final double fontSize;
  final ThemeType themeType;

  ThemePower({this.colorPower, this.fontSize = 20, this.themeType = ThemeType.light});

  factory ThemePower.fromMap(Map<String, dynamic> map) {
    return ThemePower(
      colorPower: ColorPower.fromMap(map['colorPower']),
      themeType: ThemePower.themeTypeFromString(map['themeType'].toString()),
    );
  }

  static ThemeType themeTypeFromString(String type) {
    return ThemeType.values.firstWhere((t) => t.toString().replaceFirst('ThemeType.', '') == type);
  }

  Map<dynamic, dynamic> toMap() {
    return {'colorPower': colorPower.toMap()};
  }

  @override
  bool operator ==(other) {
    return colorPower == other.colorPower
        && fontSize == other.fontSize
        && themeType == other.themeType;
  }

  @override
  int get hashCode => super.hashCode;
}
