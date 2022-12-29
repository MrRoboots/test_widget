import 'package:flutter/material.dart';
import 'package:test_stream/widget/asperct_raio_image.dart';

import '9test_img.dart';

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
      // home: const TestImg(),
      home: Scaffold(
        body: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              return AsperctRaioImage.network(
                  'http://g.hiphotos.baidu.com/image/pic/item/c2cec3fdfc03924590b2a9b58d94a4c27d1e2500.jpg',
                  builder: (context, snapshot, url) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      '网络图片加载',
                      style: TextStyle(fontSize: 25.0, color: Colors.black),
                    ),
                    Text(
                      '大小--${snapshot.data.width.toDouble()}x${snapshot.data.height.toDouble()}',
                      style: const TextStyle(fontSize: 17.0),
                    ),
                    Container(
                      width: snapshot.data.width.toDouble() / 10,
                      height: snapshot.data.height.toDouble() / 10,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(url), fit: BoxFit.cover),
                      ),
                    )
                  ],
                );
              });
            }),
      ),
    );
  }
}
