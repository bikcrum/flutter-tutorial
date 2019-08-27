import 'package:flutter/material.dart';

class GlobalModel extends ChangeNotifier {
  String appName = "Flutter Localization Example";

  List<String> currentLanguageCode = [
    "en",
    "US"
  ];
  String currentLanguage = "English";
  Locale currentLocale;

  void refresh() {
    notifyListeners();
  }
}
