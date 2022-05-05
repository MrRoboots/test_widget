import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TestRenderBox());
}

class TestRenderBox extends StatelessWidget {
  const TestRenderBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      home: Scaffold(
        body: Container(
          color: Colors.red,
          child: MyRenderBox(child: FlutterLogo(size: 100)),
        ),
      ),
    );
  }
}

// RenderProxyBox
// DebugOverflowIndicatorMixin  溢出黄线
class MyRenderBox extends SingleChildRenderObjectWidget {
  MyRenderBox({Widget child}) : super(child: child);

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderMyRenderBox();
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderObject renderObject) {
    super.updateRenderObject(context, renderObject);
  }
}

class RenderMyRenderBox extends RenderBox with RenderObjectWithChildMixin {
  @override
  void performLayout() {
    child.layout(BoxConstraints.tight(Size(100, 100)), parentUsesSize: true);
    size = (child as RenderBox).size;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child, offset);

    // context.canvas.drawArc(rect, startAngle, sweepAngle, useCenter, paint)
    // context.canvas.drawArc(
    //     Rect.fromLTWH(offset.dx, offset.dy, 50, 50), 0, 0, true, Paint());

    context.pushOpacity(offset, 125, (context, offset) {
      context.paintChild(child, offset + Offset(4, 4));
    });
  }
}
