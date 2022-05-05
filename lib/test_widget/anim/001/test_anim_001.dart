//Flutter 动画教程 1-1 两行代码就能动起来

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TestAnim001());
}

class TestAnim001 extends StatefulWidget {
  const TestAnim001({Key key}) : super(key: key);

  @override
  State<TestAnim001> createState() => _TestAnim001State();
}

class _TestAnim001State extends State<TestAnim001> {
  double _height = 100;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
          body: // child: buildAnimatedContainer(),
              // child: buildAnimatedPadding(),
              // child: buildTweenAnimationBuild(),
              // child: buildTweenAnimationBuildDemo(),

              ///手动动画
              // child: buildRotaAnim(),
              // child: TestSlideTransition(),
              // child: TestAnima
              // tionBuilder(),
              //478呼吸法
              // child: TestHuXiFa(),
              MyPaintWidget()),
    );
  }

  AnimatedContainer buildAnimatedContainer() {
    return AnimatedContainer(
      color: Colors.blue,
      width: 300,
      height: _height,
      duration: Duration(milliseconds: 1000),
    );
  }

  buildTweenAnimationBuild() {
    return Center(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 300),
        duration: Duration(seconds: 1),
        builder: (BuildContext context, double value, Widget child) {
          return Container(
            width: value,
            height: 100,
            color: Colors.blue,
          );
        },
      ),
    );
  }

  buildTweenAnimationBuildDemo() {
    return Container(
      height: 100,
      color: Colors.blue,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 1, end: 1000),
        duration: const Duration(seconds: 1),
        builder: (BuildContext context, double value, Widget child) {
          // print('value:$value');
          final value1 = value ~/ 1;
          final value2 = value - value1;
          return Stack(
            children: [
              Positioned(
                  top: -value2 * 100, //0 -> -100
                  child: Opacity(
                    opacity: 1 - value2,
                    child: Text('$value1',
                        style: TextStyle(height: 1.1, fontSize: 100)),
                  )),
              Positioned(
                top: 100 - value2 * 100, //100 -> 0
                child: Opacity(
                  opacity: value2,
                  child: Text('${value1 + 1}',
                      style: TextStyle(height: 1.1, fontSize: 100)),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

///多行标签选择

class TypeSelect extends StatefulWidget {
  const TypeSelect({Key key}) : super(key: key);

  @override
  State<TypeSelect> createState() => _TypeSelectState();
}

class ItemModel {
  final String title;
  bool selected;

  ItemModel(this.title, this.selected);
}

class NameModel {
  final String name;
  final List<ItemModel> data;

  NameModel(this.name, this.data);
}

class buildRotaAnim extends StatefulWidget {
  const buildRotaAnim({Key key}) : super(key: key);

  @override
  State<buildRotaAnim> createState() => _buildRotaAnimState();
}

class _buildRotaAnimState extends State<buildRotaAnim>
    with SingleTickerProviderStateMixin {
  AnimationController _containerAnimation;

  @override
  Widget build(BuildContext context) {
    _containerAnimation.isCompleted
        ? _containerAnimation.reverse()
        : _containerAnimation.forward();
    return Center(
      child: RotationTransition(
        turns: _containerAnimation,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    _containerAnimation =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _containerAnimation.dispose();
    super.dispose();
  }
}

class _TypeSelectState extends State<TypeSelect> {
  List<NameModel> listModel = [];

  @override
  void initState() {
    for (int i = 0; i < 10; i++) {
      listModel.add(NameModel('name$i', [
        ItemModel('1', true),
        ItemModel('2', false),
        ItemModel('3', false),
        ItemModel('4', false),
        ItemModel('5', false),
        ItemModel('6', false),
      ]));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: listV(listModel),
    ));
  }

  List<Widget> listV(List<NameModel> listModel) {
    List<Widget> child = [];
    for (int i = 0; i < listModel.length; i++) {
      child.add(buildItem(listModel[i].data, i));
    }
    return child;
  }

  Widget buildItem(List<ItemModel> data, int row) {
    return Container(
      height: 50,
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: data.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ChoiceChip(
                label: Text('name $index'),
                selected: data[index].selected,
                selectedColor:
                    data[index].selected ? Colors.red : Colors.grey[200],
                onSelected: (bool b) {
                  setState(() {
                    // listModel[i].data[index].selected = b;
                    if (!listModel[row].data[index].selected) {
                      for (int i = 0; i < listModel[i].data.length; i++) {
                        listModel[row].data[i].selected = index == i;
                      }
                    }

                    print(listModel[row].data[index].selected);
                  });
                });
          }),
    );
  }
}

class TestSlideTransition extends StatefulWidget {
  const TestSlideTransition({Key key}) : super(key: key);

  @override
  State<TestSlideTransition> createState() => _TestSlideTransitionState();
}

class _TestSlideTransitionState extends State<TestSlideTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0),
            end: const Offset(0, 1),
            // ).chain(CurveTween(curve: Interval(0.5, 1))).animate(_controller),
          ).chain(CurveTween(curve: Curves.easeInOutExpo)).animate(_controller),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _controller.repeat();
        },
      ),
    );
  }
}

