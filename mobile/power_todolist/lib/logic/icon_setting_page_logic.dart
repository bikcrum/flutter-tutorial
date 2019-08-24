import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/utils/all_util.dart';
import 'package:power_todolist/widgets/all_widget.dart';

class IconSettingPageLogic {
  final IconSettingPageModel _model;

  IconSettingPageLogic(this._model);

  AppBar getSearchBar(GlobalModel globalModel) {
    final textColor = globalModel.logic.getWhiteInDark();

    return AppBar(
      title: TextField(
        textInputAction: TextInputAction.search,
        autofocus: true,
        focusNode: _model.focusNode,
        style: TextStyle(color: textColor),
        controller: _model.textEditingController
          ..addListener(() {
            final text = _model.textEditingController.text;
            onSearchTextChange(text);
          }),
        onEditingComplete: () => _model.focusNode.unfocus(),
        decoration: new InputDecoration(
          hintText: MyLocalizations.of(_model.context).searchIcon,
          hintStyle: TextStyle(color: textColor),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.clear,
              color: textColor,
            ),
            onPressed: () => _model.textEditingController.clear(),
          ),
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
        ),
      ),
    );
  }

  void onSearchTextChange(String text) {
    if (text == null) return;
    _model.searchIcons.clear();
    if (text.isEmpty) {
      _model.refresh();
      return;
    }

    for (var i = 0; i < _model.showIcons.length; ++i) {
      final icon = _model.showIcons[i];
      final iconName = icon.iconName;
      if (iconName.contains(text)) {
        _model.searchIcons.add(icon);
      }
    }

    _model.refresh();
  }

  Future getTaskIconList() async {
    final list = await IconListUtil.getInstance().getIconWithCache(_model.context);
    _model.taskIcons.clear();
    _model.taskIcons.addAll(list);
    if (list.length == 6) {
      _model.isDeleting = false;
    }
  }

  Future getIconList() async {
    final iconList = await IconPower.loadAsset();
    _model.showIcons.clear();
    _model.showIcons.addAll(iconList);
  }

  Widget getIconsWidget() {
    final context = _model.context;
    final showIcons = _model.showIcons;
    final searchIcons = _model.searchIcons;

    final showIconList = searchIcons.isEmpty ? showIcons : searchIcons;

    if (showIcons.isEmpty) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
        ),
      );
    }

    if (_model.isSearching && searchIcons.isEmpty && _model.textEditingController.text.isNotEmpty) {
      return Center(
        child: LoadingWidget(
          flag: LoadingFlag.empty,
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 5,
      childAspectRatio: 0.8,
      padding: EdgeInsets.all(2),
      children: List.generate(
        showIconList.length,
        (index) {
          final icon = showIconList[index];
          final name = showIconList[index].iconName;
          return Container(
            margin: EdgeInsets.all(4),
            child: Column(
              children: <Widget>[
                IconButton(
                  onPressed: () => onIconPress(icon),
                  icon: Icon(
                    IconPower.toIconData(icon),
                    size: 30,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 10),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void onIconPress(IconPower iconPower, {ColorPower colorPower, String name, bool isEdit = false, int index}) {
    showDialog(
        context: _model.context,
        barrierDismissible: false,
        builder: (ctx) {
          return AlertDialog(
            elevation: 0.0,
            contentPadding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Text(MyLocalizations.of(_model.context).customIcon),
            content: CustomIconWidget(
              iconData: IconPower.toIconData(iconPower),
              iconName: name ?? iconPower.iconName,
              pickerColor: colorPower == null ? _model.currentPickerColor : ColorPower.toColor(colorPower),
              onApplyTap: (color) async {
                _model.currentPickerColor = color;
                ColorPower colorPower = ColorPower.fromColor(_model.currentPickerColor);
                TaskIconPower taskIconPower = TaskIconPower(
                  taskName: _model.currentIconName.isEmpty ? MyLocalizations.of(_model.context).defaultIconName : _model.currentIconName,
                  colorPower: colorPower,
                  iconPower: iconPower,
                );
                final data = jsonEncode(taskIconPower.toMap());
                if (isEdit) {
                  SharedUtil.instance.readAndExchangeList(Keys.taskIconPowers, data, index - 6);
                } else {
                  final canAddMore = await SharedUtil.instance.readAndSaveList(Keys.taskIconPowers, data);
                  if (!canAddMore) {
                    showCanNotAddIcon();
                  }
                }
                getTaskIconList().then((value) {
                  _model.refresh();
                });
              },
              onTextChange: (text) {
                final name = text.isEmpty ? MyLocalizations.of(_model.context).defaultIconName : text;
                _model.currentIconName = name;
              },
            ),
          );
        });
  }

  void showCanNotAddIcon() {
    showDialog(
        context: _model.context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            content: Text(MyLocalizations.of(_model.context).canNotAddMoreIcon),
          );
        });
  }

  void tapDefaultIcon(int index) {
    if (index <= 5) {
      showDialog(
        context: _model.context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Text(MyLocalizations.of(_model.context).canNotEditDefaultIcon),
          );
        },
      );
    }
  }

  void removeIcon(int index) {
    SharedUtil.instance.readAndRemoveList(Keys.taskIconPowers, index - 6);
    getTaskIconList().then((value) {
      _model.refresh();
    });
  }
}
