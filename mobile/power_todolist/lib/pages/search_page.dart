import 'package:flutter/material.dart';
import 'package:power_todolist/config/global.dart';
import 'package:power_todolist/items/task_item.dart';
import 'package:power_todolist/l10n/localization_intl.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/widgets/all_widget.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);
    final model = Provider.of<SearchPageModel>(context)..setContext(context);
    final primaryColor = globalModel.logic.getPrimaryInDark(context);
    final bgColor = globalModel.logic.getWhiteInDark();

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(
          color: bgColor,
        ),
        title: TextField(
          style: TextStyle(
            color: bgColor,
          ),
          textInputAction: TextInputAction.search,
          autofocus: true,
          controller: model.textEditingController,
          onEditingComplete: model.logic.onEditingComplete,
          decoration: new InputDecoration(
            hintText: MyLocalizations.of(context).tryToSearch,
            hintStyle: new TextStyle(color: bgColor),
            suffixIcon: IconButton(
              icon: Icon(
                Icons.clear,
                color: bgColor,
              ),
              onPressed: () => Future.delayed(Duration(milliseconds: 100), () {
                model.textEditingController?.clear();
              }),
            ),
            border: InputBorder.none,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: bgColor, width: 1),
            ),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 50, right: 50),
        child: model.loadingFlag != LoadingFlag.success
            ? Center(
                child: SingleChildScrollView(
                  child: LoadingWidget(
                    flag: model.loadingFlag,
                    progressColor: bgColor,
                    textColor: globalModel.logic.getWhiteInDark(),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Wrap(
                  children: List.generate(
                    model.searchTasks.length,
                    (index) {
                      final task = model.searchTasks[index];
                      return GestureDetector(
                        onTap: () => model.logic.onTaskTap(index, task),
                        child: TaskItem(
                          task.id,
                          task,
                          onDelete: () => model.logic.onDelete(globalModel, task),
                          onEdit: () => model.logic.onEdit(task, globalModel.mainPageModel),
                        ),
                      );
                    },
                  ),
                ),
              ),
      ),
    );
  }
}
