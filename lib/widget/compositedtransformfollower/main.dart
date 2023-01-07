import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_stream/widget/flutter_star/custom_rating.dart';
import 'package:test_stream/widget/flutter_star/star.dart';
import 'package:test_stream/widget/flutter_star/star_score.dart';
import 'package:test_stream/widget/wrapper/wrapper.dart';

import 'tip_box.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key key}) : super(key: key);
  final LayerLink _layerLink = LayerLink();
  final LayerLink _layerLinkHeader = LayerLink();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTransform(),
            buildCustomRating(),
            buildStarScore(),
            buildStack(),
            buildHeaderContainer(),
          ],
        ),
      ),
    );
  }

  Widget buildHeaderContainer() {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 25),
          color: Colors.red,
          width: double.maxFinite,
          height: 100,
        ),
        ClipOval(child: Container(color: Colors.black, child: const FlutterLogo(size: 50))),
      ],
    );
  }

  Stack buildStack() {
    return Stack(
      children: [
        CompositedTransformTarget(
          link: _layerLink,
          child: const FlutterLogo(size: 50),
        ),
        CompositedTransformFollower(
          link: _layerLink,
          followerAnchor: Alignment.topLeft,
          targetAnchor: Alignment.topRight,
          offset: const Offset(0, 0),
          child: Material(
            child: SizedBox(
              width: 150,
              child: Wrapper(
                color: const Color(0xff95EC69),
                spineType: SpineType.left,
                elevation: 1,
                offset: 20,
                shadowColor: Colors.grey.withAlpha(88),
                child: Text("张风捷特烈 " * 5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  StarScore buildStarScore() {
    return StarScore(
      score: 4.8,
      star: Star(fillColor: Colors.tealAccent, emptyColor: Colors.grey.withAlpha(88)),
      tail: Column(
        children: const <Widget>[
          Text("综合评分"),
          Text("4.8"),
        ],
      ),
    );
  }

  CustomRating buildCustomRating() {
    return CustomRating(
      score: 3,
      star: Star(fillColor: Colors.tealAccent, emptyColor: Colors.grey.withAlpha(88)),
      max: 5,
      onRating: (double index) {},
    );
  }

  Transform buildTransform() {
    return Transform(
      // transform: Matrix4.rotationZ(-15 / 180 * pi),//旋转
      transform: Matrix4.skewX(15 / 180 * pi), //斜切
      // transform: Matrix4.diagonal3Values(0.5,0.5,1),//缩放
      // transform: Matrix4.translationValues(150, 0, 0), //平移
      alignment: Alignment.center,
      child: const TipBox(),
    );
  }
}
