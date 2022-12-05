import 'package:flutter/material.dart';
import 'package:test_stream/anim/icon/anim_icon_btn.dart';
import 'package:test_stream/constraint/voice_widget.dart';

void main() {
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ConstrainedPage(),
    );
  }
}

class ConstrainedPage extends StatefulWidget {
  const ConstrainedPage({Key key}) : super(key: key);

  @override
  State<ConstrainedPage> createState() => _ConstrainedPageState();
}

class _ConstrainedPageState extends State<ConstrainedPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  int index = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: _testUnconstrainedBox(),
      // body: _testOverflowBox(),
      body: SafeArea(
          // child: _testOverflowBoxExample(),
          // child: _testSizeOverflowBox(),
          // child: _testSizeOverflowBox2(),
          // child: _testStackWidget(),
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          VoiceWidget(
            index: index,
            size: const Size(40, 40),
            animationController: (anim) {
              _animationController = anim;
            },
          ),
          ElevatedButton(
              onPressed: () {
                _animationController.repeat();
              },
              child: const Text('开始')),
          ElevatedButton(
              onPressed: () {
                _animationController.forward();
              },
              child: const Text('停止')),
        ],
      )),
    );
  }

  ///将溢出的内容显示出来
  Widget _testOverflowBox() {
    return Column(
      children: [
        const FlutterLogo(size: 100),
        Container(
          width: 100,
          height: 100,
          color: Colors.red,
          child: const OverflowBox(
            alignment: Alignment.centerRight,
            maxHeight: 200,
            maxWidth: 200,
            child: FlutterLogo(size: 200),
          ),
        ),
        const FlutterLogo(size: 100)
      ],
    );
  }

  ///打破父级约束并溢出
  Widget _testUnconstrainedBox() {
    return Container(
      width: 200,
      height: 200,
      color: Colors.amber,
      child: UnconstrainedBox(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.red,
        ),
      ),
    );
  }

  ///动画约束展示OverflowBox
  _testOverflowBoxExample() {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      curve: Curves.bounceOut,
      height: 100,
      color: Colors.grey[200],
      child: ClipRect(
        child: OverflowBox(
          alignment: Alignment.topCenter,
          maxHeight: 100,
          child: Column(
            children: const [
              Text('Line1'),
              Text('Line1'),
              Text('Line1'),
            ],
          ),
        ),
      ),
    );
  }

  ///SizedOverflowBox 打破的是子级的约束
  ///OverflowBox 是打破父级的约束
  _testSizeOverflowBox() {
    return Column(
      children: [
        const SizedBox(height: 100),
        Container(
          width: 200,
          height: 200,
          color: Colors.red,
          alignment: Alignment.topCenter,
          child: SizedOverflowBox(
            size: const Size(50, 50),
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.black87,
            ),
          ),
        ),
        /*  Container(
            color: Colors.red,
            width: double.maxFinite,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: MediaQuery.of(context).size.width / 2,
                height: 200,
                color: Colors.yellow,
              ),
            ))*/
      ],
    );
  }

  _testSizeOverflowBox2() {
    return Column(
      children: [
        const SizedBox(height: 100),
        Container(
          width: double.maxFinite,
          height: 200,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logos'
                  '.png'),
              fit: BoxFit.cover,
            ),
            // color: Colors.red,
          ),
          child: SizedOverflowBox(
            size: const Size(20, 20),
            alignment: Alignment.topCenter,
            child: Container(
              width: double.maxFinite,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              height: 100,
              color: Colors.black87,
              child: const Text(
                'hhhhhh',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 80),
        Container(
          height: 100,
          width: double.maxFinite,
          color: Colors.red,
        ),
      ],
    );
  }

  _testStackWidget() {
    return Stack(
      children: [
        Container(width: double.maxFinite, height: 200, color: Colors.black87),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.red,
            width: double.maxFinite,
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 20),
          ),
        )
      ],
    );
  }
}
