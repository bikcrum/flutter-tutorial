import 'package:flutter/material.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/logic/all_logic.dart';

class MainPageModel extends ChangeNotifier {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  BuildContext context;
  MainPageLogic logic;

  int currentAvatarType = CurrentAvatarType.defaultAvatar;
  String currentAvatarUrl = "images/icon.png";
  String currentUserName = "";

  List<TaskPower> tasks = [];

  int currentCardIndex = 0;
  int currentTapIndex = 0;

  MainPageModel() {
    this.logic = MainPageLogic(this);
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
      logic.getAvatarType().then((value) {
        Future.wait(
          [
            logic.getTasks(),
            logic.getCurrentAvatar(),
            logic.getCurrentUserName(),
          ],
        ).then((value) {
          refresh();
        });
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint("MainPageModel disposed");
  }

  void refresh() {
    notifyListeners();
  }
}
