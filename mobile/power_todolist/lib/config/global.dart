enum LoadingFlag { loading, error, success, empty, idle }

enum AvatarType {
  local,
  history,
}

class CurrentAvatarType {
  static const int defaultAvatar = 0;
  static const int local = 1;
  static const int net = 2;
}

class NavHeadType {
  static const String meteorShower = "MeteorShower";
  static const String dailyPic = "DailyPic";
  static const String netPicture = "NetPicture";

  static const String DAILY_PIC_URL = "https://devexps.com/ptldwp.php";
}

class LanguageData {
  String language;
  String languageCode;
  String countryCode;
  String appName;

  LanguageData(this.language, this.languageCode, this.countryCode, this.appName);
}

class TaskStatus {
  static const int todo = 0;
  static const int doing = 1;
  static const int done = 2;
}