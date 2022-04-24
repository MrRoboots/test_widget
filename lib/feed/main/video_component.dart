import 'package:test_stream/feed/meta_consumer.dart';
import 'package:test_stream/feed/video_play_model.dart';

import 'video_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VideoComponent extends StatelessWidget {
  final int index;
  final dynamic data;

  VideoComponent(this.index, this.data);

  @override
  Widget build(BuildContext context) {
    return MetaConsumer(
        index: index,
        data: data,
        builder: (BuildContext context, VideoPlayModel model, Widget child) {
          var play = model.playIndex == index;
          return Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            padding: EdgeInsets.zero,
            child: VideoView(data, play),
            color: play ? Colors.redAccent : Colors.grey[100] ?? Colors.grey,
          );
        });
  }
}
