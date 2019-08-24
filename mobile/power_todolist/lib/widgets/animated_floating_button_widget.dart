import 'dart:math';

import 'package:flutter/material.dart';
import 'package:power_todolist/config/floating_border.dart';
import 'package:power_todolist/utils/all_util.dart';
import 'package:power_todolist/widgets/bottom_show_widget.dart';

class AnimatedFloatingButtonWidget extends StatefulWidget {
  final Color bgColor;

  const AnimatedFloatingButtonWidget({Key key, this.bgColor}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AnimatedFloatingButtonWidgetState();
  }
}

class _AnimatedFloatingButtonWidgetState extends State<AnimatedFloatingButtonWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: Duration(microseconds: 500));
    _animation = new Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (ctx, child) {
        return Transform.translate(
          offset: Offset(0, (_animation.value) * 56),
          child: Transform.scale(
            scale: 1 - _animation.value,
            child: child,
          ),
        );
      },
      child: Transform.rotate(
        angle: -pi / 2,
        child: FloatingActionButton(
          onPressed: () async {
            FullScreenDialog.getInstance().showDialog(
                context,
                BottomShowWidget(
                  onExit: () {
                    _controller.reverse();
                  },
                  taskIconPowers: await IconListUtil.getInstance().getIconWithCache(context),
                ));
            _controller.forward();
          },
          child: Transform.rotate(
            angle: pi / 2,
            child: Icon(
              Icons.add,
              size: 25,
              color: Colors.white,
            ),
          ),
          backgroundColor: widget.bgColor ?? Theme.of(context).primaryColor,
          shape: FloatingBorder(),
        ),
      ),
    );
  }
}
