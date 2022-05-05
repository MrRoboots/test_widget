import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

/**
 * IgnorePointer  穿透  AbsorbPointer 不穿透
 */
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
        // home: _buildAbsOrIgnore()
        // home: _buildAlign());
        // home: _buildAlignTransition());
        // home: _buildAnimatedAlign());
        // home: _buildAnimatedBuilder());
        // home: buildAnimatedContainer());
        // home: buildAnimatedCrossFade());
        // home: buildAnimatedDefaultTextStyle());
        // home: buildAnimatedIcon());
        // home: buildAnimatedList());
        // home: buildAnimatedModalBarrier());
        // home: buildAnimatedOpacity());
        // home: buildAnimatedPadding());
        // home: buildAnimatedPhysicalModel());
        // home: buildAnimatedPositioned());
        // home: buildAnimatedPositionedDirectional());
        // home: buildAnimatedSize());
        // home: buildAnimatedSwitcher());
        // home: buildBackdropFilter());
        // home: builedBanner());
        // home: buildBaseline());
        // home: buildBottomAppBar());
        // home: buildBottomNavigationBar());
        // home: buildChip());
        // home: buildColorFiltered());
        home: buildConstrainedBox());
  }

  _buildAlign() {
    return Container(
      color: Colors.lightBlue,
      child: Align(
        widthFactor: 3,
        heightFactor: 4,
        child: Container(
          height: 50,
          width: 50,
          color: Colors.red,
        ),
      ),
    );
  }

  _buildAbsOrIgnore() {
    return Scaffold(
        appBar: AppBar(title: const Text('Flutter Demo')),
        body: SizedBox(
          height: 200,
          width: 200,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Listener(
                onPointerDown: (v) {
                  print('click red');
                },
                child: Container(
                  color: Colors.red,
                ),
              ),
              Listener(
                onPointerDown: (v) {
                  print('click blue self');
                },
                child: AbsorbPointer(
                  child: Listener(
                    onPointerDown: (v) {
                      print('click blue child');
                    },
                    child: Container(
                      color: Colors.blue,
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class buildConstrainedBox extends StatelessWidget {
  const buildConstrainedBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: double.infinity, maxHeight: 60),
              child: Container(
                height: 300,
                width: double.infinity,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text('Baseline'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class buildColorFiltered extends StatefulWidget {
  const buildColorFiltered({Key key}) : super(key: key);

  @override
  _buildColorFilteredState createState() => _buildColorFilteredState();
}

class _buildColorFilteredState extends State<buildColorFiltered> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.purple, BlendMode.modulate),
          child: Image.asset(
            'assets/images/logos.png',
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}

class buildChip extends StatefulWidget {
  const buildChip({Key key}) : super(key: key);

  @override
  _buildChipState createState() => _buildChipState();
}

class _buildChipState extends State<buildChip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Wrap(
      spacing: 10,
      runSpacing: 10,
      children: <Widget>[
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.blue.shade900,
            child: Text('AH'),
          ),
          label: Text('Hamilton'),
        ),
        RawChip(
          label: Text('Hamilton'),
          isEnabled: true,
        ),
        RawChip(
          label: Text('老孟'),
          onDeleted: () {
            print('onDeleted');
          },
          deleteIcon: Icon(Icons.delete),
          deleteIconColor: Colors.red,
          deleteButtonTooltipMessage: '删除',
        ),
        RawChip(
          label: Text('老孟'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(vertical: 10),
        ),
        RawChip(
          label: Text('老孟'),
          selected: true,
          showCheckmark: true,
          checkmarkColor: Colors.red,
        ),
        InputChip(label: Text('老孟'), onPressed: () {}),
        ChoiceChip(label: Text('老孟'), selected: true),
      ],
    )));
  }
}

class buildBottomNavigationBar extends StatefulWidget {
  const buildBottomNavigationBar({Key key}) : super(key: key);

  @override
  _buildBottomNavigationBarState createState() =>
      _buildBottomNavigationBarState();
}

class _buildBottomNavigationBarState extends State<buildBottomNavigationBar> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: "Business",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: "School",
          ),
        ],
      ),
    );
    ;
  }
}

class buildBottomAppBar extends StatefulWidget {
  const buildBottomAppBar({Key key}) : super(key: key);

  @override
  _buildBottomAppBarState createState() => _buildBottomAppBarState();
}

