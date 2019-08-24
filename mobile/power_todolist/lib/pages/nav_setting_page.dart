import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/pages/all_page.dart';
import 'package:power_todolist/utils/shared_util.dart';
import 'package:power_todolist/widgets/nav_head_widget.dart';
import 'package:provider/provider.dart';

class NavSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).navigatorSetting),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            RadioListTile(
              value: NavHeadType.meteorShower,
              groupValue: globalModel.currentNavHeader,
              subtitle: NavHeadWidget(),
              onChanged: (value) => onChanged(globalModel, value),
              title: Text(MyLocalizations.of(context).meteorShower),
            ),
            RadioListTile(
              value: NavHeadType.dailyPic,
              groupValue: globalModel.currentNavHeader,
              subtitle: Image.network(NavHeadType.DAILY_PIC_URL),
              onChanged: (value) => onChanged(globalModel, value),
              title: Text(MyLocalizations.of(context).dailyPic),
            ),
            RadioListTile(
                value: NavHeadType.netPicture,
                groupValue: globalModel.currentNavHeader,
                onChanged: (value) => onChanged(globalModel, value, context: context),
                title: Text(MyLocalizations.of(context).netPicture),
                subtitle: globalModel.currentNetPicUrl == ""
                    ? null
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                            return PhotoPage(
                              selectValue: NavHeadType.netPicture,
                            );
                          }));
                        },
                        child: CachedNetworkImage(
                          imageUrl: globalModel.currentNetPicUrl,
                          placeholder: (context, url) => new Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                            ),
                          ),
                          errorWidget: (context, url, error) => new Icon(
                            Icons.error,
                            color: Colors.redAccent,
                          ),
                        ),
                      )),
          ],
        ),
      ),
    );
  }

  Future onChanged(GlobalModel globalModel, value, {BuildContext context}) async {
    if (context != null && globalModel.currentNetPicUrl == "") {
      Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
        return PhotoPage(
          selectValue: value,
        );
      }));
      return;
    }

    if (globalModel.currentNavHeader != value) {
      globalModel.currentNavHeader = value;
      globalModel.refresh();
      await SharedUtil.instance.saveString(Keys.currentNavHeader, value);
    }
  }
}
