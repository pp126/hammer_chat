import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:hammer_chat/bean/video_bean.dart';
import 'package:video_player/video_player.dart';

const String url =
    "http://192.168.0.199:8080/api/v1/video?current=1&size=15&channel=";

class VideoListPage extends StatefulWidget {
//  1推荐、2娱乐、3体育、4汽车、5股票、6星座、7养生、8图片、9美食、10房产、11游戏、12财经
  int channel = 1;
  String videoUrl;

  VideoListPage(String title) {
    switch (title) {
      case "推荐":
        channel = 1;
        break;
      case "娱乐":
        channel = 2;
        break;
      case "体育":
        channel = 3;
        break;
      case "汽车":
        channel = 4;
        break;
      case "股票":
        channel = 5;
        break;
      case "星座":
        channel = 6;
        break;
      case "养生":
        channel = 7;
        break;
      case "图片":
        channel = 8;
        break;
      case "美食":
        channel = 9;
        break;
      case "房产":
        channel = 10;
        break;
      case "游戏":
        channel = 11;
        break;
      case "财经":
        channel = 12;
        break;
    }
    videoUrl = url + channel.toString();
  }

  @override
  State<StatefulWidget> createState() {
    return VideoListPageState();
  }
}

EventBus eventBus = EventBus();

class VideoListPageState extends State<VideoListPage> {
  VideoBean _videoBean;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _videoBean == null ||
                _videoBean.returnData == null ||
                _videoBean.returnData.records == null
            ? 0
            : _videoBean.returnData.records.length,
        itemBuilder: _VideoItem);
  }

  Widget _VideoItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        eventBus.fire(index);
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10),
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.grey[200], width: 1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              width: 500,
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  border: Border.all(color: Colors.grey[200], width: 1)),
              child: Stack(
                children: <Widget>[
//                Image.network(
//                  _videoBean.returnData.records[index].videoCoverUrl,
//                  height: 200,
//                  width: 500,
//                  fit: BoxFit.cover,
//                )
                  Align(
                    alignment: Alignment.center,
                    child: Video(
                        _videoBean.returnData.records[index].videoUrl, index),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                _videoBean.returnData.records[index].title,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15, top: 5),
              child: Text(
                _videoBean.returnData.records[index].createBy,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadVideo() async {
    Response response;
    Dio dio = new Dio();
    response = await dio.get(widget.videoUrl);
    Map<String, dynamic> json = jsonDecode(response.toString());
    print(json);
    setState(() {
      _videoBean = VideoBean.fromJson(json);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }
}

class Video extends StatefulWidget {
  Video(this.url, this.index);

  String url;
  int index;

  @override
  State<StatefulWidget> createState() {
    return VideoState();
  }
}

class VideoState extends State<Video> {
  VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );

    return VideoPlayer(_controller);
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.setLooping(true);
    eventBus.on<int>().listen((event) {
      if (event == widget.index) {
        setState(() {
          _controller.play();
        });
      } else {
        _controller.pause();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause();
    _controller.dispose();
  }
}
