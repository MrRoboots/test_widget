import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_stream/anim_icon_btn.dart';
import 'package:test_stream/bili_border.dart';

import 'like_btn/like_button.dart';
import 'like_btn/utils/like_button_model.dart';

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
  Stream<String> fileRead;
  StreamController<Stream<String>> streamController =
      StreamController<Stream<String>>.broadcast();
  StreamSubscription<Stream<String>> _subscription1;
  Isolate iso;
  Capability cap;
  bool isLiked = false;

  myPath() async {
    Directory appDocDir = await getExternalStorageDirectory();
    String appDocPath = appDocDir.path;
    print("$appDocPath");
    File file = File(
        "/storage/emulated/0/Android/data/com.example.test_stream/files/doupocangqiong.txt");

    fileRead =
        file.openRead().transform(utf8.decoder).transform(const LineSplitter());
    streamController.add(fileRead);

    /* await for (var str in fileRead) {
      print("$str");
    }*/
    print("==========================================================");
  }

  @override
  void initState() {
    super.initState();

    _subscription1 = streamController.stream.listen((Stream<String> n) {
      n.forEach((element) {
        print("===============>element  $element");
      });
    });

    // myPath();
  }

  loadData() async {
    ReceivePort receivePort = ReceivePort();
    iso = await Isolate.spawn(dataLoader, receivePort.sendPort);

    SendPort sendPort = await receivePort.first;
    ReceivePort response = ReceivePort();
    sendPort.send(["发送的参数", response.sendPort]);

    iso.addErrorListener(response.sendPort);
    iso.addOnExitListener(response.sendPort);
    response.listen((message) {
      print("message ==> $message");
    });
  }

  static dataLoader(SendPort sendPort) async {
    ReceivePort port = ReceivePort();

    ///设置监听端口
    sendPort.send(port.sendPort);

    port.listen((message) async {
      String data = message[0];
      print("参数 data 1 $data");

      SendPort data2 = message[1];
      print("参数 data 1 $data2");

      File file = File(
          "/storage/emulated/0/Android/data/com.example.test_stream/files/book_85701.txt");
      await file
          .openRead(0, 5000)
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .timeout(const Duration(seconds: 2 * 60))
          .forEach((element) {
        print("element $element");
      }).whenComplete(() {
        data2.send("success");
      }).catchError((e) {
        print("e $e");
      });

/*      String str = "";
      await file
          .openRead(0, 5000)
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .forEach((element) {
        str = str + element;
      });*/

/*      List<String> str = [];
      // StringBuffer sb = StringBuffer();
      try {
        str = await file.readAsLines();
        // str.forEach((element) {
        //   sb.write(element);
        // });
      } catch (e) {
        print("$e");
      }

      print("str ============ ${str.toString()}");
      print("str ============ ${str.toString().length}");*/
      data2.send("success");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        iso.resume(cap);
                      },
                      child: Text("resume")),
                  ElevatedButton(
                      onPressed: () {
                        cap = iso.pause();
                      },
                      child: Text("pause")),
                  ElevatedButton(
                      onPressed: () {
                        dioDown();
                      },
                      child: Text("dio down")),
                  ElevatedButton(
                      onPressed: () {
                        SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.immersive,
                            overlays: [
                              SystemUiOverlay.bottom,
                              SystemUiOverlay.top
                            ]);
                      },
                      child: Text("immersive")),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.edgeToEdge,
                            overlays: [
                              SystemUiOverlay.bottom,
                              SystemUiOverlay.top
                            ]);
                      },
                      child: Text("edgeToEdge")),
                  ElevatedButton(
                      onPressed: () {
                        SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.immersiveSticky,
                            overlays: [
                              SystemUiOverlay.bottom,
                              SystemUiOverlay.top
                            ]);
                      },
                      child: Text("immersiveSticky ")),
                  ElevatedButton(
                      onPressed: () {
                        SystemChrome.setEnabledSystemUIMode(
                            SystemUiMode.leanBack,
                            overlays: [
                              SystemUiOverlay.bottom,
                              SystemUiOverlay.top
                            ]);
                      },
                      child: Text("leanBack  ")),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                            overlays: [
                              SystemUiOverlay.bottom,
                              // SystemUiOverlay.top
                            ]);
                      },
                      child: Text("manual   ")),
                ],
              ),
              Container(
                height: 200,
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (notification is ScrollStartNotification) {
                      print("开始滚动.....");
                    } else if (notification is ScrollUpdateNotification) {
                      print("更新开始滚动.....");
                      if (notification.dragDetails != null) {
                        print(
                            "x: ${notification.dragDetails.globalPosition.dx}");
                        print(
                            "y: ${notification.dragDetails.globalPosition.dy}");
                      }
                    } else if (notification is ScrollEndNotification) {
                      print("滚动结束.....");
                    }
                    return false;
                  },
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Container(
                        color: Colors.red,
                        height: 200,
                        width: 200,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 60,
                padding: EdgeInsets.all(10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 0),
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(BiliBorder(
                              type: 1,
                              side: BorderSide(width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(2))),
                          // overlayColor:
                          //     MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text('老老孟老孟'),
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(BiliBorder(
                              type: 2,
                              side: BorderSide(width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(2))),
                          // overlayColor:
                          //     MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text('老老孟老孟'),
                        onPressed: () {},
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: TextButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(BiliBorder(
                              type: 3,
                              side: BorderSide(width: 1, color: Colors.red),
                              borderRadius: BorderRadius.circular(2))),
                          // overlayColor:
                          //     MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Text('老老孟老孟'),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
/*              TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(BiliStartBorder(
                      side: BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(2))),
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  side: MaterialStateProperty.all(BorderSide(color: Colors.red,width: 1))),
                child: Text('老老孟老孟'),
                onPressed: () {},
              )*/

/*              TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(BeveledRectangleBorder(
                      side: BorderSide(width: 1, color: Colors.red),
                      borderRadius: BorderRadius.circular(1))),
                ),
                child: Text('老老孟老孟'),
                onPressed: () {},
              )*/

              /*                AnimIconBtn(
                isSelect: false,
                selectIcon: const Icon(Icons.thumb_up_rounded),
                normalIcon: const Icon(Icons.thumb_up_outlined),
              ),*/

              LikeButton(
                isLiked: isLiked,
                onTap: (bool isLiked) async {
                  isLiked = !isLiked;
                  return isLiked;
                },
                crossAxisAlignment: CrossAxisAlignment.end,
                likeCountPadding: const EdgeInsets.all(0),
                size: 30,
                circleColor: const CircleColor(
                    start: Color(0xff00ddff), end: Color(0xff0099cc)),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Color(0xff33b5e5),
                  dotSecondaryColor: Color(0xff0099cc),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.home,
                    color: isLiked ? Colors.deepPurpleAccent : Colors.grey,
                    size: 30,
                  );
                },
                likeCount: "100万",
                countBuilder: (String count, bool isLiked, String text) {
                  var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                  Widget result;
                  if (count == "0") {
                    result = Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        "0",
                        style: TextStyle(color: color, fontSize: 12),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        text,
                        style: TextStyle(color: color, fontSize: 12),
                      ),
                    );
                  }
                  return result;
                },
              ),

              /*     Stack(
                children: [
                  Positioned(
                      top: 0,
                      left: 10,
                      child: Container(
                        height: 2,
                        width: 10,
                        color: Colors.black,
                      )),
                  Positioned(
                      bottom: 0,
                      left: 10,
                      child: Container(
                        height: 2,
                        width: 10,
                        color: Colors.red,
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 2, right: 2),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(2),
                              topRight: Radius.circular(2),
                              bottomLeft: Radius.circular(2),
                              bottomRight: Radius.circular(0),
                            )),
                        child: Text("VIP",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold)),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 2, right: 2),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(2),
                              bottomLeft: Radius.circular(2),
                              bottomRight: Radius.circular(2),
                            )),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "111",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 8),
                            )
                          ],
                        ),
                      )
                    ],
                  )
                ],
              )*/

              /*             Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 2, right: 2),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(2),
                          topRight: Radius.circular(2),
                          bottomLeft: Radius.circular(2),
                          bottomRight: Radius.circular(0),
                        )),
                    child: Text("VIP",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 2, right: 2),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(2),
                          bottomLeft: Radius.circular(2),
                          bottomRight: Radius.circular(2),
                        )),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "111",
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        )
                      ],
                    ),
                  )
                ],
              )*/
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // print("==================close");
          // await streamController.close();
          // await _subscription1.cancel();

          loadData();
        },
        child: Text("hh"),
      ),
    );
  }

  dioDown() async {
    try {
      /// 发起下载请求
      Response<ResponseBody> response = await Dio().get<ResponseBody>(
          "https://testc.hzsy66.cn/comic/novel/fanrenxiuxianzhuan/1.txt",
          options: Options(
            responseType: ResponseType.stream,
            followRedirects: false,
          ));

      print("response ==> ${response.data.stream}");

      /*StringBuffer sb = StringBuffer();
      await response.data.stream.forEach((element) {
        print(utf8.decode(element.toList()));
        sb.write(utf8.decode(element.toList()));
      });*/

      // print(sb.toString());

      var st = StreamTransformer<Uint8List, List<int>>.fromHandlers(
          handleData: (Uint8List data, sink) {
        sink.add(data.toList());
      });

/*         var str = response.data.stream
          .transform(st)
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .forEach((element) {
        print(element);
      });*/

      // print(str);

/*      response.data.stream
          .transform(st)
          .transform(utf8.decoder)
          .forEach((element) {
        print(element);
      }).catchError((e) {
        print("e  $e");
      });*/

      try {
        Stream<String> stream = response.data.stream
            .transform(st)
            .transform(utf8.decoder)
            .transform(const LineSplitter());
        List<String> list = await stream.toList();
        for (int i = 0; i < 10; i++) {
          print(list[i]);
        }
      } catch (e) {
        print(e);
      }
    } catch (e) {
      print(e);
    }
  }
}
