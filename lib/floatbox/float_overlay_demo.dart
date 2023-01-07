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

  jump() {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: false,
        pageBuilder: (context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                  child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Hero(
                  tag: 'hero',
                  child: FadeTransition(
                    opacity: animation,
                    child: const FlutterLogo(
                      size: 100,
                    ),
                  ),
                ),
              )));
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OverlayEntryDemo"),
      ),
      body: Column(
        children: <Widget>[
          MaterialButton(
            child: const Text("add"),
            onPressed: () {
              entry?.remove();
              entry = null;
              entry = OverlayEntry(builder: (context) {
                var pixelDetails = MediaQuery.of(context).size;
                return FloatingButton(
                  imageProvider: const AssetImage('assets/images/logos.png'),
                  left: pixelDetails.width - 50,
                  top: pixelDetails.height - 80,
                );
              });
              Overlay.of(context).insert(entry);
            },
          ),
          MaterialButton(
            child: const Text("delete"),
            onPressed: () {
              entry?.remove();
              entry = null;
            },
          ),
          /*  MaterialButton(
            child: const Hero(
              tag: 'hero',
              child: FlutterLogo(size: 100),
            ),
            onPressed: () {
              jump();
            },
          ),*/

          GestureDetector(
            onTap: () => jump(),
            child: const Hero(
              tag: 'hero',
              child: FlutterLogo(size: 100),
            ),
          )
        ],
      ),
    );
  }
}
