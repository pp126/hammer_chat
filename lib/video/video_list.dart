import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hammer_chat/bean/video_bean.dart';

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
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey[200], width: 1))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10,right: 10),
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[200], width: 1)),
            child: Image.network(
                _videoBean.returnData.records[index].videoCoverUrl,height: 200,width: 500,fit: BoxFit.cover,),
          ),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(
              _videoBean.returnData.records[index].title,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 15,top: 5),
            child: Text(
              _videoBean.returnData.records[index].createBy,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
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
