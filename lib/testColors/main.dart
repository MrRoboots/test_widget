import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TestColors(),
    );
  }
}

class TestColors extends StatelessWidget {
  const TestColors({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            transform: GradientRotation(45 * math.pi / 180),
            colors: <Color>[
              Color(0xFF4285F4), // blue
              Color(0xFF34A853), // green
              Color(0xFFFBBC05), // yellow
              Color(0xFFEA4335), // red
            ],
            stops: [
              0.0,
              0.25,
              0.5,
              0.75
            ]),
      ),
    );
  }
}
