import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hammer_chat/bean/short_video_bean.dart';
import 'package:hammer_chat/video/short_video_detail.dart';

const String url =
    "http://192.168.0.199:8080/api/v1/video/min?current=1&size=15";

class ShortVideoListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShortVideoListPageState();
  }
}

class ShortVideoListPageState extends State<ShortVideoListPage> {
  ShortVideoBean _videoBean;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: GridView.builder(
            itemCount: _videoBean == null ||
                    _videoBean.returnData == null ||
                    _videoBean.returnData.records == null
                ? 0
                : _videoBean.returnData.records.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemBuilder: _shortVideoItem),
      ),
    );
  }

  Widget _shortVideoItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  ShortVideoDetailPage(_videoBean, index)),
        );
      },
      child: GridTile(
        child: Container(
          margin: EdgeInsets.all(6),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              _videoBean.returnData.records[index].videoCoverUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Color(0xffffff),
          title: Text(_videoBean.returnData.records[index].title),
          subtitle: Text(
            _videoBean.returnData.records[index].browseCount.toString(),
            style: TextStyle(fontSize: 10),
          ),
        ),
      ),
    );
  }

  _loadVideo() async {
    Response response;
    Dio dio = new Dio();
    print(url);
    response = await dio.get(url);
    Map<String, dynamic> json = jsonDecode(response.toString());
    print(json);
    setState(() {
      _videoBean = ShortVideoBean.fromJson(json);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadVideo();
  }
}
