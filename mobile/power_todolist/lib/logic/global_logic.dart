import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/utils/all_util.dart';

class GlobalLogic {
  final GlobalModel _model;

  GlobalLogic(this._model);

  Color getWhiteInDark() {
    final themeType = _model.currentThemePower.themeType;
    return themeType == MyTheme.darkTheme ? Colors.grey : Colors.white;
  }

  Color getBgInDark() {
    final themeType = _model.currentThemePower.themeType;
    return themeType == MyTheme.darkTheme ? Colors.grey[800] : Colors.white;
  }

  Color getPrimaryInDark(BuildContext context) {
    final themeType = _model.currentThemePower.themeType;
    return themeType == MyTheme.darkTheme ? Colors.grey[800] : Theme.of(context).primaryColor;
  }

  Color getPrimaryGreyInDark(BuildContext context) {
    final themeType = _model.currentThemePower.themeType;
    return themeType == MyTheme.darkTheme ? Colors.grey : Theme.of(context).primaryColor;
  }

  bool isDarkNow() {
    return _model.currentThemePower.themeType == MyTheme.darkTheme;
  }

  Future getCurrentTheme() async {
    final theme = await SharedUtil.instance.getString(Keys.currentThemePower);
    if (theme == null) return;
    ThemePower themePower = ThemePower.fromMap(jsonDecode(theme));
    if (themePower.themeType == _model.currentThemePower.themeType) return;
    _model.currentThemePower = themePower;
  }

  Future getAppName() async {
    final appName = await SharedUtil.instance.getString(Keys.appName);
    if (appName == null) return;
    if (appName == _model.appName) return;
    _model.appName = appName;
  }

  Future getCurrentLanguageCode() async {
    final list = await SharedUtil.instance.getStringList(Keys.currentLanguageCode);
    if (list == null) return;
    if (list == _model.currentLanguageCode) return;
    _model.currentLanguageCode = list;
  }

  Future getCurrentLanguage() async {
    final currentLanguage = await SharedUtil.instance.getString(Keys.currentLanguage);
    if (currentLanguage == null) return;
    if (currentLanguage == _model.currentLanguage) return;
    _model.currentLanguage = currentLanguage;
  }

  Future getIsBgGradient() async {
    final isBgGradient = await SharedUtil.instance.getBoolean(Keys.backgroundGradient);
    if (isBgGradient == null) return;
    if (isBgGradient == _model.isBgGradient) return;
    _model.isBgGradient = isBgGradient;
  }

  Future getCurrentNavHeader() async {
    final currentNavHeader = await SharedUtil.instance.getString(Keys.currentNavHeader);
    if (currentNavHeader == null) return;
    if (currentNavHeader == _model.currentNavHeader) return;
    _model.currentNavHeader = currentNavHeader;
  }

  Future getCurrentNetPicUrl() async {
    final currentNetPicUrl = await SharedUtil.instance.getString(Keys.currentNetPicUrl);
    if (currentNetPicUrl == null) return;
    if (currentNetPicUrl == _model.currentNavHeader) return;
    _model.currentNetPicUrl = currentNetPicUrl;
  }

  Future getIsBgChangeWithCard() async {
    final isBgChangeWithCard = await SharedUtil.instance.getBoolean(Keys.backgroundChangeWithCard);
    if (isBgChangeWithCard == null) return;
    if (isBgChangeWithCard == _model.isBgChangeWithCard) return;
    _model.isBgChangeWithCard = isBgChangeWithCard;
  }

  Future getIsCardChangeWithBg() async {
    final isCardChangeWithBg = await SharedUtil.instance.getBoolean(Keys.cardChangeWithBackground);
    if (isCardChangeWithBg == null) return;
    if (isCardChangeWithBg == _model.isCardChangeWithBg) return;
    _model.isCardChangeWithBg = isCardChangeWithBg;
  }

  Future getEnableInfiniteScroll() async {
    final enableInfiniteScroll = await SharedUtil.instance.getBoolean(Keys.enableInfiniteScroll);
    if (enableInfiniteScroll == null) return;
    if (enableInfiniteScroll == _model.enableInfiniteScroll) return;
    _model.enableInfiniteScroll = enableInfiniteScroll;
  }

  Future getCurrentPosition() async {
    final currentPosition = await SharedUtil.instance.getString(Keys.currentPosition);
    if (currentPosition == null) return;
    if (currentPosition == _model.currentPosition) return;
    _model.currentPosition = currentPosition;
  }
}
