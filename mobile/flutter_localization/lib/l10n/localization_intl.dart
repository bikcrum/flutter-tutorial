import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'messages_all.dart';

class MyLocalizations {
  static Future<MyLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((b) {
      Intl.defaultLocale = localeName;
      return new MyLocalizations();
    });
  }

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  String get welcome {
    return Intl.message(
      'Hello! ',
      name: 'welcome',
      desc: 'welcome',
    );
  }

  String taskItems(int taskNumbers) {
    return Intl.plural(taskNumbers,
        zero: "You have never written a list of tasks.\nLet's get started soon.",
        one: "This is your todo-list,\nToday, you have 1 task to complete. ",
        many: "This is your todo-list,\nToday, you have $taskNumbers tasks to complete. ",
        other: "This is your todo-list,\nToday, you have $taskNumbers tasks to complete. ",
        args: [
          taskNumbers
        ],
        name: "taskItems");
  }

  String get languageTitle {
    return Intl.message(
      'Change Language',
      name: 'languageTitle',
      desc: 'languageTitle',
    );
  }
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
        'vi'
      ].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) {
    return MyLocalizations.load(locale);
  }

  @override
  bool shouldReload(MyLocalizationsDelegate old) => false;
}
