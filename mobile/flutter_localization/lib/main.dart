import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'config/provider_config.dart';
import 'l10n/localization_intl.dart';
import 'model/global_model.dart';

void main() {
  runApp(
    ProviderConfig.getInstance().getGlobal(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context);

    return MaterialApp(
      title: model.appName,
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        MyLocalizationsDelegate()
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('vi', 'VN'),
      ],
      locale: model.currentLocale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProviderConfig.getInstance().getMainPage(),
    );
  }
}
