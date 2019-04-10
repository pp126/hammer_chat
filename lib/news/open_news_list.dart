import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hammer_chat/bean/open_news.dart';
import 'package:hammer_chat/news/news_detail.dart';

class NewsListPage extends StatefulWidget {
  String type;

  String newsUrl;

  NewsListPage(String title) {
//    频道，1推荐、2娱乐、3体育、4汽车、5股票、6星座、7养生、8图片、9美食、10房产、11游戏、12财经
    type = "DE0CGUSJwangning";
    switch (title) {
      case "推荐":
        type = "BD2A86BEwangning";
        break;
      case "娱乐":
        type = "BD2A9LEIwangning";
        break;
      case "体育":
        type = "BD2AB5L9wangning";
        break;
      case "汽车":
        type = "BD2AC4LMwangning";
        break;
      case "股票":
        type = "DE0CGUSJwangning";
        break;
      case "星座":
        break;
      case "养生":
        break;
      case "图片":
        break;
      case "美食":
        break;
      case "房产":
        break;
      case "游戏":
        break;
      case "财经":
        break;
    }

    newsUrl =
        "https://3g.163.com/touch/reconstruct/article/list/${type}/1-20.html";
  }

  @override
  State<StatefulWidget> createState() {
    return NewsListPageState();
  }
}

class NewsListPageState extends State<NewsListPage>
    with AutomaticKeepAliveClientMixin {
  OpenNewsBean newsBean;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListView.builder(
            itemCount: newsBean == null || newsBean.data == null
                ? 0
                : newsBean.data.length,
            itemBuilder: _itemNews),
      ),
    );
  }

  Widget _itemNews(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  NewsDetailPage(newsBean.data[index].url)),
        );
      },
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
                newsBean.data[index].title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              child: Image.network(
                newsBean.data[index].imgsrc,
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
                    newsBean.data[index].ptime,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      newsBean.data[index].source,
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
    response = await dio.get(widget.newsUrl);
    String json =
        response.toString().substring(9, response.toString().length - 1);
    json = json.replaceRange(2, 18, 'data');
    print(json);
    Map<String, dynamic> map = jsonDecode(json);
    setState(() {
      newsBean = OpenNewsBean.fromJson(map);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  @override
  bool get wantKeepAlive => false;
}
