import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/config/provider_config.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/pages/all_page.dart';
import 'package:power_todolist/widgets/all_widget.dart';
import 'package:provider/provider.dart';

class NavPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    return ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[
        getNavHeader(globalModel, context),
        ListTile(
          title: Text(MyLocalizations.of(context).doneList),
          leading: Icon(Icons.done_all),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new CupertinoPageRoute(builder: (ctx) {
              return ProviderConfig.getInstance().getDoneTaskPage();
            }));
          },
        ),
        ListTile(
          title: Text(MyLocalizations.of(context).languageTitle),
          leading: Icon(Icons.language),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new CupertinoPageRoute(builder: (ctx) {
              return LanguagePage();
            }));
          },
        ),
        ListTile(
          title: Text(MyLocalizations.of(context).changeTheme),
          leading: Icon(Icons.color_lens),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new CupertinoPageRoute(builder: (ctx) {
              return ProviderConfig.getInstance().getThemePage();
            }));
          },
        ),
        ListTile(
          title: Text(MyLocalizations.of(context).appSetting),
          leading: Icon(Icons.settings),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, new CupertinoPageRoute(builder: (ctx) {
              return SettingPage();
            }));
          },
        ),
      ],
    );
  }

  Widget getNavHeader(GlobalModel model, BuildContext context) {
    final size = MediaQuery.of(context).size;
    final netImageHeight = max(size.width, size.height) / 4;

    if (model.currentNavHeader == NavHeadType.meteorShower) {
      return NavHeadWidget();
    } else {
      final url = model.currentNetPicUrl;
      bool isDailyPic = model.currentNavHeader == NavHeadType.dailyPic;

      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
            return ImagePage(
              imageUrls: [
                isDailyPic ? NavHeadType.DAILY_PIC_URL : url
              ],
            );
          }));
        },
        child: Hero(
            tag: "tag_0",
            child: Container(
              height: netImageHeight,
              child: isDailyPic
                  ? Image.network(
                      NavHeadType.DAILY_PIC_URL,
                      fit: BoxFit.cover,
                    )
                  : CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: url,
                      placeholder: (context, url) => new Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        ),
                      ),
                      errorWidget: (context, url, error) => new Icon(Icons.error),
                    ),
            )),
      );
    }
  }
}
