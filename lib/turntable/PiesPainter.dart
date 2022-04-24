import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:test_stream/turntable/PieChart.dart';

class PiesPainter extends CustomPainter {
  final ExtraValues values;
  final CurvedAnimation animation;

  final double start_radians;

  Paint painter = new Paint();

  final List<Offset> end_points = new List<Offset>();

  List<double> last_radians = new List<double>(); //上一次的扇形弧度数组
  List<double> radians; //当前的扇形弧度数组
  List<Color> colors; //当前的扇形颜色

  int _num; // 所包含扇形的数量

  PiesPainter(this.radians, this.colors, this.values, this.animation,
      this.start_radians)
      : super(repaint: animation) {
    _num = radians.length;

    painter.style = PaintingStyle.fill;
    painter.strokeWidth = values.space;
    painter.isAntiAlias = true;
    // painter.shader = ui.Gradient.radial(
    //     Offset(300 / 2, 300 / 2), 300, [Colors.white,Colors.black]);

    for (int i = 0; i < _num; i++) {
      last_radians.add(0.0);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    //剪切画布
    Rect rect = Offset.zero & size;
    canvas.clipRect(rect);

    Offset center = Offset(size.width / 2, size.width / 2); // 扇形图的中心点
    double outer_radius = size.width / 2; // 外部圆半径
    double inner_radius =
        outer_radius * values.inner_circle_radius_percent; // 内部圆半径

    double pie_start_radians = start_radians;
    double lines_radians = 0.0;
    for (int i = 0; i < _num; i++) {
      // 当前每个扇形弧度的计算，需要根据之前传入的Animation所返回的值来计算
      double current_radians =
          last_radians[i] + (radians[i] - last_radians[i]) * animation.value;

      // 外部圆 ---> 请自备三角函数 ---> 或者略过不看
      // painter.color = colors[i];
      painter.color = Colors.transparent;

      Rect outer_rect = Rect.fromCircle(center: center, radius: outer_radius);

      var paint = Paint()
        ..isAntiAlias = true
        ..shader = ui.Gradient.radial(Offset(300 / 2, 300 / 2), 300, [
          Color(0xFFE6B156),
          Color(0xFF6B4E2B),
        ]);
      canvas.drawArc(
          outer_rect, pie_start_radians, current_radians, true, paint);

      canvas.drawArc(
          outer_rect, pie_start_radians, current_radians, true, painter);

      pie_start_radians = pie_start_radians + current_radians;
      lines_radians = lines_radians + current_radians;

      double end_x = outer_radius + outer_radius * sin(lines_radians);
      double end_y = outer_radius - outer_radius * cos(lines_radians);
      end_points.add(Offset(end_x, end_y));
    }

    // 内部圆 ---> 请自备三角函数 ---> 或者略过不看
    painter.color = values.space_color;
    // Rect inner_rect = Rect.fromCircle(center: center, radius: inner_radius);
    // canvas.drawArc(inner_rect, 0.0, 2 * pi, true, painter);

    // 最后绘制相邻扇形中间的间隔线
    // canvas.drawLine(center, end_points[0], painter);
    end_points.forEach((end_point) {
      canvas.drawLine(center, end_point, painter);
    });
    end_points.clear();
  }

  //  更改属性 ---> 重绘时记录上一次的弧度值
  void changeRadians(List<double> new_radians, List<Color> colors) {
    // 老数组赋值
    last_radians = radians;
    // 新数组赋值
    radians = new_radians;
    // 确定绘制的循环次数 ---> 因为新数组可能大于老数组，所以只能取较大的值
    _num = radians.length > last_radians.length
        ? radians.length
        : last_radians.length;
    for (int i = 0; i < _num; i++) {
      // 如果新数组较大，就需要为老数组增加多余的值，0.0
      if (last_radians.length <= i) {
        last_radians.add(0.0);
      }
      // 如果老数组较大，就需要为新数组增加多余的值，0.0，并且颜色需要对应添加进来
      if (radians.length <= i) {
        radians.add(0.0);
        colors.add(this.colors[i]);
      }
    }
    // 最后设置颜色
    this.colors = colors;
  }

  @override
  bool shouldRepaint(PiesPainter old) => true;
}
