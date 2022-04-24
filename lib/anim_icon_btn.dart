import 'dart:math';

import 'package:flutter/material.dart';

class AnimIconBtn extends StatefulWidget {
  bool isSelect = false;
  final Widget selectIcon;
  final Widget normalIcon;

  AnimIconBtn({Key key, this.isSelect, this.selectIcon, this.normalIcon})
      : super(key: key);

  @override
  _AnimIconBtnState createState() => _AnimIconBtnState();
}

class _AnimIconBtnState extends State<AnimIconBtn>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _iconAnimation;
  Animation _circleAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    _iconAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 1.0, end: 1.3)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.3, end: 1.0), weight: 50),
    ]).animate(_animationController);

    _circleAnimation =
        Tween(begin: 1.0, end: 0.0).animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.yellow,
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // _buildCircle(),
          _buildCirclePoints(),
          _buildIcon(),
        ],
      ),
    );
  }

/*  _buildCircle() {
    return !widget.isSelect
        ? Container()
        : AnimatedBuilder(
            animation: _circleAnimation,
            builder: (BuildContext context, Widget child) {
              return Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: const Color(0xFF5FA0EC)
                            .withOpacity(_circleAnimation.value),
                        width: _circleAnimation.value * 20)),
              );
            },
          );
  }*/

  _buildIcon() {
    return ScaleTransition(
      scale: _iconAnimation,
      child: widget.isSelect
          ? IconButton(
              padding: const EdgeInsets.all(0),
              icon: widget.selectIcon,
              onPressed: () {
                _clickIcon();
              },
            )
          : IconButton(
              padding: const EdgeInsets.all(0),
              icon: widget.normalIcon,
              onPressed: () {
                _clickIcon();
              },
            ),
    );
  }

  _clickIcon() {
    if (_iconAnimation.status == AnimationStatus.forward ||
        _iconAnimation.status == AnimationStatus.reverse ||
        _circleAnimation.status == AnimationStatus.forward ||
        _circleAnimation.status == AnimationStatus.reverse) {
      return;
    }
    setState(() {
      widget.isSelect = !widget.isSelect;
    });
    if (_iconAnimation.status == AnimationStatus.dismissed ||
        _circleAnimation.status == AnimationStatus.dismissed) {
      _animationController.forward();
    } else if (_iconAnimation.status == AnimationStatus.completed ||
        _circleAnimation.status == AnimationStatus.completed) {
      _animationController.reverse();
    }
  }

  _buildCirclePoint(double radius, Color color) {
    return !widget.isSelect
        ? Container()
        : AnimatedBuilder(
            animation: _circleAnimation,
            builder: (BuildContext context, Widget child) {
              return Container(
                width: radius,
                height: radius,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color.withOpacity(_circleAnimation.value)),
              );
            },
          );
  }

  _buildCirclePoints() {
    return Flow(
      delegate: CirclePointFlowDelegate(),
      children: <Widget>[
        _buildCirclePoint(2, const Color(0xFF97B1CE)),
        _buildCirclePoint(5, const Color(0xFF4AC6B7)),
        _buildCirclePoint(2, const Color(0xFF97B1CE)),
        _buildCirclePoint(5, const Color(0xFF4AC6B7)),
        _buildCirclePoint(2, const Color(0xFF97B1CE)),
        _buildCirclePoint(5, const Color(0xFF4AC6B7)),
        _buildCirclePoint(2, const Color(0xFF97B1CE)),
        _buildCirclePoint(5, const Color(0xFF4AC6B7)),
        _buildCirclePoint(2, const Color(0xFF97B1CE)),
        _buildCirclePoint(5, const Color(0xFF4AC6B7)),
        _buildCirclePoint(2, const Color(0xFF97B1CE)),
        _buildCirclePoint(5, const Color(0xFF4AC6B7)),
        _buildCirclePoint(2, const Color(0xFF97B1CE)),
        _buildCirclePoint(5, const Color(0xFF4AC6B7)),
        _buildCirclePoint(2, const Color(0xFF97B1CE)),
        _buildCirclePoint(5, const Color(0xFF4AC6B7)),
      ],
    );
  }
}

class CirclePointFlowDelegate extends FlowDelegate {
  CirclePointFlowDelegate();

  @override
  void paintChildren(FlowPaintingContext context) {
    var radius = min(context.size.width, context.size.height) / 2.0;
    //中心点
    double rx = radius;
    double ry = radius;
    for (int i = 0; i < context.childCount; i++) {
      if (i % 2 == 0) {
        double x =
            rx + (radius - 5) * cos(i * 2 * pi / (context.childCount - 1));
        double y =
            ry + (radius - 5) * sin(i * 2 * pi / (context.childCount - 1));
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
      } else {
        double x = rx +
            (radius - 5) *
                cos((i - 1) * 2 * pi / (context.childCount - 1) +
                    2 * pi / ((context.childCount - 1) * 3));
        double y = ry +
            (radius - 5) *
                sin((i - 1) * 2 * pi / (context.childCount - 1) +
                    2 * pi / ((context.childCount - 1) * 3));
        context.paintChild(i, transform: Matrix4.translationValues(x, y, 0));
      }
    }
  }

  @override
  bool shouldRepaint(FlowDelegate oldDelegate) => true;
}
