import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/config/provider_config.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/utils/all_util.dart';
import 'package:provider/provider.dart';

import 'all_page.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).appSetting),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text(MyLocalizations.of(context).backgroundGradient),
            secondary: const Icon(
              Icons.invert_colors,
            ),
            value: globalModel.isBgGradient,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              globalModel.isBgGradient = value;
              SharedUtil.instance.saveBoolean(Keys.backgroundGradient, globalModel.isBgGradient);
              globalModel.refresh();
            },
          ),
          SwitchListTile(
            title: Text(MyLocalizations.of(context).bgChangeWithCard),
            secondary: const Icon(
              Icons.format_color_fill,
            ),
            value: globalModel.isBgChangeWithCard,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              globalModel.isBgChangeWithCard = value;
              if (globalModel.isCardChangeWithBg && value) {
                globalModel.isCardChangeWithBg = false;
                SharedUtil.instance.saveBoolean(Keys.cardChangeWithBackground, false);
              }
              SharedUtil.instance.saveBoolean(Keys.backgroundChangeWithCard, globalModel.isBgChangeWithCard);
              globalModel.refresh();
            },
          ),
          SwitchListTile(
            title: Text(MyLocalizations.of(context).cardChangeWithBg),
            secondary: Transform(
              transform: Matrix4.rotationY(pi),
              origin: Offset(12, 0.0),
              child: const Icon(
                Icons.format_color_fill,
              ),
            ),
            value: globalModel.isCardChangeWithBg,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              globalModel.isCardChangeWithBg = value;
              if (globalModel.isBgChangeWithCard && value) {
                globalModel.isBgChangeWithCard = false;
                SharedUtil.instance.saveBoolean(Keys.backgroundChangeWithCard, false);
              }
              SharedUtil.instance.saveBoolean(Keys.cardChangeWithBackground, globalModel.isCardChangeWithBg);
              globalModel.refresh();
            },
          ),
          SwitchListTile(
            title: Text(MyLocalizations.of(context).enableInfiniteScroll),
            secondary: const Icon(
              Icons.repeat,
            ),
            value: globalModel.enableInfiniteScroll,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (value) {
              globalModel.enableInfiniteScroll = value;
              SharedUtil.instance.saveBoolean(Keys.enableInfiniteScroll, globalModel.enableInfiniteScroll);
              globalModel.refresh();
            },
          ),
          ListTile(
            title: Text(MyLocalizations.of(context).iconSetting),
            leading: Icon(
              Icons.insert_emoticon,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                return ProviderConfig.getInstance().getIconSettingPage();
              }));
            },
          ),
          ListTile(
            title: Text(MyLocalizations.of(context).navigatorSetting),
            leading: Icon(
              Icons.navigation,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                return NavSettingPage();
              }));
            },
          ),
          ListTile(
            title: Text(MyLocalizations.of(context).aboutApp),
            leading: Icon(
              Icons.info_outline,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                return AboutPage();
              }));
            },
          ),
        ],
      ),
    );
  }
}
