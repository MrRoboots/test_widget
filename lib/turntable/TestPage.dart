import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_stream/turntable/PieChart.dart';

// 图表的属性描述类
class PieDescribe {
  final List<num> values; // 数值
  final List<Color> colors; // 颜色
  PieDescribe({@required this.values, @required this.colors});
}

class TestPage extends StatelessWidget {
  final List<PieDescribe> pies = [
    new PieDescribe(
        values: [200, 200, 200, 200],
        colors: [Colors.red, Colors.blue, Colors.yellow, Colors.green]),
  ];
  int _currentNum = 0;

  @override
  Widget build(BuildContext context) {
    PieChart pieChart = new PieChart(pies[_currentNum]);
    return new Material(
      color: Colors.grey,
      child: new Center(
        child: new InkWell(
          child: new SizedBox(
            width: 300.0,
            height: 300.0,
            child: pieChart,
          ),
          onTap: () {
            if (_currentNum < 2) {
              _currentNum++;
            } else {
              _currentNum = 0;
            }
            pieChart.changePies(pies[_currentNum]);
          },
        ),
      ),
    );
  }
}
