import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';

class FloatingButtonPainter extends CustomPainter {
  FloatingButtonPainter(
      {Key key,
      @required this.isLeft,
      // @required this.isEdge,
      // @required this.isPress,
      @required this.buttonImage});

  //按钮是否在屏幕左侧，屏幕宽度 / 2
  final bool isLeft;

  //按钮是否在屏幕边界，左/右边界
  // final bool isEdge;

  //按钮是否被按下
  // final bool isPress;

  //内按钮图片 ui.image
  final ui.Image buttonImage;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
/*    if (isEdge) {
      if (isLeft)
        paintLeftEdgeButton(canvas, size);
      else
        paintRightEdgeButton(canvas, size);
    } else {
      paintCenterButton(canvas, size);
    }*/

    paintCenterButton(canvas, size);
  }

  //绘制左边界悬浮按钮
  void paintLeftEdgeButton(Canvas canvas, Size size) {
    //绘制按钮内层
    var paint = Paint()
      ..isAntiAlias = false
      ..style = PaintingStyle.fill
      ..color = Color.fromRGBO(0xF3, 0xF3, 0xF3, 0.9);
    //..color = Color.fromRGBO(0xDA,0xDA,0xDA,0.9);

    //path : 按钮内边缘路径
    var path = new Path()..moveTo(size.width / 2, size.height - 1.5);
    path.lineTo(0.0, size.height - 1.5);
    path.lineTo(0.0, 1.5);
    path.lineTo(size.width / 2, 1.5);
    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 23.5);
    path.arcTo(rect, pi * 1.5, pi, true);
    canvas.drawPath(path, paint);

    //edgePath: 按钮外边缘路径,黑色线条
    var edgePath = new Path()..moveTo(size.width / 2, size.height);
    edgePath.lineTo(0.0, size.height);
    edgePath.lineTo(0.0, 0.0);
    edgePath.lineTo(size.width / 2, 0.0);
    Rect rect1 = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 25);
    edgePath.arcTo(rect1, pi * 1.5, pi, true);

    paint
      ..isAntiAlias = true
      ..strokeWidth = 0.75
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 0.25) //线条模糊
      ..style = PaintingStyle.stroke
      ..color = Color.fromRGBO(0xCF, 0xCF, 0xCF, 1);
    canvas.drawPath(edgePath, paint);

    //按下则画阴影，表示选中
/*    if (isPress)
      canvas.drawShadow(
          edgePath, Color.fromRGBO(0xDA, 0xDA, 0xDA, 0.3), 0, false);*/

    //绘制中间图标
    paint = new Paint();
    canvas.save(); //剪裁前保存图层
    RRect imageRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width / 2 - 17.5, size.width / 2 - 17.5, 35, 35),
        Radius.circular(17.5));
    canvas.clipRRect(imageRRect); //图片为圆形，圆形剪裁
    canvas.drawColor(Colors.white, BlendMode.srcOver); //设置填充颜色为白色
    Rect srcRect = Rect.fromLTWH(
        0.0, 0.0, buttonImage.width.toDouble(), buttonImage.height.toDouble());
    Rect dstRect =
        Rect.fromLTWH(size.width / 2 - 17.5, size.height / 2 - 17.5, 35, 35);
    canvas.drawImageRect(buttonImage, srcRect, dstRect, paint);
    canvas.restore(); //图片绘制完毕恢复图层
  }

  //绘制右边界按钮
  void paintRightEdgeButton(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = false
      ..style = PaintingStyle.fill
      ..color = Color.fromRGBO(0xF3, 0xF3, 0xF3, 0.9);

    var path = Path()..moveTo(size.width / 2, 1.5);
    path.lineTo(size.width, 1.5);
    path.lineTo(size.width, size.height - 1.5);
    path.lineTo(size.width / 2, size.height - 1.5);

    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 23.5);
    path.arcTo(rect, pi * 0.5, pi, true);

    canvas.drawPath(path, paint); //绘制

    //edgePath: 按钮外边缘路径
    var edgePath = Path()..moveTo(size.width / 2, 0.0);
    edgePath.lineTo(size.width, 0.0);
    edgePath.lineTo(size.width, size.height);
    edgePath.lineTo(size.width / 2, size.height);
    Rect edgeRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 25);
    edgePath.arcTo(edgeRect, pi * 0.5, pi, true);

    paint
      ..isAntiAlias = true
      ..strokeWidth = 0.75
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 0.25)
      ..style = PaintingStyle.stroke
      ..color = Color.fromRGBO(0xCF, 0xCF, 0xCF, 1);
    canvas.drawPath(edgePath, paint);

    //如果按下则绘制阴影
