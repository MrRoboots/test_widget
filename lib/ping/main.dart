import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

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
      home: PingDemo(),
      // home: StreamDemo2(),
    );
  }
}

class PrintManager {
  Completer<String> _completer;

  static PrintManager manager;

  double _parseResult(ProcessResult result) {
    final didSucceed = (result.stderr as String ?? "").isEmpty && result.stdout != null;
    if (!didSucceed) throw PingError.requestFailed;
    final value = RegExp(r"time=(\d+(\.\d+)?) ms").firstMatch(result.stdout)?.group(1);
    if (value == null) {
      final didLosePacket = (result.stdout as String).contains("100% packet loss");
      if (didLosePacket) throw PingError.packetLost;
      throw PingError.invalidFormat;
    }
    return double.parse(value);
  }

  static initData() {
    if (manager == null) {
      manager = PrintManager();
    }
  }

  //开始做任务
  static Future<void> doActionTask() async {
    for (int i = 0; i < 20; i++) {
      print('进入循环第${i} 个');
     String str = await manager.printe();
     print('打印结果：$str');
    }
  }

  //打印任务
  Future<String> printe() async {
    _completer = Completer<String>();
    await sendMessage();
    print('在等待中');
    return _completer.future;
  }

  //发送消息数据进行打印
  Future<void> sendMessage() async {
    /*await Future(() {
      print('耗时任务，挂起来， 发送消息了 async');
    });*/
    var result = await Process.run('ping', ['-c', '1', 'testc.hzsy66.cn']);
    print("====> ${_parseResult(result)}");
    print(result.stdout);
    callBack();
  }

  //回调
  static void callBack() {
    if (manager._completer?.isCompleted == false) {
      print('啊 我回调了, 可以执行下一个了');
      manager._completer.complete('xixi');
    }
  }
}

enum PingError {
  requestFailed,
  packetLost,
  invalidFormat,
}

class PingDemo extends StatelessWidget {
  const PingDemo({Key key}) : super(key: key);

  double _parseResult(ProcessResult result) {
    final didSucceed = (result.stderr as String ?? "").isEmpty && result.stdout != null;
    if (!didSucceed) throw PingError.requestFailed;
    final value = RegExp(r"time=(\d+(\.\d+)?) ms").firstMatch(result.stdout)?.group(1);
    if (value == null) {
      final didLosePacket = (result.stdout as String).contains("100% packet loss");
      if (didLosePacket) throw PingError.packetLost;
      throw PingError.invalidFormat;
    }
    return double.parse(value);
  }

  @override
  Widget build(BuildContext context) {
    PrintManager.initData();

    return GestureDetector(
      onTap: () async {
        /*       for(int i=0;i<10;i++){
          final result = await Process.run("ping", ["-c", "1", "www.google.com"]);
          final value = _parseResult(result);
          print("Ping: $value ms");
        }*/
        /*var result = await Process.run('ping', ['-c', '1', 'testc.hzsy66.cn']);
        print("====> ${_parseResult(result)}");
        print(result.stdout);*/

        PrintManager.doActionTask();
      },
      child: Container(
        child: Center(
          child: Column(
            children: [
              Text('test ping'),
              // Text('test ping'),
            ],
          ),
        ),
      ),
    );
  }
}
