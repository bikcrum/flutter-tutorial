import 'package:flutter/material.dart';
import 'package:flutter_theme/model/global_model.dart';
import 'package:flutter_theme/model/theme_page_model.dart';
import 'package:flutter_theme/pages/main_page.dart';
import 'package:flutter_theme/pages/theme_page.dart';
import 'package:provider/provider.dart';

class ProviderConfig {
  static ProviderConfig _sInstance;

  factory ProviderConfig.shared() {
    if (_sInstance == null) {
      _sInstance = ProviderConfig._internal();
    }
    return _sInstance;
  }

  ProviderConfig._internal();

  ChangeNotifierProvider<GlobalModel> getGlobal(Widget child) {
    return ChangeNotifierProvider<GlobalModel>(
      builder: (_) => GlobalModel(),
      child: child,
    );
  }

  ChangeNotifierProvider getMainPage() {
    return ChangeNotifierProvider(
      builder: (_) => null,
      child: MainPage(),
    );
  }

  ChangeNotifierProvider<ThemePageModel> getThemePage() {
    return ChangeNotifierProvider(
      builder: (_) => ThemePageModel(),
      child: ThemePage(),
    );
  }
}
