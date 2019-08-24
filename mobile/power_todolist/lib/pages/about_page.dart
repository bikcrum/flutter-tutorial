import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:provider/provider.dart';

import 'all_page.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  List<String> descriptions = [];

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    if (descriptions.isEmpty) {
      descriptions.add(MyLocalizations.of(context).version103);
      descriptions.add(MyLocalizations.of(context).version102);
      descriptions.add(MyLocalizations.of(context).version101);
      descriptions.add(MyLocalizations.of(context).version100);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          MyLocalizations.of(context).aboutApp,
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        backgroundColor: globalModel.logic.getBgInDark(),
        iconTheme: IconThemeData(color: Colors.grey),
        elevation: 0.0,
      ),
      body: Container(
        color: globalModel.logic.getBgInDark(),
        child: Container(
          margin: EdgeInsets.all(20),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overScroll) {
              overScroll.disallowGlow();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: Container(
                              width: 70,
                              height: 70,
                              margin: EdgeInsets.all(10),
                              child: Image.asset(
                                "images/icon_2.png",
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50, top: 2),
                      height: 90,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Text(
                                MyLocalizations.of(context).appName,
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              child: FutureBuilder(
                                  future: PackageInfo.fromPlatform(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      PackageInfo packageInfo = snapshot.data;
                                      return Text(
                                        packageInfo.version,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Theme.of(context)
                                                        .primaryColor ==
                                                    Color(0xff212121)
                                                ? Colors.white
                                                : Color.fromRGBO(
                                                    141, 141, 141, 1.0)),
                                      );
                                    } else
                                      return Container();
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Platform.isAndroid
                        ? Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.cloud_upload,
                              ),
                              onPressed: () => checkUpdate(globalModel),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 20, bottom: 0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Container(
                        margin: EdgeInsets.only(left: 20, top: 30, right: 20),
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification: (overScroll) {
                            overScroll.disallowGlow();
                          },
                          child: ListView(
                              children: List.generate(descriptions.length + 1,
                                  (index) {
                            if (index == 0) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      MyLocalizations.of(context)
                                          .versionDescription,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    InkWell(
                                      child: Text(
                                        "✨${MyLocalizations.of(context).projectLink}✨",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(
                                            new CupertinoPageRoute(
                                                builder: (ctx) {
                                          return WebViewPage(
                                            "https://github.com/devexps/flutter-tutorial-for-beginners",
                                            title: MyLocalizations.of(context)
                                                .myGithub,
                                          );
                                        }));
                                      },
                                    )
                                  ],
                                ),
                              );
                            } else {
                              final data = descriptions[index - 1];

                              return Container(
                                margin: EdgeInsets.only(right: 14),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(top: 7),
                                      width: 7,
                                      height: 7,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromRGBO(141, 141, 141, 1.0),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(child: Text(data)),
                                  ],
                                ),
                              );
                            }
                          })),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkUpdate(GlobalModel globalModel) {
    //TODO implement logic here
  }
}
