import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:power_todolist/l10n/messages_all.dart';

class MyLocalizations {
  static Future<MyLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return MyLocalizations();
    });
  }

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  String get appName => Intl.message("Todo List", name: "appName", desc: "app name");
  String get music => Intl.message("Music", name: "music", desc: "music");
  String get game => Intl.message("Game", name: "game", desc: "game");
  String get read => Intl.message("Read", name: "read", desc: "read");
  String get sports => Intl.message("Sports", name: "sports", desc: "sports");
  String get travel => Intl.message("Travel", name: "travel", desc: "travel");
  String get work => Intl.message("Work", name: "work", desc: "work");
  String get welcomeWord => Intl.message("Hello! ", name: "welcomeWord", desc: "welcomeWord");
  String get loadingEmpty => Intl.message('nothing at all', name: 'loadingEmpty', desc: 'loadingEmpty');
  String get loadingIdle => Intl.message('...', name: 'loadingIdle', desc: 'loadingIdle');
  String get loadingError => Intl.message('loading error', name: 'loadingError', desc: 'loadingError');
  String get loading => Intl.message('loading...', name: 'loading', desc: 'loading');
  String get reLoading => Intl.message('click to reload', name: 'reLoading', desc: 'reLoading');
  String get doneList => Intl.message('Done List', name: 'doneList', desc: 'doneList');
  String get languageTitle => Intl.message('Change Language', name: 'languageTitle', desc: 'languageTitle');
  String get changeTheme => Intl.message('Change Theme', name: 'changeTheme', desc: 'changeTheme');
  String get appSetting => Intl.message('Setting', name: 'appSetting', desc: 'appSetting');
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

  String get pink => Intl.message('pink', name: 'pink', desc: 'pink');
  String get coffee => Intl.message('coffee', name: 'coffee', desc: 'coffee');
  String get cyan => Intl.message('cyan', name: 'cyan', desc: 'cyan');
  String get green => Intl.message('green', name: 'green', desc: 'green');
  String get purple => Intl.message('purple', name: 'purple', desc: 'purple');
  String get dark => Intl.message('dark', name: 'dark', desc: 'dark');
  String get blueGray => Intl.message('blue gray', name: 'blueGray', desc: 'blueGray');
  String get pickAColor => Intl.message('Pick a color!', name: 'pickAColor', desc: 'pickAColor');
  String get cancel => Intl.message('cancel', name: 'cancel', desc: 'cancel');
  String get ok => Intl.message('ok', name: 'ok', desc: 'ok');
  String get customTheme => Intl.message('Theme', name: 'customTheme', desc: 'customTheme');
  String get canNotAddMoreTheme => Intl.message('You can only customize up to 10 themes.', name: 'canNotAddMoreTheme', desc: 'canNotAddMoreTheme');
  String get backgroundGradient => Intl.message('Background Gradient', name: 'backgroundGradient', desc: 'backgroundGradient');
  String get bgChangeWithCard => Intl.message('Background follow task icon color', name: 'bgChangeWithCard', desc: 'bgChangeWithCard');
  String get cardChangeWithBg => Intl.message('Task icon color follow background', name: 'cardChangeWithBg', desc: 'cardChangeWithBg');
  String get enableInfiniteScroll => Intl.message('Task card cycle slide', name: 'enableInfiniteScroll', desc: 'enableInfiniteScroll');
  String get iconSetting => Intl.message('Icon Setting', name: 'iconSetting', desc: 'iconSetting');
  String get navigatorSetting => Intl.message('Navigator Setting', name: 'navigatorSetting', desc: 'navigatorSetting');
  String get aboutApp => Intl.message('About', name: 'aboutApp', desc: 'aboutApp');
  String get version100 => Intl.message(
      'Version:1.0.0 \n\n'
      'The Version 1.0.0 released!\n',
      name: 'version100',
      desc: 'version100');

  String get version101 => Intl.message(
      'Version:1.0.1 \n\n'
      '1.Fixed: done list show error \n'
      '2.Add: Edit page can add start-date and deadline\n',
      name: 'version101',
      desc: 'version101');

  String get version102 => Intl.message(
      'Version:1.0.2 \n\n'
      '1.Fixed: some bugs \n'
      '2.Add: IconSetting Page can search icons now \n',
      name: 'version102',
      desc: 'version102');

  String get version103 => Intl.message(
      'Version:1.0.3 \n\n'
      '1.Fixed: The text color of the upgrade frame is wrong.(dark mode) \n'
      '2.Fixed: Done List complete time is negative. \n'
      '3.Add: Suggestion display wall. \n',
      name: 'version103',
      desc: 'version103');

  String get versionDescription => Intl.message('Version Description', name: 'versionDescription', desc: 'versionDescription');
  String get projectLink => Intl.message('Project Link', name: 'projectLink', desc: 'projectLink');
  String get myGithub => Intl.message('Author\'s Github', name: 'myGithub', desc: 'myGithub');
  String get meteorShower => Intl.message('Meteor Shower', name: 'meteorShower', desc: 'meteorShower');
  String get dailyPic => Intl.message('Daily wallpaper', name: 'dailyPic', desc: 'dailyPic');
  String get netPicture => Intl.message('Network Picture', name: 'netPicture', desc: 'netPicture');
  String get picture => Intl.message('Picture', name: 'picture', desc: 'picture');
  String get pullUpToLoadMore => Intl.message('pull up load more', name: 'pullUpToLoadMore', desc: 'pullUpToLoadMore');
  String get pullDownToRefresh => Intl.message('pull down to refresh', name: 'pullDownToRefresh', desc: 'pullDownToRefresh');
  String get tryToSearch => Intl.message('Try searching for the title or content', name: 'tryToSearch', desc: 'tryToSearch');
  String get searchIcon => Intl.message('Try searching for icon name', name: 'searchIcon', desc: 'searchIcon');
  String get currentIcons => Intl.message('Current Icons', name: 'currentIcons', desc: 'currentIcons');
  String get customIcon => Intl.message('Custom Icon', name: 'customIcon', desc: 'customIcon');
  String get defaultIconName => Intl.message('default', name: 'defaultIconName', desc: 'defaultIconName');
  String get canNotAddMoreIcon => Intl.message('You can only customize up to 10 icons.', name: 'canNotAddMoreIcon', desc: 'canNotAddMoreIcon');
  String get setIconName => Intl.message('icon name', name: 'setIconName', desc: 'setIconName');
  String get canNotEditDefaultIcon => Intl.message('Can\'t edit the default icon', name: 'canNotEditDefaultIcon', desc: 'canNotEditDefaultIcon');
  String get avatar => Intl.message('avatar', name: 'avatar', desc: 'avatar');
  String get avatarLocal => Intl.message('Select an avatar from the local', name: 'avatarLocal', desc: 'avatarLocal');
  String get avatarHistory => Intl.message('Select an avatar from the history', name: 'avatarHistory', desc: 'avatarHistory');
  String get avatarNet => Intl.message('Select an avatar from the network', name: 'avatarNet', desc: 'avatarNet');
  String get save => Intl.message('save', name: 'save', desc: 'save');
  String get deniedDes => Intl.message('Permission denied', name: 'deniedDes', desc: 'deniedDes');
  String get openSystemSetting => Intl.message('Open System Setting', name: 'openSystemSetting', desc: 'openSystemSetting');
  String get submit => Intl.message('Submit', name: 'submit', desc: 'submit');
  String get defaultTitle => Intl.message('Default title', name: 'defaultTitle', desc: 'defaultTitle');
  String get writeAtLeastOneTaskItem => Intl.message('Please write at least one task.', name: 'writeAtLeastOneTaskItem', desc: 'writeAtLeastOneTaskItem');
  String get addTask => Intl.message('add a task', name: 'addTask', desc: 'addTask');
  String get startDate => Intl.message('start date', name: 'startDate', desc: 'startDate');
  String get deadline => Intl.message('deadline', name: 'deadline', desc: 'deadline');
  String get startAfterEnd => Intl.message('The start date need be smaller than the end date.', name: 'startAfterEnd', desc: 'startAfterEnd');
  String get endBeforeStart => Intl.message('The end date need be bigger than the start date.', name: 'endBeforeStart', desc: 'endBeforeStart');
  String get editTask => Intl.message('Edit', name: 'editTask', desc: 'editTask');
  String get deleteTask => Intl.message('Delete', name: 'deleteTask', desc: 'deleteTask');
  String hours(int hours) {
    return Intl.plural(hours,
        zero: "Too Fast",
        one: "1 hour",
        many: "$hours hours",
        other: "$hours hours",
        args: [
          hours
        ],
        name: "hours");
  }

  String days(int days) {
    return Intl.plural(days,
        zero: "Too Fast",
        one: "1 day",
        many: "$days days",
        other: "$days days",
        args: [
          days
        ],
        name: "days");
  }

  String itemNumber(int number) {
    return Intl.plural(number,
        zero: "There is No items ",
        one: "1 item ",
        other: "$number items ",
        args: [
          number
        ],
        name: "itemNumber");
  }

  String get toFinishTask => Intl.message('Try to complete a task!', name: 'toFinishTask', desc: 'toFinishTask');
  String get taskNum => Intl.message('Task Number', name: 'taskNum', desc: 'taskNum');
  String get createDate => Intl.message('Create Date', name: 'createDate', desc: 'createDate');
  String get spendTime => Intl.message('Spend Time', name: 'spendTime', desc: 'spendTime');
  String get changedTimes => Intl.message('Changed Times', name: 'changedTimes', desc: 'changedTimes');
  String get completeDate => Intl.message('Complete Date', name: 'completeDate', desc: 'completeDate');
  String get customUserName => Intl.message('Setting your username', name: 'customUserName', desc: 'customUserName');
  String get inputUserName => Intl.message('input your username', name: 'inputUserName', desc: 'inputUserName');
  String get userNameCantBeNull => Intl.message('username can not be empty', name: 'userNameCantBeNull', desc: 'userNameCantBeNull');
}

class MyLocalizationsDelegate extends LocalizationsDelegate<MyLocalizations> {
  const MyLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [
        'en',
        'vi'
      ].contains(locale.languageCode);

  @override
  Future<MyLocalizations> load(Locale locale) => MyLocalizations.load(locale);

  @override
  bool shouldReload(LocalizationsDelegate<MyLocalizations> old) => false;
}
