import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: "",
      future: dioDown(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
            ),
            body: ListView.builder(
              cacheExtent: 1000,
              itemBuilder: (context, index) {
                return Text(snapshot.data[index]);
              },
              itemCount: snapshot.data.length,
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  /// 发起下载请求
  /// https://testc.hzsy66.cn/comic/novel/fanrenxiuxianzhuan/1.txt
  /// https://testc.hzsy66.cn/comic/novel/dpcq2.txt
  /// https://testc.hzsy66.cn/comic/novel/dpcq3.txt
  /* Future<List<String>> dioDown() async {
    List<String> list = [];
    try {
      /// 发起下载请求
      Response<ResponseBody> response = await Dio().get<ResponseBody>("https://testc.hzsy66.cn/comic/novel/dpcq3.txt",
          options: Options(
            responseType: ResponseType.stream,
            followRedirects: false,
          ));

      var st = StreamTransformer<Uint8List, List<int>>.fromHandlers(handleData: (Uint8List data, sink) {
        sink.add(data.toList());
      });

      try {
        Stream<String> stream =
            response.data.stream.transform(st).transform(utf8.decoder).transform(const LineSplitter());
        await for (String line in stream) {
          list.add(line);
          print("=============>$line");
        }

        return list;
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return list;
  }*/

  Future<List<String>> dioDown() async {
    List<String> list = [];
    try {
      /// 发起下载请求
      Response<String> response = await Dio().get<String>("https://testc.hzsy66.cn/comic/novel/dpcq3.txt",
          options: Options(
            responseType: ResponseType.plain,
            followRedirects: false,
          ));
      print(response.data.length);
      print(response.data.toString());

      int i = 0;
      while (i < response.data.length) {
        list.add(response.data);
      }

      list.add(response.data);
      return list;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return list;
  }
}
