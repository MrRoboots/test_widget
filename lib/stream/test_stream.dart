import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'stream_demo2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StreamDemo(),
      // home: StreamDemo2(),
    );
  }
}

class StreamDemo extends StatelessWidget {
  Future<Stream<String>> requestData() async {
    Response<ResponseBody> response = await Dio().get<ResponseBody>(
        "https://testc.hzsy66.cn/comic/novel/doupocangqiong.txt",
        options: Options(
          responseType: ResponseType.stream,
          followRedirects: false,
        ));

    var st = StreamTransformer<Uint8List, List<int>>.fromHandlers(
        handleData: (Uint8List data, sink) {
      sink.add(data.toList());
    });

    Stream<String> stream = response.data.stream
        .transform(st)
        .transform(utf8.decoder)
       /* .transform(const LineSplitter())*/;

/*    stream.forEach((element) {
      print(element);
    });*/

    return stream;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('StreamDemo')),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: requestData(),
          builder:
              (BuildContext context, AsyncSnapshot<Stream<String>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return StreamBuilder<String>(
                  initialData: "",
                  stream: snapshot.data,
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    return Text(
                      '${snapshot.data}',
                      style: TextStyle(fontSize: 24.0),
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
