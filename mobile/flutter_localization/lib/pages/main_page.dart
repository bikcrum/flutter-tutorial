import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n/localization_intl.dart';
import '../model/main_page_model.dart';
import '../pages/language_page.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MainPageModel>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Localization Example",
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.language,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(new CupertinoPageRoute(builder: (ctx) {
                  return LanguagePage();
                }));
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(50, 50, 50, 0),
                child: Container(
                  margin: EdgeInsets.only(top: 8, left: 12),
                  child: Text(
                    "${MyLocalizations.of(context).welcome} Win",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                child: Container(
                  margin: EdgeInsets.only(top: 8, left: 12),
                  child: Text(
                    "${MyLocalizations.of(context).taskItems(model.taskNumbers)}",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FloatingActionButton(
                heroTag: null,
                onPressed: model.logic.subNumber,
                child: Icon(Icons.exposure_neg_1),
              ),
              SizedBox(width: 10.0),
              FloatingActionButton(
                heroTag: null,
                onPressed: model.logic.addNumber,
                child: Icon(Icons.exposure_plus_1),
              )
            ],
          ),
        )
//
        );
  }
}
