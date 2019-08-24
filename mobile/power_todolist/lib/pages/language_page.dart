import 'package:flutter/material.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/utils/all_util.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatelessWidget {
  final List<LanguageData> languageDatas = [
    LanguageData("English", "en", "US", "One Day"),
    LanguageData("Vietnamese", "vi", "VN", "Một ngày"),
  ];

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<GlobalModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).languageTitle),
      ),
      body: Container(
        child: ListView(
          children: List.generate(languageDatas.length, (index) {
            final String languageCode = languageDatas[index].languageCode;
            final String countryCode = languageDatas[index].countryCode;
            final String language = languageDatas[index].language;
            final String appName = languageDatas[index].appName;

            return RadioListTile(
              value: language,
              groupValue: model.currentLanguage,
              onChanged: (value) {
                model.currentLanguageCode = [
                  languageCode,
                  countryCode
                ];
                model.currentLanguage = language;
                model.currentLocale = Locale(languageCode, countryCode);
                model.appName = appName;
                model.refresh();
                SharedUtil.instance.saveStringList(Keys.currentLanguageCode, [
                  languageCode,
                  countryCode
                ]);
                SharedUtil.instance.saveString(Keys.currentLanguage, language);
                SharedUtil.instance.saveString(Keys.appName, appName);
              },
              title: Text(languageDatas[index].language),
            );
          }),
        ),
      ),
    );
  }
}
