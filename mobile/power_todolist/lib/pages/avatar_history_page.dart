import 'dart:io';

import 'package:flutter/material.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/config/keys.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/utils/all_util.dart';

class AvatarHistoryPage extends StatefulWidget {
  final String currentAvatarUrl;
  final AvatarPageModel avatarPageModel;

  const AvatarHistoryPage({Key key, @required this.currentAvatarUrl, this.avatarPageModel}) : super(key: key);

  @override
  _AvatarHistoryPageState createState() => _AvatarHistoryPageState();
}

class _AvatarHistoryPageState extends State<AvatarHistoryPage> {
  List<String> avatarPaths = [];
  bool isDeleting = false;

  @override
  void initState() {
    super.initState();
    getAvatarFiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyLocalizations.of(context).avatarHistory),
        actions: <Widget>[
          IconButton(
              icon: isDeleting ? Icon(Icons.check) : Icon(Icons.border_color),
              onPressed: () {
                isDeleting = !isDeleting;
                setState(() {});
              }),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1.0,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          padding: EdgeInsets.all(10),
          children: List.generate(avatarPaths.length, (index) {
            final url = avatarPaths[index];
            final name = url.split("/").last;

            return Stack(
              children: <Widget>[
                InkWell(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Image.file(
                      File(avatarPaths[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () async {
                    final avatarPageModel = widget.avatarPageModel;
                    final mainPageModel = avatarPageModel.mainPageModel;
                    mainPageModel.currentAvatarUrl = url;
                    mainPageModel.currentAvatarType = CurrentAvatarType.local;
                    await SharedUtil.instance.saveString(Keys.localAvatarPath, url);
                    await SharedUtil.instance.saveInt(Keys.currentAvatarType, CurrentAvatarType.local);
                    mainPageModel.refresh();
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
                isDeleting
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        child: Container(
                          color: Colors.grey.withOpacity(0.5),
                        ))
                    : SizedBox(),
                isDeleting && name != "icon.png"
                    ? Container(
                        alignment: Alignment.center,
                        child: IconButton(
                          padding: EdgeInsets.all(0),
                          iconSize: 80,
                          icon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            File file = File(avatarPaths[index]);
                            file.delete().then((value) {
                              getAvatarFiles();
                            });
                          },
                        ),
                      )
                    : SizedBox(),
              ],
            );
          }),
        ),
      ),
    );
  }

  void getAvatarFiles() async {
    final avatarPath = await FileUtil.getInstance().getSavePath('/avatar/');
    final children = await FileUtil.getInstance().getDirChildren(avatarPath);
    avatarPaths.clear();
    avatarPaths.addAll(children);
    avatarPaths.remove(widget.currentAvatarUrl);
    if (mounted) {
      setState(() {});
    }
  }
}
