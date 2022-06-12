/*
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:f_downloader/f_downloader.dart';
import 'package:f_downloader/models.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const debug = true;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _TaskInfo {
  final String name;
  final String url;

  String speed = "无数据";
  double progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  _TaskInfo({this.name, this.url});
}

class _MyHomePageState extends State<MyHomePage> {
  final ReceivePort _port = ReceivePort();
  final List<_TaskInfo> _tasks = [];
  bool _permissionReady;
  String _localPath;

  // String movieUrl =
  //     'https://m3u8.taopianplay.com/taopian/84e2601a-c8ef-41e9-815a-453247f2e518/a0ba49ba-87b8-41b4-8ad3-50b8fc26ffd8/44724/4a509829-23ee-44af-bebf-66acf24b15ad/SD/playlist.m3u8';

  String imgUrl = "https://t7.baidu.com/it/u=1819248061,230866778&fm=193&f=GIF";
  String movieUrl = 'https://europe.olemovienews.com/hlstimeofffmp4/20210226/fICqcpqr/mp4/fICqcpqr.mp4/master.m3u8';

  @override
  void initState() {
    _init();
    _permissionReady = false;
    _bindBackgroundIsolate();
    FDownloader.registerCallback(downloadCallback);
    // _data();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      addData();
    });
    super.initState();
  }

  _init() async {
    await FDownloader.init();
  }

  addData() {
    _tasks.add(_TaskInfo(name: '电影1', url: movieUrl));
    _tasks.add(_TaskInfo(
        name: '电影2',
        url:
            'https://www.taopianplay.com/taopian/84e2601a-c8ef-41e9-815a-453247f2e518/a0ba49ba-87b8-41b4-8ad3-50b8fc26ffd8/33558/3c2ce4dc-4924-4f33-b3ff-becbca19e294/SD/playlist.m3u8'));
    _tasks.add(_TaskInfo(
        name: '电影3',
        url:
            'https://www.taopianplay.com/taopian/84e2601a-c8ef-41e9-815a-453247f2e518/09e075a8-2f53-49d9-bb94-aae2cd0e1c73/12987/429744f8-3782-467d-8891-c096c071559d/SD/playlist.m3u8'));
    // _tasks.add(_TaskInfo(
    //     name: '电影4 mp4', url: 'https://testc.hzsy66.cn/upload/20220308/0b5a34c9dd56a29b258a89735d670da7.mp4'));

        _tasks.add(_TaskInfo(
        name: '电影4 mp4', url: 'http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4'));
    setState(() {});
  }

  _data() async {
    List<DownloadTask> list = await FDownloader.loadTasks();
    if (_tasks != null) {
      _tasks.clear();
    }
    for (int i = 0; i < list.length; i++) {
      var taskInfo = _TaskInfo(name: list[i].title, url: list[i].url);
      taskInfo.status = list[i].status;
      taskInfo.speed = list[i].speed;
      taskInfo.progress = list[i].percent;
      _tasks.add(taskInfo);
    }
    setState(() {});
    print('_data: ${_tasks.length}');
  }

  permission() async {
    _permissionReady = await _checkPermission();
    if (_permissionReady) {
      await _prepareSaveDir();
    }
  }

  Future<void> _prepareSaveDir() async {
*/
/*    _localPath = (await _findLocalPath())!;
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }*//*

  }

  Future<bool> _checkPermission() async {
    if (Platform.isIOS) return true;
    final platform = Theme.of(context).platform;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if (platform == TargetPlatform.android && androidInfo.version.sdkInt <= 28) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  static void downloadCallback(String url, DownloadTaskStatus status, double progress, String speed) {
    print('Background Isolate Callback: task ($url) is in status ($status) and process ($progress)  speed ($speed)');
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([url, status, progress, speed]);
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    print('_bindBackgroundIsolate: isSuccess = $isSuccess');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      print('UI Isolate Callback: $data');
      String url = data[0];
      DownloadTaskStatus status = data[1];
      double progress = data[2];
      String speed = data[3];

      if (_tasks != null && _tasks.isNotEmpty) {
        final task = _tasks.firstWhere((task) => task.url == url);
        setState(() {
          task.status = status;
          task.progress = progress;
          task.speed = speed;
        });
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    FDownloader.enqueue(movieUrl, imgUrl, '我的电影');
                  },
                  child: const Text('下载')),
              TextButton(
                  onPressed: () {
                    FDownloader.pause(movieUrl);
                  },
                  child: const Text('暂停')),
              TextButton(
                  onPressed: () {
                    FDownloader.resume(movieUrl);
                  },
                  child: const Text('继续下载')),
              TextButton(
                  onPressed: () async {
                    List<DownloadTask> list = await FDownloader.loadTasks();
                    for (var element in list) {
                      print(element.toString());
                    }
                  },
                  child: const Text('加载全部')),
              TextButton(
                  onPressed: () async {
                    _data();
                  },
                  child: const Text('刷新')),
            ],
          ),
          Expanded(child: _buildList()),
        ],
      ),
    );
  }

  Widget _buildList() => Container(
        child: ListView(
            children: _tasks != null
                ? _tasks
                    .map((e) => e.url == ''
                        ? null
                        : DownloadItem(
                            data: e,
                            onItemClick: (task) {},
                            onActionClick: (task) {
                              if (task.status == DownloadTaskStatus.undefined) {
                                FDownloader.enqueue(e.url, imgUrl, e.name);
                              } else if (task.status == DownloadTaskStatus.pause ||
                                  task.status == DownloadTaskStatus.error) {
                                FDownloader.resume(e.url);
                              } else if (task.status == DownloadTaskStatus.downloading) {
                                FDownloader.pause(e.url);
                              } else if (task.status == DownloadTaskStatus.success) {
                                FDownloader.delete(e.url);
                                _tasks.remove(e);
                                setState(() {});
                              }
                            },
                          ))
                    .toList()
                : []),
      );
}

class DownloadItem extends StatelessWidget {
  final _TaskInfo data;
  final Function(_TaskInfo) onItemClick;
  final Function(_TaskInfo) onActionClick;

  DownloadItem({this.data, this.onItemClick, this.onActionClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 8.0),
      child: InkWell(
        onTap: data.status == DownloadTaskStatus.success
            ? () {
                onItemClick(data);
              }
            : null,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 64.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Row(
                    children: [
                      Text(
                        data.name ?? '',
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '速度：${data.speed}',
                        maxLines: 1,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: _buildActionForTask(data),
                  ),
                ],
              ),
            ),
            data.status == DownloadTaskStatus.downloading || data.status == DownloadTaskStatus.pause
                ? Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: LinearProgressIndicator(
                      value: data.progress / 100,
                    ),
                  )
                : Container()
          ].toList(),
        ),
      ),
    );
  }

  Widget _buildActionForTask(_TaskInfo task) {
    if (task.status == DownloadTaskStatus.undefined) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick(task);
        },
        child: Icon(Icons.file_download),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.downloading) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick(task);
        },
        child: Icon(
          Icons.pause,
          color: Colors.red,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.pause) {
      return RawMaterialButton(
        onPressed: () {
          onActionClick(task);
        },
        child: Icon(
          Icons.play_arrow,
          color: Colors.green,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.success) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '下载完成',
            style: TextStyle(color: Colors.green),
          ),
          RawMaterialButton(
            onPressed: () {
              onActionClick(task);
            },
            child: Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.error) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('下载失败', style: TextStyle(color: Colors.red)),
          RawMaterialButton(
            onPressed: () {
              onActionClick(task);
            },
            child: Icon(
              Icons.refresh,
              color: Colors.green,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.pending) {
      return Text('解析中', style: TextStyle(color: Colors.orange));
    } else if (task.status == DownloadTaskStatus.prepare) {
      return Text('下载准备中', style: TextStyle(color: Colors.green));
    } else if (task.status == DownloadTaskStatus.start) {
      return Text('开始下载', style: TextStyle(color: Colors.green));
    } else {
      return null;
    }
  }
}
*/
