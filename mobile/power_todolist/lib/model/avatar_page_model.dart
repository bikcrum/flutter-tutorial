import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/logic/all_logic.dart';
import 'package:power_todolist/model/all_model.dart';

class AvatarPageModel extends ChangeNotifier {
  BuildContext context;
  AvatarPageLogic logic;
  MainPageModel mainPageModel;

  final cropKey = GlobalKey<CropState>();

  int currentAvatarType = CurrentAvatarType.defaultAvatar;
  String currentAvatarUrl = "images/icon.png";

  AvatarPageModel() {
    logic = AvatarPageLogic(this);
  }

  void setMainPageModel(MainPageModel mainPageModel) {
    if (this.mainPageModel == null) {
      this.mainPageModel = mainPageModel;
      this.currentAvatarType = mainPageModel.currentAvatarType;
      this.currentAvatarUrl = mainPageModel.currentAvatarUrl;
    }
  }

  void setContext(BuildContext context) {
    if (this.context == null) {
      this.context = context;
    }
  }

  @override
  void dispose() {
    cropKey?.currentState?.dispose();
    super.dispose();
    debugPrint("AvatarPageModel disposed");
  }

  void refresh() {
    notifyListeners();
  }
}
