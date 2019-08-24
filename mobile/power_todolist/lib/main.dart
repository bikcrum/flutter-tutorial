import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:power_todolist/config/provider_config.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/global_model.dart';
import 'package:power_todolist/utils/theme_util.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ProviderConfig.getInstance().getGlobal(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context)..setContext(context);

    return MaterialApp(
      title: model.appName,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        MyLocalizationsDelegate(),
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('vi', 'VN'),
      ],
      locale: model.currentLocale,
      theme: ThemeUtil.getInstance().getTheme(model.currentThemePower),
      home: ProviderConfig.getInstance().getMainPage(),
    );
  }
}
