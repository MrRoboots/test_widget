import 'package:flutter/material.dart';
import 'package:test_stream/widget/wrapper/wrapper.dart';

class TipBox extends StatefulWidget {
  const TipBox({Key key}) : super(key: key);

  @override
  State<TipBox> createState() => _TipBoxState();
}

class _TipBoxState extends State<TipBox> {
  final LayerLink _layerLink = LayerLink();
  bool show = false;
  OverlayEntry _overlayEntry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleOverlay,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: const FlutterLogo(size: 100),
      ),
    );
  }

  void _toggleOverlay() {
    if (!show) {
      _showOverlay();
    } else {
      _hideOverlay();
    }
    show = !show;
  }

  void _showOverlay() {
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry);
  }

  void _hideOverlay() {
    _overlayEntry?.remove();
  }

  OverlayEntry _createOverlayEntry() => OverlayEntry(
      builder: (context) => UnconstrainedBox(
            child: CompositedTransformFollower(
              targetAnchor: Alignment.topCenter,
              followerAnchor: Alignment.bottomCenter,
              offset: const Offset(0, 0),
              link: _layerLink,
              child: Material(
                  child: SizedBox(
                width: 150,
                child: Wrapper(
                  color: Colors.greenAccent,
                  spineType: SpineType.bottom,
                  elevation: 1,
                  offset: 70,
                  shadowColor: Colors.grey.withAlpha(88),
                  child: Text('hello' * 10),
                ),
              )),
            ),
          ));
}
