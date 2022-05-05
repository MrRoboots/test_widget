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
      home: buildStack(),
    );
  }

  Container buildStack() {
    return Container(
      color: Colors.white,
      child: Center(
        child: Container(
          color: Colors.green,
          width: 200,
          height: 200,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                child: Container(
                  width: 20,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                top: -25,
                left: -10,
                right: -10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
