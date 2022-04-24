import 'package:flutter/material.dart';
import 'package:test_stream/floatbox/app_float_box.dart';

class FloatStackDemo extends StatefulWidget {
  @override
  _FloatStackDemoState createState() => _FloatStackDemoState();
}

class _FloatStackDemoState extends State<FloatStackDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StackGestureDetector"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // AppFloatBox(),
        ],
      ),
    );
  }
}
