import 'package:hello_flutter/model/main_page_model.dart';
import 'package:hello_flutter/pages/main_page.dart';
import 'package:provider/provider.dart';

class ProviderConfig {
  static ProviderConfig _instance;

  static ProviderConfig getInstance() {
    if (_instance == null) {
      _instance = ProviderConfig._internal();
    }
    return _instance;
  }

  ProviderConfig._internal();

  ChangeNotifierProvider<MainPageModel> getMainPage({String title}) {
    return ChangeNotifierProvider<MainPageModel>(
      builder: (context) => MainPageModel(title),
      child: MainPage(),
    );
  }
}
