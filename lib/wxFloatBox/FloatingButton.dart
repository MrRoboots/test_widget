import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_stream/wxFloatBox/FloatingButtonPainter.dart';

class FloatingButton extends StatefulWidget {
   double left;
   double top;
  final ImageProvider imageProvider;

  FloatingButton(
      {@required this.imageProvider, @required this.left, @required this.top});

  @override
  _FloatingButtonState createState() => _FloatingButtonState();
}

class _FloatingButtonState extends State<FloatingButton>
    with TickerProviderStateMixin {
  // double _left = 0.0; //按钮在屏幕上的x坐标
  // double _top = 100.0; //按钮在屏幕上的y坐标
  bool isLeft = true; //按钮是否在按钮左侧

  // bool isEdge = true; //按钮是否处于边缘
  // bool isPress = false; //按钮是否被按下

  AnimationController _controller;
  Animation _animation; // 松开后按钮返回屏幕边缘的动画

  @override
  void initState() {
    super.initState();
    // _left = MediaQuery.of(context).size.width - 50;
    // _top = MediaQuery.of(context).size.height - 50;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: Listener(
        //按下后设isPress为true，绘制选中阴影
        onPointerDown: (details) {
          setState(() {
            // isPress = true;
            // draggable = true;
          });
        },
        //按下后设isPress为false，不绘制阴影
        //放下后根据当前x坐标与1/2屏幕宽度比较，判断屏幕在屏幕左侧或右侧，设置返回边缘动画
        //动画结束后设置isLeft的值，根据值绘制左/右边缘按钮
        onPointerUp: (e) async {
          setState(() {
            // isPress = false;
          });
          var pixelDetails = MediaQuery.of(context).size; //获取屏幕信息
          if (e.position.dx <= pixelDetails.width / 2) {
            _controller = new AnimationController(
                vsync: this,
                duration: new Duration(milliseconds: 100)); //0.1s动画
            _animation =
                new Tween(begin: e.position.dx, end: 0.0).animate(_controller)
                  ..addListener(() {
                    setState(() {
                      widget.left = _animation.value; //更新x坐标
                    });
                  });
            await _controller.forward(); //等待动画结束
            _controller.dispose(); //释放动画资源
            setState(() {
              isLeft = true; //按钮在屏幕左侧
            });
          } else {
            _controller = new AnimationController(
                vsync: this, duration: new Duration(milliseconds: 100)); //0.1动画
            _animation =
                new Tween(begin: e.position.dx, end: pixelDetails.width - 50)
                    .animate(_controller) //返回右侧坐标需要减去自身宽度及50，因坐标以图形左上角为基点
                  ..addListener(() {
                    setState(() {
                      widget.left = _animation.value; //动画更新x坐标
                    });
                  });
            await _controller.forward(); //等待动画结束
            _controller.dispose(); //释放动画资源
            setState(() {
              isLeft = false; //按钮在屏幕左侧
            });
          }

          setState(() {
            // isEdge = true; //按钮返回至边缘
          });
        },
        child: GestureDetector(
          onTap: () {
            print("asfasdf");
          },
          //拖拽更新
          onPanUpdate: (details) {
            var pixelDetails = MediaQuery.of(context).size; //获取屏幕信息
            //拖拽后更新按钮信息，是否处于边缘
/*            if (_left + details.delta.dx > 0 &&
                _left + details.delta.dx < pixelDetails.width - 50) {
              setState(() {
                // isEdge = false;
              });
            }*/

            //拖拽更新坐标
/*            setState(() {
              _left += details.delta.dx;
              _top += details.delta.dy;
            });*/

            _calOffset(MediaQuery.of(context).size, widget.left, widget.top, details.delta);
          },
          child: FutureBuilder(
            future: loadImageByProvider(widget.imageProvider),
            builder: (context, snapshot) => CustomPaint(
              size: Size(50.0, 50.0),
              painter: FloatingButtonPainter(
                  isLeft: isLeft,
                  // isEdge: isEdge,
                  // isPress: isPress,
                  buttonImage: snapshot.data),
            ),
          ),
        ),
      ),
    );
  }

  _calOffset(Size size, double left, double right, Offset nextOffset) {
    double dx = 0;
    if (left + nextOffset.dx <= 0) {
      dx = 0;
    } else if (left + nextOffset.dx >= (size.width - 50)) {
      dx = size.width - 50;
    } else {
      dx = left + nextOffset.dx;
    }

    double dy = 0;
    if (right + nextOffset.dy >= (size.height - 50)) {
      dy = size.height - 50;
    } else if (right + nextOffset.dy <=
        kToolbarHeight + MediaQuery.of(context).padding.top) {
      dy = kToolbarHeight + MediaQuery.of(context).padding.top;
    } else {
      dy = right + nextOffset.dy;
    }

    setState(() {
      widget.left = dx;
      widget.top = dy;
    });
  }

  //通过ImageProvider获取ui.image
  Future<ui.Image> loadImageByProvider(
    ImageProvider provider, {
    ImageConfiguration config = ImageConfiguration.empty,
  }) async {
    Completer<ui.Image> completer = Completer<ui.Image>(); //完成的回调
    ImageStreamListener listener;
    ImageStream stream = provider.resolve(config); //获取图片流
    listener = ImageStreamListener((ImageInfo frame, bool sync) {
      //监听
      final ui.Image image = frame.image;
      completer.complete(image); //完成
      stream.removeListener(listener); //移除监听
    });
    stream.addListener(listener); //添加监听
    return completer.future; //返回
  }
}
