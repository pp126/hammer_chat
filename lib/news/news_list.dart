import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hammer_chat/bean/news_bean.dart';
import 'package:dio/dio.dart';

class NewsListPage extends StatefulWidget {
  int channel = 1;
  String baseUrl =
      "http://192.168.0.199:8080/api/v1/news?current=1&size=15&channel=";
  String url;

  NewsListPage(String title) {
//    频道，1推荐、2娱乐、3体育、4汽车、5股票、6星座、7养生、8图片、9美食、10房产、11游戏、12财经
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
    url = baseUrl + channel.toString();
  }

  @override
  State<StatefulWidget> createState() {
    return NewsListPageState();
  }
}

class NewsListPageState extends State<NewsListPage> with  AutomaticKeepAliveClientMixin {
  NewsBean newsBean;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListView.builder(
            itemCount: newsBean == null ||
                    newsBean.returnData == null ||
                    newsBean.returnData.records == null
                ? 0
                : newsBean.returnData.records.length,
            itemBuilder: _itemNews),
      ),
    );
  }

  Widget _itemNews(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.grey[200], width: 1))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 12),
              child: Text(
                newsBean.returnData.records[index].title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              child: Image.network(
                newsBean.returnData.records[index].coverImages,
                fit: BoxFit.cover,
                height: 180,
                width: 500,
              ),
              padding: EdgeInsets.all(20),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 12),
                  child: Text(
                    newsBean.returnData.records[index].createTime,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      newsBean.returnData.records[index].author,
                      style: TextStyle(fontSize: 10),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  _loadNews() async {
    Response response;
    Dio dio = new Dio();
    print(widget.url);
    response = await dio.get(widget.url);
    Map<String, dynamic> json = jsonDecode(response.toString());
    setState(() {
      newsBean = NewsBean.fromJson(json);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  @override
  bool get wantKeepAlive => true;
}
