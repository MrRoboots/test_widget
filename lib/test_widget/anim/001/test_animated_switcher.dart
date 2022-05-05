import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TestAnimatedSwitcher());
}

class TestAnimatedSwitcher extends StatefulWidget {
  const TestAnimatedSwitcher({Key key}) : super(key: key);

  @override
  State<TestAnimatedSwitcher> createState() => _TestAnimatedSwitcherState();
}

class _TestAnimatedSwitcherState extends State<TestAnimatedSwitcher> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: AnimatedSwitcher(
            duration: const Duration(seconds: 1),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return RotationTransition(
                  turns: animation,
                  child: FadeTransition(
                    child: ScaleTransition(
                      child: child,
                      scale: animation,
                    ),
                    opacity: animation,
                  ));
            },
            child: Text(
              'Hello',
              key: UniqueKey(),
            ),
          ),
        ),
      ),
    );
  }
}
