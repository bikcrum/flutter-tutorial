import 'package:flutter/material.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/logic/all_logic.dart';

class IconSettingPageModel extends ChangeNotifier {
  BuildContext context;
  IconSettingPageLogic logic;

  FocusNode focusNode = FocusNode();
  TextEditingController textEditingController = TextEditingController();

  List<TaskIconPower> taskIcons = [];
  List<IconPower> showIcons = [];
  List<IconPower> searchIcons = [];

  Color currentPickerColor = Colors.black;
  String currentIconName = "";
  bool isDeleting = false;
  bool isSearching = false;

  IconSettingPageModel() {
    logic = IconSettingPageLogic(this);
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;

      Future.wait([
        logic.getTaskIconList(),
        logic.getIconList(),
      ]).then((value) {
        refresh();
      });
    }
  }

  void refresh() {
    notifyListeners();
  }
}
