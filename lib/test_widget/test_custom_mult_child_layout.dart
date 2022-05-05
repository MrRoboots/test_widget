import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TestStack());
}

class TestStack extends StatelessWidget {
  const TestStack({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      color: Colors.white,
      home: testCustomMultChildLayout(),
    );
  }

  Widget testCustomMultChildLayout() {
    return Container(
      color: Colors.white,
      child: CustomMultiChildLayout(
        delegate: MyMultiChildLayoutDelegate(),
        children: [
          LayoutId(id: 1, child: const FlutterLogo(size: 20)),
          LayoutId(id: 2, child: const FlutterLogo(size: 20)),
        ],
      ),
    );
  }
}

class MyMultiChildLayoutDelegate extends MultiChildLayoutDelegate {
  @override
  void performLayout(Size size) {
    var size1, size2;
    if (hasChild(1)) {
      size1 = layoutChild(1, BoxConstraints.loose(size));
      positionChild(1, Offset(0, 0));
    }

    if (hasChild(2)) {
      size2 = layoutChild(2, BoxConstraints.loose(size));
      positionChild(2, Offset(size1.width, size1.height));
    }
  }

  @override
  bool shouldRelayout(covariant MultiChildLayoutDelegate oldDelegate) => true;
}