class _buildBottomAppBarState extends State<buildBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        // shape: CircularNotchedRectangle(),
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(),
          // StadiumBorder(side: BorderSide()),
          // BeveledRectangleBorder(),
          BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        elevation: 8,
        notchMargin: 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: Icon(Icons.add),
        label: Text('add'),
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class buildBaseline extends StatelessWidget {
  const buildBaseline({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Baseline(
            baseline: 100,
            baselineType: TextBaseline.alphabetic,
            child: Text(
              'Baseline',
              style: TextStyle(
                  fontSize: 30, textBaseline: TextBaseline.alphabetic),
            ),
          ),
          Baseline(
            baseline: 100,
            baselineType: TextBaseline.ideographic,
            child: Text(
              'Baseline',
              style: TextStyle(
                  fontSize: 30, textBaseline: TextBaseline.alphabetic),
            ),
          ),
        ],
      ),
    );
  }
}

class builedBanner extends StatelessWidget {
  const builedBanner({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Banner(
      message: 'hello',
      location: BannerLocation.topStart,
      color: Colors.red,
      child: Container(
        color: Colors.blue,
        width: 100,
        height: 100,
      ),
    );
  }
}

class buildBackdropFilter extends StatelessWidget {
  const buildBackdropFilter({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      children: [
        Container(
          width: 200,
          height: 200,
          color: Colors.red,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            color: Colors.grey.withOpacity(0.1),
            child: Text(
              "哈哈哈哈哈",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ),
      ],
    ));
  }
}

class buildAnimatedSwitcher extends StatefulWidget {
  const buildAnimatedSwitcher({Key key}) : super(key: key);

  @override
  _buildAnimatedSwitcherState createState() => _buildAnimatedSwitcherState();
}

class _buildAnimatedSwitcherState extends State<buildAnimatedSwitcher> {
  var _currChild;

  @override
  void didUpdateWidget(covariant buildAnimatedSwitcher oldWidget) {
    _currChild = Container(
      key: ValueKey("1"),
      height: 300,
      width: 300,
      color: Colors.red,
    );
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('AnimatedSwitcher'),
          // leading: BackButtonIcon(),
          leading: BackButton(),
        ),
        body: Center(
          child: Column(
            children: [
              AnimatedSwitcher(
                duration: Duration(seconds: 1),
                child: _currChild,
                transitionBuilder: (Widget child, Animation<double> value) {
                  return ScaleTransition(
                    scale: value,
                    child: child,
                  );
                },
              ),
              RaisedButton(
                child: Text("切换"),
                onPressed: () {
                  setState(() {
                    _currChild = Container(
                      key: ValueKey("2"),
                      height: 300,
                      width: 300,
                      color: Colors.blue,
                    );
                  });
                },
              )
            ],
          ),
        ));
  }
}

class buildAnimatedSize extends StatefulWidget {
  const buildAnimatedSize({Key key}) : super(key: key);

  @override
  _buildAnimatedSizeState createState() => _buildAnimatedSizeState();
}

class _buildAnimatedSizeState extends State<buildAnimatedSize>
    with SingleTickerProviderStateMixin {
  var _height = 100.0;
  var _width = 100.0;
  var _color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AnimatedSize(
            vsync: this,
            duration: Duration(seconds: 1),
            child: Container(
              height: _height,
              width: _width,
              color: _color,
            ),
          ),
          RaisedButton(
            child: Text('AnimatedSize'),
            onPressed: () {
              setState(() {
                _height = _height == 100 ? 200 : 100;
                _width = _width == 100 ? 200 : 100;
                _color = _color == Colors.red ? Colors.blue : Colors.red;
              });
            },
          ),
        ],
      ),
    );
  }
}

class buildAnimatedPositionedDirectional extends StatefulWidget {
  const buildAnimatedPositionedDirectional({Key key}) : super(key: key);

  @override
  _buildAnimatedPositionedDirectionalState createState() =>
      _buildAnimatedPositionedDirectionalState();
}

class _buildAnimatedPositionedDirectionalState
    extends State<buildAnimatedPositionedDirectional> {
  double start = 80;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedPositionedDirectional(
          start: start,
          width: 50,
          height: 50,
          child: Container(color: Colors.red),
          duration: Duration(seconds: 2),
        ),
        RaisedButton(
          child: Text('start'),
          onPressed: () {
            setState(() {
              start = start == 0 ? 100 : 0;
            });
          },
        )
      ],
    );
  }
}

class buildAnimatedPositioned extends StatefulWidget {
  const buildAnimatedPositioned({Key key}) : super(key: key);

  @override
  _buildAnimatedPositionedState createState() =>
      _buildAnimatedPositionedState();
}

class _buildAnimatedPositionedState extends State<buildAnimatedPositioned> {
  var _top = 30.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AnimatedPositioned(
          duration: Duration(seconds: 1),
          top: _top,
          child: Container(
            color: Colors.red,
            width: 100,
            height: 100,
          ),
        ),
        Positioned(
          top: _top,
          child: RaisedButton(
            child: Text('click'),
            onPressed: () {
              setState(() {
                _top = _top + 10;
              });
            },
          ),
        )
      ],
    );
  }
}

