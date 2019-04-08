import 'package:flutter/material.dart';
import 'package:hammer_chat/assets/icons.dart';

class NewsTabsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsTabsPageState();
  }
}

class NewsTabsPageState extends State<NewsTabsPage> {
  List<String> _userTabs;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("频道管理",style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 18,
            height: 18,
            child:
                Image(image: AssetImage(standard_back_normal)),
          ),
        ),
      ),
      body: Container(),
    );
  }
}

const List<String> allTabs = <String>[
  "军事",
  "美食",
  "科技",
  "数码",
  "汽车",
  "互联网",
  "股票",
  "房产",
  "娱乐",
  "体育",
  "美文",
  "科学探索",
  "星座",
  "财经",
  "游戏",
  "养生",
  "国际",
  "时尚",
  "图片",
  "旅游",
  "电影",
  "视频"
];
