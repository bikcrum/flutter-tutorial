import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/localization_intl.dart';
import '../model/global_model.dart';

class LanguagePage extends StatelessWidget {
  final List<LanguageData> languageDatas = [
    LanguageData("English", "en", "US"),
    LanguageData("Vietnamese", "vi", "VN"),
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
                model.refresh();
              },
              title: Text(languageDatas[index].language),
            );
          }),
        ),
      ),
    );
  }
}

class LanguageData {
  String language;
  String languageCode;
  String countryCode;

  LanguageData(this.language, this.languageCode, this.countryCode);
}
