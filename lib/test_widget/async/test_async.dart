import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

///
/// 异步操作
/// flutter 事件循环机制
/// 打开程序 运行main 检查MicrotaskQueue有没有任务 如果有就执行，直到没有任务再去执行EventQueue的任务 空了程序就结束了。
///
/// 事件直接运行的
/// Future.sync()
/// Future.value()
/// _then()
///
/// MircroTask
/// scheduleMicrotask()
/// Future.microtask()
/// _completed.them()
///
/// EventQueue
/// Future()
/// Future.delayed()
///
/// DefaultTextStyle包裹起来的Widget默认使用当前的TextStyle
/// SteamController 只能监听一个,可以缓存数据（在初始化initState中延时几秒钟，此时添加数据，可以被记录下来）
/// SteamController.broadcast() 可以监听多个，不缓存数据（不会被记录）
///
/// Flutter 支持 字符串*10
///
///

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
      // home: const TestAsync(),
      ///小游戏
      home: const TestGame(),
    );
  }
}

class TestAsync extends StatefulWidget {
  const TestAsync({Key key}) : super(key: key);

  @override
  State<TestAsync> createState() => _TestAsyncState();
}

class _TestAsyncState extends State<TestAsync> {
  final _controller = StreamController();

  @override
  void initState() {
    /*_controller.stream.listen((event) {
      print(event);
    });*/
    super.initState();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          TextButton(
              onPressed: () => _controller.sink.add('hello'),
              child: const Text(
                '添加数据',
                style: TextStyle(fontSize: 20),
              )),
          DefaultTextStyle(
            style: const TextStyle(fontSize: 20, color: Colors.black),
            child: StreamBuilder(
              // stream: _controller.stream.distinct(), // 去重 不会重新build
              stream: getDateTime(),
              initialData: '123',
              builder: (context, snapshot) {
                print('buildering...');
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text('结束:${snapshot.data}');
                } else if (snapshot.connectionState == ConnectionState.active) {
                  return Text('活跃:${snapshot.data}');
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return const Text('无');
                }
                /*else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }*/
                return Text('初始值:${snapshot.data}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Stream<DateTime> getDateTime() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      yield DateTime.now();
    }
  }
}

///小游戏
class TestGame extends StatefulWidget {
  const TestGame({Key key}) : super(key: key);

  @override
  State<TestGame> createState() => _TestGameState();
}

class _TestGameState extends State<TestGame> {
  final _inputController = StreamController.broadcast();
  final _scoreController = StreamController.broadcast();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: StreamBuilder(
                stream: _scoreController.stream.transform(ScoreTransformer()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text('score:${snapshot.data}');
                  }
                  return const Text('score:0');
                })),
        body: Stack(
          children: [
            ...List.generate(5,
                (index) => Puzzle(_inputController.stream, _scoreController)),
            Align(
              alignment: Alignment.bottomCenter,
              child: KeyPad(_inputController),
            ),
          ],
        ));
  }
}

class ScoreTransformer implements StreamTransformer {
  int score = 0;
  StreamController _controller = StreamController();

  @override
  Stream bind(Stream<dynamic> stream) {
    stream.listen((event) {
      if (event is int) {
        score += event;
        _controller.add(score);
      }
    });
    return _controller.stream;
  }

  @override
  StreamTransformer<RS, RT> cast<RS, RT>() => StreamTransformer.castFrom(this);
}

class Puzzle extends StatefulWidget {
  final Stream<dynamic> stream;
  final StreamController<dynamic> scoreController;

  const Puzzle(
    this.stream,
    this.scoreController, {
    Key key,
  }) : super(key: key);

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  int a;
  int b;
  double x;
  Color color;

  _PuzzleState();

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1));
    reset(Random().nextDouble());
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        reset();
        widget.scoreController.add(-3);
      }
    });

    widget.stream.listen((event) {
      print(event);
      if (event == a + b) {
        reset();
        widget.scoreController.add(5);
      }
    });
    super.initState();
  }

  void reset([from = 0.0]) {
    a = Random().nextInt(5) + 1;
    b = Random().nextInt(5);
    x = Random().nextDouble() * 300;
    color = Colors.primaries[Random().nextInt(Colors.primaries.length)][200];
    _animationController.duration =
        Duration(milliseconds: Random().nextInt(5000) + 5000);
    _animationController.forward(from: from);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, Widget child) {
          return Positioned(
            top: 500 * _animationController.value - 100,
            left: x,
            child: Container(
              child: Text('$a + $b',
                  style: const TextStyle(color: Colors.black, fontSize: 20)),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
            ),
          );
        });
  }
}

///键盘
class KeyPad extends StatefulWidget {
  final StreamController streamController;

  const KeyPad(this.streamController, {Key key}) : super(key: key);

  @override
  State<KeyPad> createState() => _KeyPadState();
}

class _KeyPadState extends State<KeyPad> {
  final itemList = List.generate(9, (index) => Colors.primaries[index]);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: itemList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2 / 1,
        ),
        itemBuilder: (context, index) {
          return itemList
              .map((e) => ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder()),
                        backgroundColor: MaterialStateProperty.all(e[500])),
                    onPressed: () {
                      widget.streamController.add(index + 1);
                    },
                    child: Center(
                      child: Text('${index + 1}'),
                    ),
                  ))
              .toList()[index];
        });
  }
}
