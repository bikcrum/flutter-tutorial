import 'dart:math';

import 'package:circle_list/circle_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:power_todolist/config/provider_config.dart';
import 'package:power_todolist/json/all_power.dart';
import 'package:power_todolist/model/all_model.dart';
import 'package:provider/provider.dart';

class BottomShowWidget extends StatefulWidget {
  final VoidCallback onExit;
  final List<TaskIconPower> taskIconPowers;

  BottomShowWidget({this.onExit, this.taskIconPowers});

  @override
  _BottomShowWidgetState createState() => _BottomShowWidgetState();
}

class _BottomShowWidgetState extends State<BottomShowWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  List<TaskIconPower> _children = [];

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = new Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine));
    _controller.forward();
    _children.clear();
    _children.addAll(widget.taskIconPowers);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    debugPrint("BottomShowWidget disposed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final maxSize = max(size.height, size.width);
    final minSize = min(size.height, size.width);
    final circleSize = minSize;
    final Offset circleOrigin = Offset((size.width - circleSize) / 2, 0);
    final globalModel = Provider.of<GlobalModel>(context);

    return WillPopScope(
      onWillPop: () {
        doExit(context, _controller);
      },
      child: GestureDetector(
        onTap: () {
          doExit(context, _controller);
        },
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(0),
          body: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 20,
                  left: size.width / 2 - 28,
                  child: AnimatedBuilder(
                      animation: _animation,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(color: Theme.of(context).primaryColorDark.withOpacity(0.2), shape: BoxShape.circle),
                      ),
                      builder: (ctx, child) {
                        return Transform.scale(
                          scale: (max(size.height, size.width) / 28) * (_animation.value),
                          child: child,
                        );
                      }),
                ),
                Positioned(
                  left: circleOrigin.dx,
                  top: circleOrigin.dy,
                  child: AnimatedBuilder(
                    animation: _animation,
                    child: CircleList(
                      initialAngle: pi / 2,
                      origin: Offset(0, -min(size.height, size.width) / 2 + 20),
                      showInitialAnimation: true,
                      children: List.generate(_children.length, (index) {
                        return IconButton(
                          onPressed: () {
                            debugPrint("click：${_children[index].taskName}");
                            doExit(context, _controller);
                            Navigator.of(context).push(
                              new CupertinoPageRoute(
                                builder: (ctx) {
                                  return ProviderConfig.getInstance().getEditTaskPage(
                                    _children[index],
                                  );
                                },
                              ),
                            );
                          },
                          tooltip: _children[index].taskName,
                          icon: Icon(
                            IconPower.toIconData(_children[index].iconPower),
                            size: 40,
                            color: ColorPower.toColor(_children[index].colorPower),
                          ),
                        );
                      }),
                      innerCircleColor: Theme.of(context).primaryColorLight,
                      outerCircleColor: globalModel.logic.getBgInDark(),
                      centerWidget: GestureDetector(
                          onTap: () {
                            doExit(context, _controller);
                            debugPrint("click");
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: MediaQuery.of(context).size.width / 3,
                            decoration: BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              color: Colors.transparent,
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          )),
                    ),
                    builder: (ctx, child) {
                      return Transform.translate(
                        offset: Offset(0, MediaQuery.of(context).size.height - (_animation.value) * circleSize),
                        child: Transform.scale(scale: _animation.value, child: child),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void doExit(BuildContext context, AnimationController controller) {
    widget?.onExit();
    controller.reverse().then((r) {
      Navigator.of(context).pop();
    });
  }
}
