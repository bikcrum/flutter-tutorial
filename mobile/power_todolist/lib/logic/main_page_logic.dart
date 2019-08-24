import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/config/provider_config.dart';
import 'package:power_todolist/database/database.dart';
import 'package:power_todolist/items/task_item.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/utils/all_util.dart';
import 'package:power_todolist/widgets/all_widget.dart';

class MainPageLogic {
  final MainPageModel _model;

  MainPageLogic(this._model);

  Future getCurrentUserName() async {
    final currentUserName = await SharedUtil.instance.getString(Keys.currentUserName);
    if (currentUserName == null) return;
    if (currentUserName == _model.currentUserName) return;
    _model.currentUserName = currentUserName;
  }

  Decoration getBackground(GlobalModel globalModel) {
    bool isBgGradient = globalModel.isBgGradient;
    bool isBgChangeWithCard = globalModel.isBgChangeWithCard;
    return BoxDecoration(
      gradient: isBgGradient
          ? LinearGradient(
              colors: _getGradientColors(isBgChangeWithCard),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            )
          : null,
      color: _getBgColor(isBgGradient, isBgChangeWithCard),
    );
  }

  List<Color> _getGradientColors(bool isBgChangeWithCard) {
    final context = _model.context;
    if (!isBgChangeWithCard) {
      return [
        Theme.of(context).primaryColorLight,
        Theme.of(context).primaryColor,
        Theme.of(context).primaryColorDark,
      ];
    } else {
      return [
        ThemeUtil.getInstance().getLightColor(getCurrentCardColor()),
        getCurrentCardColor(),
        ThemeUtil.getInstance().getDarkColor(getCurrentCardColor()),
      ];
    }
  }

  Color _getBgColor(bool isBgGradient, bool isBgChangeWithCard) {
    if (isBgGradient) {
      return null;
    }
    final context = _model.context;
    final primaryColor = Theme.of(context).primaryColor;
    return isBgChangeWithCard ? getCurrentCardColor() : primaryColor;
  }

  Widget getAvatarWidget() {
    switch (_model.currentAvatarType) {
      case CurrentAvatarType.local:
        File file = File(_model.currentAvatarUrl);
        return Image.file(
          file,
          fit: BoxFit.fill,
        );
        break;
      case CurrentAvatarType.net:
        return Image.network(
          _model.currentAvatarUrl,
          fit: BoxFit.cover,
        );
        break;
      default:
        return Image.asset(
          "images/icon.png",
          fit: BoxFit.cover,
        );
        break;
    }
  }

  void onUserNameTap() {
    final context = _model.context;
    showDialog(
      context: context,
      builder: (ctx) {
        return EditDialogWidget(
          title: MyLocalizations.of(context).customUserName,
          hintText: MyLocalizations.of(context).inputUserName,
          onValueChanged: (text) {
            _model.currentUserName = text;
          },
          initialValue: _model.currentUserName,
          onPositive: () {
            if (_model.currentUserName.isEmpty) {
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      content: Text(MyLocalizations.of(context).userNameCantBeNull),
                    );
                  });
              return;
            }
            SharedUtil.instance.saveString(Keys.currentUserName, _model.currentUserName);
            _model.refresh();
          },
        );
      },
    );
  }

  Color getCurrentCardColor() {
    final context = _model.context;
    final primaryColor = Theme.of(context).primaryColor;
    int index = _model.currentCardIndex;
    int taskLength = _model.tasks.length;
    if (taskLength == 0) return primaryColor;
    if (index > taskLength - 1) return primaryColor;
    return ColorPower.toColor(_model.tasks[index].taskIconPower.colorPower);
  }

  Widget getEmptyWidget(GlobalModel globalModel) {
    final context = _model.context;
    final size = MediaQuery.of(context).size;
    final theMin = min(size.width, size.height) / 2;
    return Container(
      margin: EdgeInsets.only(top: 40),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        "svgs/empty_list.svg",
        color: globalModel.logic.getWhiteInDark(),
        width: theMin,
        height: theMin,
        semanticsLabel: 'empty list',
      ),
    );
  }

  List<Widget> getCards(BuildContext context) {
    return List.generate(_model.tasks.length, (index) {
      final taskPower = _model.tasks[index];
      return GestureDetector(
        child: TaskItem(
          taskPower.id,
          taskPower,
          onEdit: () => _model.logic.editTask(taskPower),
          onDelete: () => _model.logic.deleteTask(taskPower.id),
        ),
        onTap: () {
          _model.currentTapIndex = index;
          Navigator.of(context).push(
            new PageRouteBuilder(
              pageBuilder: (ctx, anm, anmS) {
                return ProviderConfig.getInstance().getTaskDetailPage(taskPower.id, taskPower);
              },
              transitionDuration: Duration(milliseconds: 800),
            ),
          );
        },
      );
    });
  }

  void editTask(TaskPower taskPower) {
    Navigator.of(_model.context).push(
      new CupertinoPageRoute(
        builder: (ctx) {
          return ProviderConfig.getInstance().getEditTaskPage(
            taskPower.taskIconPower,
            taskPower: taskPower,
          );
        },
      ),
    );
  }

  void deleteTask(int id) {
    DBProvider.db.deleteTask(id).then((a) {
      getTasks().then((value) {
        _model.refresh();
      });
    });
  }

  void onAvatarTap() {
    Navigator.of(_model.context).push(
      new CupertinoPageRoute(
        builder: (ctx) {
          return ProviderConfig.getInstance().getAvatarPage(mainPageModel: _model);
        },
      ),
    );
  }

  Future getAvatarType() async {
    final currentAvatarType = await SharedUtil.instance.getInt(Keys.currentAvatarType);
    debugPrint("type:${currentAvatarType}");
    if (currentAvatarType == null) return;
    if (currentAvatarType == _model.currentAvatarType) return;
    _model.currentAvatarType = currentAvatarType;
  }

  Future getCurrentAvatar() async {
    switch (_model.currentAvatarType) {
      case CurrentAvatarType.defaultAvatar:
        final path = await FileUtil.getInstance().copyAssetToFile("images/", "icon.png", "/avatar/", "icon.png");
        _model.currentAvatarUrl = path;
        _model.currentAvatarType = CurrentAvatarType.local;
        SharedUtil().saveString(Keys.localAvatarPath, path);
        break;
      case CurrentAvatarType.local:
        final path = await SharedUtil().getString(Keys.localAvatarPath) ?? "";
        File file = File(path);
        if (file.existsSync()) {
          _model.currentAvatarUrl = file.path;
        } else {
          final avatarPath = await FileUtil.getInstance().copyAssetToFile("images/", "icon.png", "/avatar/", "icon.png");
          SharedUtil().saveString(Keys.localAvatarPath, avatarPath);
          _model.currentAvatarUrl = avatarPath;
        }
        break;
      case CurrentAvatarType.net:
        final net = await SharedUtil().getString(Keys.netAvatarPath);
        _model.currentAvatarUrl = net;
        break;
    }
  }

  Future getTasks() async {
    final tasks = await DBProvider.db.getTasks();
    if (tasks == null) return;
    _model.tasks.clear();
    _model.tasks.addAll(tasks);
  }

  void onSearchTap() {
    Navigator.of(_model.context).push(new CupertinoPageRoute(builder: (ctx) {
      return ProviderConfig.getInstance().getSearchPage();
    }));
  }
}
