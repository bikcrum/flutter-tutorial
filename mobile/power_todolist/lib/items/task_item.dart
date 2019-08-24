import 'package:flutter/material.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:power_todolist/widgets/all_widget.dart';
import 'package:provider/provider.dart';

class TaskItem extends StatelessWidget {
  final int index;
  final TaskPower taskPower;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  TaskItem(this.index, this.taskPower, {this.onDelete, this.onEdit});

  @override
  Widget build(BuildContext context) {
    final globalModel = Provider.of<GlobalModel>(context);

    return Container(
      margin: EdgeInsets.all(10),
      child: Stack(
        children: <Widget>[
          Hero(
            tag: "task_bg${index}",
            child: Container(
              decoration: BoxDecoration(
                color: globalModel.logic.getBgInDark(),
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
          Container(
            child: Card(
              margin: EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Container(
                margin: EdgeInsets.only(left: 16, right: 16),
                child: TaskInfoWidget(
                  index,
                  space: 0,
                  taskPower: taskPower,
                  onDelete: onDelete,
                  onEdit: onEdit,
                  isCardChangeWithBg: globalModel.isCardChangeWithBg,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
