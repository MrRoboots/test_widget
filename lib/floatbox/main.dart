import 'package:flutter/material.dart';
import 'package:test_stream/floatbox/float_overlay_demo.dart';
import 'package:test_stream/wxFloatBox/FloatingButton.dart';

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
        home: FloatOverLayDemo(),
   /*     home: new Scaffold(
            appBar: new AppBar(title: Text('Flutter Demo')),
            body: Stack(
              children: <Widget>[
                         FloatingButton(
                  imageProvider: AssetImage('assets/images/logos.png'),
                )
              ],
            ))*/);
  }
}
