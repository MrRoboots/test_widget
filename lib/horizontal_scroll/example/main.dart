import 'package:flutter/material.dart';
import 'package:test_stream/horizontal_scroll/example/HorizontalScrollText.dart';

import 'HorizontalScrollDefault.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // home: HorizontalScrollText(),
      home: HorizontalScrollDefault(),
      // home: HorizontalScrollCustom(),
    );
  }
}