class buildAnimatedPhysicalModel extends StatefulWidget {
  const buildAnimatedPhysicalModel({Key key}) : super(key: key);

  @override
  _buildAnimatedPhysicalModelState createState() =>
      _buildAnimatedPhysicalModelState();
}

class _buildAnimatedPhysicalModelState
    extends State<buildAnimatedPhysicalModel> {
  bool _animated = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            child: const Text('动画'),
            onPressed: () {
              setState(() {
                _animated = !_animated;
              });
            },
          ),
          _buildAnimatedPhysicalMethod(),
        ],
      ),
    );
  }

  _buildAnimatedPhysicalMethod() {
    return AnimatedPhysicalModel(
      duration: const Duration(seconds: 1),
      color: _animated ? Colors.red : Colors.blue,
      elevation: _animated ? 10 : 0,
      shadowColor: _animated ? Colors.red : Colors.blue,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 100,
        height: 100,
      ),
    );
  }
}

class buildAnimatedPadding extends StatefulWidget {
  const buildAnimatedPadding({Key key}) : super(key: key);

  @override
  _buildAnimatedPaddingState createState() => _buildAnimatedPaddingState();
}

class _buildAnimatedPaddingState extends State<buildAnimatedPadding> {
  var _padding = EdgeInsets.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          AnimatedPadding(
            curve: Curves.bounceOut,
            padding: _padding,
            duration: const Duration(seconds: 1),
            child: Container(
              height: 100,
              width: 100,
              color: Colors.red,
            ),
          ),
          RaisedButton(
            child: Text('AnimatedPadding'),
            onPressed: () {
              setState(() {
                _padding = EdgeInsets.all(50);
              });
            },
          ),
        ],
      )),
    );
  }
}

class buildAnimatedOpacity extends StatefulWidget {
  const buildAnimatedOpacity({Key key}) : super(key: key);

  @override
  _buildAnimatedOpacityState createState() => _buildAnimatedOpacityState();
}

class _buildAnimatedOpacityState extends State<buildAnimatedOpacity> {
  var _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AnimatedOpacity(
            opacity: _opacity,
            curve: Curves.easeIn,
            duration: Duration(seconds: 1),
            child: Container(
              height: 60,
              width: 150,
              color: Colors.red,
            ),
          ),
          Slider(
            value: _opacity,
            onChanged: (v) {
              setState(() {
                _opacity = v;
              });
            },
          ),
        ],
      ),
    );
  }
}

class buildAnimatedModalBarrier extends StatefulWidget {
  const buildAnimatedModalBarrier({Key key}) : super(key: key);

  @override
  _buildAnimatedModalBarrierState createState() =>
      _buildAnimatedModalBarrierState();
}

