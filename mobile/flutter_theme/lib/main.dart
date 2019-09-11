import 'package:flutter/material.dart';
import 'package:flutter_theme/config/provider_config.dart';
import 'package:flutter_theme/model/global_model.dart';
import 'package:flutter_theme/utils/theme_util.dart';
import 'package:provider/provider.dart';

void main() => runApp(ProviderConfig.shared().getGlobal(MyApp()));

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context);
    return MaterialApp(
      title: model.appName,
      theme: ThemeUtil.shared().getTheme(model.currentThemePower),
      home: ProviderConfig.shared().getMainPage(),
    );
  }
}

