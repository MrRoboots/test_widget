import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '评论回复示例',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomSheetInput(),
    );
  }
}

class BottomSheetInput extends StatefulWidget {
  @override
  _BottomSheetInputState createState() => _BottomSheetInputState();
}

class _BottomSheetInputState extends State<BottomSheetInput> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('底部输入弹窗'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            showDialog(
                context: context, builder: (context) => BottomInputDialog());
          },
          child: Text('打开输入弹窗'),
        ),
      ),
    );
  }
}

class BottomInputDialog extends StatefulWidget {
  const BottomInputDialog({Key key}):super(key: key);

  @override
  State<BottomInputDialog> createState() => _BottomInputDialogState();
}

class _BottomInputDialogState extends State<BottomInputDialog>
    with TickerProviderStateMixin {
   AnimationController _controller;
   Animation _animation;

  @override
  void initState() {
    super.initState();
    //用于动画
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation =
        Tween(end: Offset.zero, begin: Offset(0.0, 1.0)).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print('onWillPop');
        // 关闭键盘
        // FocusScope.of(context).unfocus();
        //
        // // 关闭弹出框
        // if (Navigator.of(context).canPop()) {
        //   Navigator.of(context).pop();
        // }
        _controller.reverse();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0x33999999),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _buildTopWidget()),
            _buildBottomWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.maybePop(context);
      },
      child: Container(
        color: Color(0x33999999),
      ),
    );
  }

  Widget _buildBottomWidget() {
    return SlideTransition(
      position: _animation as Animation<Offset>,
      child: Container(
        color: Colors.white,
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SafeArea(
                top: false,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: true,
                        decoration: InputDecoration(hintText: '请输入'),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
