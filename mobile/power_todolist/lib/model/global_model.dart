import 'package:flutter/material.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/logic/all_logic.dart';
import 'package:power_todolist/utils/all_util.dart';

import 'main_page_model.dart';

class GlobalModel extends ChangeNotifier {
  BuildContext context;
  GlobalLogic logic;
  MainPageModel mainPageModel;

  String appName = "Todo";

  List<String> currentLanguageCode = [
    "en",
    "US"
  ];
  String currentLanguage = "English";
  Locale currentLocale;

  ThemePower currentThemePower = ThemePower(
    themeName: MyTheme.defaultTheme,
    themeType: MyTheme.defaultTheme,
    colorPower: ColorPower.fromColor(MyThemeColor.defaultColor),
    fontSize: MyThemeFontSize.defaultFontSize,
  );

  bool enableInfiniteScroll = true;

  bool isBgGradient = false;
  bool isBgChangeWithCard = false;
  bool isCardChangeWithBg = false;

  String currentNavHeader = NavHeadType.meteorShower;
  String currentNetPicUrl = "";
  String currentPosition = "";

  GlobalModel() {
    this.logic = GlobalLogic(this);
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      Future.wait([
        logic.getCurrentTheme(),
        logic.getAppName(),
        logic.getCurrentLanguageCode(),
        logic.getCurrentLanguage(),
        logic.getIsBgGradient(),
        logic.getCurrentNavHeader(),
        logic.getCurrentNetPicUrl(),
        logic.getIsBgChangeWithCard(),
        logic.getIsCardChangeWithBg(),
        logic.getEnableInfiniteScroll(),
        logic.getCurrentPosition(),
      ]).then((value) {
        currentLocale = Locale(currentLanguageCode[0], currentLanguageCode[1]);
        refresh();
      });
    }
  }

  void setMainPageModel(MainPageModel mainPageModel) {
    if (this.mainPageModel == null) {
      this.mainPageModel = mainPageModel;
    }
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("GlobalModel disposed");
  }

  void refresh() {
    notifyListeners();
  }
}