class _buildAnimatedModalBarrierState extends State<buildAnimatedModalBarrier>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation =
        ColorTween(begin: Colors.red, end: Colors.blue).animate(_controller);
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100,
        width: 100,
        child: AnimatedModalBarrier(
          color: _animation,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class buildAnimatedList extends StatefulWidget {
  const buildAnimatedList({Key key}) : super(key: key);

  @override
  _buildAnimatedListState createState() => _buildAnimatedListState();
}

class _buildAnimatedListState extends State<buildAnimatedList>
    with SingleTickerProviderStateMixin {
  List<int> _list = [];
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _addItem() {
    final int index = _list.length;
    _list.add(index);
    _listKey.currentState.insertItem(index);
  }

  void _removeItem() {
    if (_list.isEmpty) {
      return;
    }
    final int index = _list.length - 1;
    var item = _list[index].toString();
    _listKey.currentState.removeItem(
        index, (context, animation) => _buildItem2(item, animation));
    _list.removeAt(index);
  }

  Widget _buildItem(String item, Animation<double> animation) {
    return SlideTransition(
        position: animation
            .drive(CurveTween(curve: Curves.easeIn))
            .drive(Tween(begin: Offset(1, 1), end: Offset(0, 1))),
        child: Card(
          child: ListTile(
            title: Text(item),
          ),
        ));
  }

  _buildItem2(String item, Animation<double> animation) {
    return SizeTransition(
        sizeFactor: animation, child: Card(child: ListTile(title: Text(item))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _list.length,
        itemBuilder: (context, index, animation) {
          return _buildItem2(_list[index].toString(), animation);
        },
      ),
      floatingActionButton: FloatingActionButton(
        // onPressed: _removeItem,
        // child: Icon(Icons.remove),
        onPressed: _addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}

class buildAnimatedIcon extends StatefulWidget {
  const buildAnimatedIcon({Key key}) : super(key: key);

  @override
  _buildAnimatedIconState createState() => _buildAnimatedIconState();
}

class _buildAnimatedIconState extends State<buildAnimatedIcon>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      alignment: Alignment.center,
      child: AnimatedIcon(
        icon: AnimatedIcons.pause_play,
        progress: animationController,
        color: Colors.blue,
        size: 50,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class buildAnimatedDefaultTextStyle extends StatefulWidget {
  const buildAnimatedDefaultTextStyle({Key key}) : super(key: key);

  @override
  _buildAnimatedDefaultTextStyleState createState() =>
      _buildAnimatedDefaultTextStyleState();
}

class _buildAnimatedDefaultTextStyleState
    extends State<buildAnimatedDefaultTextStyle>
    with SingleTickerProviderStateMixin {
  TextStyle _textStyle;

  @override
  void initState() {
    _textStyle = TextStyle(
      color: Colors.white,
      fontSize: 18,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          AnimatedDefaultTextStyle(
              child: Text("老王"),
              style: _textStyle,
              duration: Duration(seconds: 2)),
          SizedBox(height: 100),
          TextButton(
            child: Text("改变字体大小"),
            onPressed: () {
              setState(() {
                _textStyle = TextStyle(
                  color: Colors.black,
                  fontSize: _textStyle.fontSize == 18 ? 30 : 18,
                );
              });
            },
          )
        ],
      ),
    );
  }
}

class buildAnimatedCrossFade extends StatefulWidget {
  const buildAnimatedCrossFade({Key key}) : super(key: key);

  @override
  _buildAnimatedCrossFadeState createState() => _buildAnimatedCrossFadeState();
}

class _buildAnimatedCrossFadeState extends State<buildAnimatedCrossFade> {
  bool _showFirst = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedCrossFade(
          reverseDuration: const Duration(seconds: 1),
          crossFadeState:
              _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          firstChild: Container(
            width: 150,
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.red, width: 2),
            ),
            child: Text('first'),
          ),
          secondChild: Container(
            width: 150,
            height: 150,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.orange,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Text('second'),
          ),
          duration: Duration(seconds: 1),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              _showFirst = !_showFirst;
            });
          },
          child: Text('change'),
        )
      ],
    );
  }
}

class buildAnimatedContainer extends StatefulWidget {
  const buildAnimatedContainer({Key key}) : super(key: key);

  @override
  _buildAnimatedContainerState createState() => _buildAnimatedContainerState();
}

class _buildAnimatedContainerState extends State<buildAnimatedContainer> {
  bool click = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            click = !click;
          });
        },
        child: AnimatedContainer(
          curve: Curves.linear,
          width: click ? 100 : 200,
          height: click ? 100 : 200,
          onEnd: () {
            click = !click;
          },
          duration: Duration(seconds: 3),
          decoration: BoxDecoration(
              color: click ? Colors.red : Colors.blue,
              borderRadius: BorderRadius.circular(click ? 200 : 0),
              image: DecorationImage(
                image: NetworkImage(
                    'https://plc.jj20.com/up/allimg/1111/0Q91Q50307/1PQ9150307-6.jpg'),
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}

class _buildAnimatedBuilder extends StatefulWidget {
  const _buildAnimatedBuilder({Key key}) : super(key: key);

  @override
  _buildAnimatedBuilderState createState() => _buildAnimatedBuilderState();
}

class _buildAnimatedBuilderState extends State<_buildAnimatedBuilder>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    animation = Tween(begin: 0.0, end: 2.0 * pi).animate(animationController);
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.rotate(angle: animation.value, child: child);
      },
      child: const FlutterLogo(
        size: 60,
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}

class _buildAnimatedAlign extends StatefulWidget {
  const _buildAnimatedAlign({Key key}) : super(key: key);

  @override
  _buildAnimatedAlignState createState() => _buildAnimatedAlignState();
}

class _buildAnimatedAlignState extends State<_buildAnimatedAlign> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.lightBlue,
      child: AnimatedAlign(
        curve: Curves.easeInOut,
        duration: Duration(seconds: 1),
        alignment: Alignment.topLeft,
        onEnd: () {
          print('onEnd');
        },
        child: Container(
          width: 100,
          height: 100,
          color: Colors.red,
        ),
      ),
    );
  }
}

class _buildAlignTransition extends StatefulWidget {
  const _buildAlignTransition({Key key}) : super(key: key);

  @override
  _buildAlignTransitionState createState() => _buildAlignTransitionState();
}

class _buildAlignTransitionState extends State<_buildAlignTransition>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween(begin: Alignment.centerLeft, end: Alignment.centerRight)
        .animate(_animationController);
    _animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      color: Colors.lightBlue,
      child: AlignTransition(
        alignment: _animation,
        child: Listener(
          onPointerDown: (v) {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
          },
          child: Container(
            height: 50,
            width: 50,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