/*    if (isPress)
      canvas.drawShadow(path, Color.fromRGBO(0xDA, 0xDA, 0xDA, 0.3), 0, false);*/

    //绘制中间图标
    paint = new Paint();
    canvas.save(); //剪裁前保存图层
    // RRect imageRRect = RRect.fromRectAndRadius(
    //     Rect.fromLTWH(size.width / 2 - 17.5, size.width / 2 - 17.5, 35, 35),
    //     Radius.circular(17.5));
    // canvas.clipRRect(imageRRect); //图片为圆形，圆形剪裁
    canvas.drawColor(Colors.white, BlendMode.srcOver); //设置填充颜色为白色
    Rect srcRect = Rect.fromLTWH(
        0.0, 0.0, buttonImage.width.toDouble(), buttonImage.height.toDouble());
    Rect dstRect =
        Rect.fromLTWH(size.width / 2 - 17.5, size.height / 2 - 17.5, 35, 35);
    canvas.drawImageRect(buttonImage, srcRect, dstRect, paint);
    canvas.restore(); //图片绘制完毕恢复图层
  }

  //绘制中心按钮
  void paintCenterButton(Canvas canvas, Size size) {
    //绘制按钮内层
    var paint = new Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      // ..color = Color.fromRGBO(0xF3, 0xF3, 0xF3, 0.9);
      ..color = Colors.red;
    // canvas.drawCircle(Offset(size.width / 2, size.height / 2), 23.5, paint);
    // canvas.drawImage(buttonImage, Offset.zero, paint);
    // canvas.drawRect(Rect.fromLTWH(0, 0, 50, 50), paint);
    canvas.drawImageRect(
        buttonImage,
        Rect.fromLTWH(
            0, 0, buttonImage.width.toDouble(), buttonImage.height.toDouble()),
        Rect.fromLTRB(0, 0, 50, 50),
        paint);

    //绘制按钮外层边线
/*
    paint
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.75
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 0.25)
      ..color = Color.fromRGBO(0xCF, 0xCF, 0xCF, 1);
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 25, paint);
*/

    //如果按下则绘制阴影
/*    if (isPress) {
      var circleRect = Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2), radius: 25);
      var circlePath = new Path()..moveTo(size.width / 2, size.height / 2);
      circlePath.arcTo(circleRect, 0, 2 * 3.14, true);
      canvas.drawShadow(
          circlePath, Color.fromRGBO(0xCF, 0xCF, 0xCF, 0.3), 0.5, false);
    }*/

    //绘制中间图标
/*   var paint = new Paint();
    canvas.save(); //图片剪裁前保存图层
*/ /*    RRect imageRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width / 2 - 17.5, size.width / 2 - 17.5, 35, 35),
        Radius.circular(35));
    canvas.clipRRect(imageRRect); //图片为圆形，圆形剪裁*/ /*
    // canvas.drawColor(Colors.white, BlendMode.srcOver); //设置填充颜色为白色
    Rect srcRect = Rect.fromLTWH(
        0.0, 0.0, buttonImage.width.toDouble(), buttonImage.height.toDouble());
    // Rect dstRect =
    // Rect.fromLTWH(size.width / 2 - 17.5, size.height / 2 - 17.5, 50, 50);

        Rect dstRect =
    Rect.fromLTWH(size.width / 2 - 17.5, size.height / 2 - 17.5, 35, 35);
    canvas.drawImageRect(buttonImage, srcRect, dstRect, paint);
    canvas.restore(); //恢复剪裁前的图层*/

/*// 1-2 段落构造器并添加文本信息
    ParagraphBuilder _pb = ParagraphBuilder(ParagraphStyle(
        fontWeight: FontWeight.normal,
        fontSize: 10,
        maxLines: 1,

        textAlign: TextAlign.center))
      ..pushStyle(
          ui.TextStyle(color: Colors.black, fontWeight: FontWeight.bold))
      ..addText("幸运转盘");
// 3 设置段落容器宽度
    ParagraphConstraints pc = ParagraphConstraints(width: size.width);
// 4 计算文本位置及尺寸
    Paragraph paragraph = _pb.build()..layout(pc);
// 5 文本绘制
    canvas.drawParagraph(paragraph, Offset(0, size.height));*/
  }

  //测试绘制
  void paintTest(Canvas canvas, Size size) {
    var paint = Paint()
      ..isAntiAlias = false
      ..style = PaintingStyle.fill
      ..color = Color.fromRGBO(0xF3, 0xF3, 0xF3, 0.9);

    var path = Path()..moveTo(size.width / 2, 1.5);
    path.lineTo(size.width, 1.5);
    path.lineTo(size.width, size.height - 1.5);
    path.lineTo(size.width / 2, size.height - 1.5);

    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 23.5);
    path.arcTo(rect, pi * 0.5, pi, true);

    canvas.drawPath(path, paint); //绘制

    //edgePath: 按钮外边缘路径
    var edgePath = Path()..moveTo(size.width / 2, 0.0);
    edgePath.lineTo(size.width, 0.0);
    edgePath.lineTo(size.width, size.height);
    edgePath.lineTo(size.width / 2, size.height);
    Rect edgeRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 23.5);
    edgePath.arcTo(edgeRect, pi * 0.5, pi, true);

    paint
      ..isAntiAlias = true
      ..strokeWidth = 0.75
      ..strokeCap = StrokeCap.round
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 0.25)
      ..style = PaintingStyle.stroke
      ..color = Color.fromRGBO(0xCF, 0xCF, 0xCF, 1);
    canvas.drawPath(edgePath, paint);

    //绘制中间图标
    paint = new Paint();
    RRect imageRRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width / 2 - 20, size.width / 2 - 20, 40, 40),
        Radius.circular(20));
    canvas.clipRRect(imageRRect); //图片为圆形，圆形剪裁
    canvas.drawColor(Colors.white, BlendMode.srcOver); //设置填充颜色为白色
    Rect srcRect = Rect.fromLTWH(
        0.0, 0.0, buttonImage.width.toDouble(), buttonImage.height.toDouble());
    Rect dstRect =
        Rect.fromLTWH(size.width / 2 - 17.5, size.height / 2 - 17.5, 35, 35);
    canvas.drawImageRect(buttonImage, srcRect, dstRect, paint);

    //如果按下则绘制阴影
/*    if (isPress)
      canvas.drawShadow(path, Color.fromRGBO(0xDA, 0xDA, 0xDA, 0.3), 0, false);*/
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}
