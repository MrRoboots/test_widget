///
///  local key 局部key
///  UniqueKey 只和自己相等的
//   ValueKey  比较值
//   ObjectKey 比较对象 内存中的指针是否指向同一个地址

// GlobalKey globalKey = GlobalKey();

///global key 全局key
///1.global key 可以获取state 中的值
///    globalKey.currentState as MyPaintWidgetState;
//     globalKey.currentState.setState(() {});
//2.global key 可以获取widget 的值
//     globalKey.currentWidget as MyPaintWidget;
//3.获取布局的大小 位置等
//     var currentContext =
//         globalKey.currentContext.findRenderObject() as RenderBox;
//     currentContext.size; //获取当前组件的大小
//     currentContext.paintBounds; //获取当前组件的绘制区域
//     currentContext.localToGlobal(Offset.zero);

import 'dart:math';

import 'package:flutter/material.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Color> _colors = [];
  var _color = Colors.blue;
  int _slot;
  final GlobalKey _appBarKey = GlobalKey();
  double _offset;

  @override
  initState() {
    _shuffle();
    super.initState();
  }

  _shuffle() {
    _color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    _colors = List.generate(8, (index) => _color[(index + 1) * 100]);
    setState(() => _colors.shuffle());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: _shuffle,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Listener(
        onPointerMove: (event) {
          final y = event.position.dy - _offset;

          if (y > (_slot + 1) * Box.height) {
            if (_slot == _colors.length - 1) return;
            setState(() {
              final c = _colors[_slot];
              _colors[_slot] = _colors[_slot + 1];
              _colors[_slot + 1] = c;
              _slot++;
            });
          } else if (y < _slot * Box.height) {
            if (_slot == 0) return;
            setState(() {
              final c = _colors[_slot];
              _colors[_slot] = _colors[_slot - 1];
              _colors[_slot - 1] = c;
              _slot--;
            });
          }
        },
        child: Center(
          child: SizedBox(
            width: Box.width,
            child: Column(
              children: [
                Container(
                    height: Box.height,
                    alignment: Alignment.center,
                    child: const Text(
                      'Start Game',
                      style: TextStyle(fontSize: 30),
                    )),
                Container(
                  width: Box.width - Box.margin * 2,
                  height: Box.height - Box.margin * 2,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Icon(Icons.lock, color: Colors.white),
                ),
                const SizedBox(height: Box.margin * 2),
                Expanded(
                  child: Stack(
                    key: _appBarKey,
                    children: List.generate(_colors.length, (i) {
                      return Box(
                        color: _colors[i],
                        x: 0,
                        y: i * Box.height,
                        onDrag: (Color color) {
                          final index = _colors.indexOf(color);
                          // _offset =
                          final renderBox = (_appBarKey.currentContext
                              .findRenderObject() as RenderBox);
                          // _offset = renderBox.size.height;
                          _offset = renderBox.localToGlobal(Offset.zero).dy;
                          print("on localToGlobal $_offset");
                          print("on drag $index");
                          _slot = index;
                        },
                        onEnd: _checkWinCondition,
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///检查改变
  _checkWinCondition() {
    List<double> list = _colors.map((e) => e.computeLuminance()).toList();
    print(list.toString());
    bool success = true;
    for (int i = 0; i < list.length - 1; i++) {
      if (list[i] > list[i + 1]) {
        success = false;
        break;
      }
    }
    print(success ? "success" : "fail");
  }
}

class Box extends StatelessWidget {
  static const width = 250.0;
  static const height = 50.0;
  static const margin = 2.0;

  final Color color;
  final double x, y;
  final Function(Color) onDrag;
  final Function() onEnd;

  Box({
    @required this.color,
    @required this.x,
    @required this.y,
    @required this.onDrag,
    @required this.onEnd,
  }) : super(key: ValueKey(color));

  @override
  Widget build(BuildContext context) {
    final container = Container(
      width: width - margin * 2,
      height: height - margin * 2,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    return AnimatedPositioned(
      duration: Duration(milliseconds: 100),
      left: x,
      top: y,
      child: Draggable(
        onDragStarted: () => onDrag(color),
        onDragEnd: (_) => onEnd(),
        child: container,
        feedback: container,
        childWhenDragging: Visibility(
          visible: false,
          child: container,
        ),
      ),
    );
  }
}