///Flutter 动画教程 2-5 内置的又不够？万能的自定义动画
///https://www.bilibili.com/video/BV15p4y1X7Xp/?spm_id_from=pageDriver
class TestAnimationBuilder extends StatefulWidget {
  const TestAnimationBuilder({Key key}) : super(key: key);

  @override
  State<TestAnimationBuilder> createState() => _TestAnimationBuilderState();
}

class _TestAnimationBuilderState extends State<TestAnimationBuilder>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Animation _opacityAnimation = Tween(begin: 0.0, end: 1.0)
        .chain(
          CurveTween(curve: Curves.easeInOutExpo),
        )
        .animate(_animationController);
    Animation _widthAnimation = Tween(begin: 100.0, end: 200.0)
        .chain(CurveTween(curve: const Interval(0.5, 1)))
        .animate(_animationController);

    return Center(
        child: SizedBox(
      width: 300,
      height: 300,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              width: _widthAnimation.value,
              height: 100,
              color: Colors.blue,
              child: child,
            ),
          );
        },
        child: const Center(
            child: Text(
          'text',
          style: TextStyle(
            fontSize: 70,
          ),
        )),
      ),
    ));
  }
}

///4 7 8呼吸法 多个动画控制器
class TestHuXiFa extends StatefulWidget {
  const TestHuXiFa({Key key}) : super(key: key);

  @override
  State<TestHuXiFa> createState() => _TestHuXiFaState();
}

class _TestHuXiFaState extends State<TestHuXiFa> with TickerProviderStateMixin {
  AnimationController _controller;
  AnimationController _opacityController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _opacityController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.5).animate(_opacityController),
          child: AnimatedBuilder(
            builder: (BuildContext context, Widget child) {
              return Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(0, 0),
                      blurRadius: 50,
                    ),
                  ],
                  gradient: RadialGradient(
                    colors: [
                      Colors.blue[600],
                      Colors.blue[100],
                    ],
                    stops: [
                      _controller.value,
                      _controller.value + 0.1,
                    ],
                  ),
                ),
              );
            },
            animation: _controller,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //4 7 8
          _controller.duration = Duration(seconds: 4);
          _controller.forward();
          await Future.delayed(Duration(seconds: 4));

          _opacityController.duration = Duration(milliseconds: 1750);
          _opacityController.repeat(reverse: true);
          await Future.delayed(Duration(seconds: 7));
          _opacityController.reset();

          _controller.duration = Duration(seconds: 8);
          _controller.reverse();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}

class MyPaintWidget extends StatefulWidget {
  const MyPaintWidget({Key key}) : super(key: key);

  @override
  State<MyPaintWidget> createState() => _MyPaintWidgetState();
}

class _MyPaintWidgetState extends State<MyPaintWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final List<Snowflake> _snowflakes =
      List.generate(1000, (index) => Snowflake());

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.blue,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue,
              Colors.lightBlue,
              Colors.white,
            ],
            stops: [0.1, 0.7, 0.95],
          ),
        ),
        child: AnimatedBuilder(
          builder: (BuildContext context, Widget child) {
            for (var element in _snowflakes) {
              element.fall();
            }
            return CustomPaint(
              painter: MyPainter(_snowflakes),
            );
          },
          animation: _controller,
        ),
      ),
    );
  }
}

///雪花雪人
class MyPainter extends CustomPainter {
  final List<Snowflake> snowflakes;

  MyPainter(this.snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    canvas.drawCircle(size.center(Offset(0, size.width / 3)), 60, paint);
    canvas.drawOval(
        Rect.fromCenter(
            center: size.center(Offset(0, 280)), width: 200, height: 250),
        paint);

    for (var snowflake in snowflakes) {
      canvas.drawCircle(
          Offset(snowflake.x, snowflake.y), snowflake.radius, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

///雪花
class Snowflake {
  double x = Random().nextDouble() * 400;
  double y = Random().nextDouble() * 800;
  double radius = Random().nextDouble() * 2 + 2;
  double speed = Random().nextDouble() * 4 + 2;

  fall() {
    y += speed;
    if (y > 800) {
      y = 0;
      x = Random().nextDouble() * 400;
      radius = Random().nextDouble() * 2 + 2;
      speed = Random().nextDouble() * 4 + 2;
    }
  }
}


