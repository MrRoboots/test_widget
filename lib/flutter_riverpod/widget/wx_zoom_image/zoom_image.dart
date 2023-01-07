import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_stream/flutter_riverpod/utils/double_extension.dart';

class ZoomImage extends StatefulWidget {
  const ZoomImage({Key key}) : super(key: key);

  @override
  State<ZoomImage> createState() => _ZoomImageState();
}

class _ZoomImageState extends State<ZoomImage> {
  Animation<Offset> _backOffsetAnim;

  Animation<Offset> get backOffsetAnim => _backOffsetAnim;

  Animation<Offset> _scaleOffsetAnim;

  Animation<Offset> get scaleOffsetAnim => _scaleOffsetAnim;

  Offset _startingOffset = Offset.zero;
  Offset _offset = Offset.zero;
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          onScaleEnd: _onScaleEnd,
          behavior: HitTestBehavior.translucent,
          child: Transform.translate(
            offset: _offset,
            child: Transform.scale(
              scale: _scale,
              child: const Center(child: FlutterLogo(size: 100)),
            ),
          )),
    );
  }

  void _onScaleStart(ScaleStartDetails details) {
    _startingOffset = details.focalPoint;
    print('_onScaleStart:$_startingOffset');
  }

  Offset _updateSlidePagePreOffset;

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (details.scale == 1.0) {
      final double delta = (details.focalPoint - _startingOffset).distance;
      print(delta);

      if (delta.greaterThan(5)) {
        _updateSlidePagePreOffset ??= details.focalPoint;
        Offset value = details.focalPoint - _updateSlidePagePreOffset;
        _offset += value;
        _scale = defaultSlideScaleHandler(offset: _offset, pageSize: context.size);
        print('_onScaleUpdate:$_offset');
        _updateSlidePagePreOffset = details.focalPoint;
        setState(() {});
      }
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    if (_offset != Offset.zero) {
      _offset = Offset.zero;
      _scale = 1.0;
      setState(() {});
    }
  }

  double defaultSlideScaleHandler({
    Offset offset = Offset.zero,
    Size pageSize = const Size(100, 100),
  }) {
    double scale = 0.0;
    print(pageSize.toString());
    scale = offset.distance / Offset(pageSize.width, pageSize.height).distance;
    return max(1.0 - scale, 0.8);
  }
}
