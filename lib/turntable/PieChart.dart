//   扇形图
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_stream/turntable/PiesPainter.dart';
import 'package:test_stream/turntable/TestPage.dart';

//  一个用来放乱七八糟的数据的类，方便修改
class ExtraValues {
  final double start_radians = -pi / 2; // 起始点的弧度
  final double inner_circle_radius_percent = 0.6; // 内部圆的半径占比
  final Duration animation_duration = new Duration(milliseconds: 450); // 动画时间
  final double space = 2.0; // 扇形之间的间隔
  final Color space_color = Colors.white; // 间隔的颜色
}

class PieChart extends StatefulWidget {
  final PieDescribe describe; // 扇形图具体信息
  final ExtraValues values = new ExtraValues(); // 乱七八糟的其他相关信息 ---> 为了改的时候好找

  _PieChartState _state;

  PieChart(this.describe);

  @override
  State<StatefulWidget> createState() {
    _state = new _PieChartState(describe, values);
    return _state;
  }

  void changePies(PieDescribe describe) {
    _state.changePies(describe);
  }
}

class _PieChartState extends State<PieChart> with TickerProviderStateMixin {
  final ExtraValues values; // 乱七八糟的其他相关信息
  PieDescribe describe; // 扇形图具体信息

  // 动画相关
  AnimationController _controller;
  CurvedAnimation _animation;

  // 绘制相关
  PiesPainter _painter;

  _PieChartState(this.describe, this.values);

  @override
  void initState() {
    super.initState();
    //  初始化动画Controller与Animation，系统提供了CurvedAnimation,封装了各种不同类型的物理动画
    _controller = new AnimationController(
        vsync: this, duration: values.animation_duration);
    _animation =
        new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    List<double> radians = initValues();
    _painter = new PiesPainter(
        radians, describe.colors, values, _animation, values.start_radians);

    return new SizedBox.expand(
      child: new CustomPaint(painter: _painter),
    );
  }

  //  数值计算 ---> 每个扇形所占的弧度
  List<double> initValues() {
    // 弧度的数组
    List<double> radians = new List<double>();
    // 取传进来的所有的值的和
    num total_value = 0.0;
    describe.values.forEach((num) {
      total_value += num;
    });
    // 计算每个元素的弧度 ---> 然后返回结果
    describe.values.forEach((num) {
      double the_radians = num / total_value * 2 * pi;
      radians.add(the_radians);
    });
    return radians;
  }

  //  改变传入的数据
  void changePies(PieDescribe describe) {
    this.describe = describe;
    List<double> radians = initValues();
    _painter.changeRadians(radians, describe.colors);
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
