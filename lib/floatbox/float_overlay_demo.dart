import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_stream/floatbox/app_float_box.dart';
import 'package:test_stream/wxFloatBox/FloatingButton.dart';

class FloatOverLayDemo extends StatefulWidget {
  @override
  _FloatOverLayDemoState createState() => _FloatOverLayDemoState();
}

class _FloatOverLayDemoState extends State<FloatOverLayDemo> {
  static OverlayEntry entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("OverlayEntryDemo"),
      ),
      body: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("add"),
            onPressed: () {
              entry?.remove();
              entry = null;
              entry = OverlayEntry(builder: (context) {
                // return AppFloatBox();
                var pixelDetails = MediaQuery.of(context).size;
                return FloatingButton(
                  imageProvider: AssetImage('assets/images/logo.png'),
                  left: pixelDetails.width - 50,
                  top: pixelDetails.height - 80,
                );
              });
              Overlay.of(context).insert(entry);
            },
          ),
          RaisedButton(
            child: Text("delete"),
            onPressed: () {
              entry?.remove();
              entry = null;
            },
          ),
        ],
      ),
    );
  }
}
