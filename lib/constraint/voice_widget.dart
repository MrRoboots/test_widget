import 'package:flutter/material.dart';
import 'dart:math' as math;

class VoiceWidget extends StatefulWidget {
  final Size size;
  final ValueChanged<AnimationController> animationController;
  final int index;

  const VoiceWidget(
      {Key key,
      @required this.size,
      @required this.animationController,
      this.index})
      : super(key: key);

  @override
  State<VoiceWidget> createState() => _VoiceWidgetState();
}

class _VoiceWidgetState extends State<VoiceWidget>
    with SingleTickerProviderStateMixin {
  Size get size => widget.size;
  int index = 0;
  AnimationController _animation;
  Animation<int> _intTween;

  @override
  void initState() {
    super.initState();
    index = widget.index;
    _animation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500));
    _intTween = IntTween(begin: 1, end: 3).animate(_animation);
    _intTween.addListener(() {
      setState(() {
        index = _intTween.value;
      });
    });
    widget.animationController(_animation);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: CustomPaint(
        painter: _VoiceWidget(index),
      ),
    );
  }
}

class _VoiceWidget extends CustomPainter {
  bool left = false;
  double startAngle = 0;
  Offset center;
  int showIndex = 3;

  Paint mPaint = Paint()
    ..color = Colors.red
    ..isAntiAlias = true
    ..style = PaintingStyle.stroke;

  _VoiceWidget(this.showIndex);

  @override
  void paint(Canvas canvas, Size size) {
    var radius = size.width / 2;
    var sweepAngle = math.pi / 2;
    mPaint.strokeWidth = radius / 6;
    mPaint.strokeCap = StrokeCap.round;

    if (left) {
      center = Offset(size.width, size.height / 2);
      startAngle = math.pi * 3 / 4;
    } else {
      startAngle = math.pi * 7 / 4;
      center = Offset(0, size.height / 2);
    }
    if (showIndex >= 3) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
          startAngle, sweepAngle, false, mPaint);
    }
    if (showIndex >= 2) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius * 2 / 3),
          startAngle, sweepAngle, false, mPaint);
    }
    if (showIndex >= 1) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius / 3),
          startAngle, sweepAngle, true, mPaint..style = PaintingStyle.fill);

      ///重置属性
      mPaint.style = PaintingStyle.stroke;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
