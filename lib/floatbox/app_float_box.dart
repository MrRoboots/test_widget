import 'package:flutter/material.dart';

/// 应用全局悬浮框
class AppFloatBox extends StatefulWidget {
  const AppFloatBox({Key key}) : super(key: key);

  @override
  _AppFloatBoxState createState() => _AppFloatBoxState();
}

class _AppFloatBoxState extends State<AppFloatBox> {
  Offset offset = Offset.zero;
  bool draggable = false;

  ///滑动中计算
  Offset _calOffset(Size size, Offset offset, Offset nextOffset) {
    double dx = 0;
    if (offset.dx + nextOffset.dx <= 0) {
      dx = 0;
    } else if (offset.dx + nextOffset.dx >= (size.width - 50)) {
      dx = size.width - 50;
    } else {
      dx = offset.dx + nextOffset.dx;
    }

    double dy = 0;
    if (offset.dy + nextOffset.dy >= (size.height - 50)) {
      dy = size.height - 50;
    } else if (offset.dy + nextOffset.dy <=
        kToolbarHeight + MediaQuery.of(context).padding.top) {
      dy = kToolbarHeight + MediaQuery.of(context).padding.top;
    } else {
      dy = offset.dy + nextOffset.dy;
    }

    return Offset(
      dx,
      dy,
    );
  }

  Offset _endOffset(details) {
    double wMind = MediaQuery.of(context).size.width / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        highlightColor: Colors.transparent,
        appBarTheme: AppBarTheme.of(context).copyWith(
          brightness: Brightness.dark,
        ),
      ),
      child: Positioned(
        left: draggable ? offset.dx : MediaQuery.of(context).size.width - 72,
        top: draggable ? offset.dy : MediaQuery.of(context).size.height - 102,
        child: GestureDetector(
          onPanStart: (details) {
            setState(() {
              draggable = true;
            });
          },
          onPanUpdate: (detail) {
            setState(() {
              offset =
                  _calOffset(MediaQuery.of(context).size, offset, detail.delta);
            });
          },
          onPanEnd: (detail) {},
          onTap: () {
            print("点击事件");
          },
          child: Container(
            height: 50,
            width: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
