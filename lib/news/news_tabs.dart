import 'package:flutter/material.dart';
import 'package:hammer_chat/assets/icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsTabsPage extends StatefulWidget {
  NewsTabsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NewsTabsPageState();
  }
}

class NewsTabsPageState extends State<NewsTabsPage> {
  List<String> _userTabs = List<String>();
  bool _isDone = false;
  List<String> all;

  ScrollController _userTabsController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadUserTabs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "频道管理",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 18,
            height: 18,
            child: Image(image: AssetImage(standard_back_normal)),
          ),
        ),
      ),
      body: _createBody(),
    );
  }

  Widget _createBody() {
    return Container(
      child: Column(
        children: <Widget>[_part1(), _part2(), _part3(), _part4()],
      ),
    );
  }

  Widget _part1() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(color: Colors.grey[200], width: 1))),
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                "我的频道",
                style: TextStyle(fontSize: 13),
              ),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 60,
                    height: 30,
                    child: OutlineButton(
                      onPressed: () {
                        _saveTabs();
                        setState(() {
                          _isDone = !_isDone;
                        });
                      },
                      child: Text(
                        _isDone ? "完成" : "编辑",
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ),
                  )),
            ),
          ],
        ));
  }

  Widget _part2() {
    return GridView.builder(
        controller: _userTabsController,
        padding: EdgeInsets.all(10),
        itemCount: _userTabs.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 3),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            color: Colors.white,
            child: OutlineButton(
                onPressed: index == 0
                    ? null
                    : () {
                        _tabsAction(index);
                      },
                child: _isDone && index != 0
                    ? Row(
                        children: <Widget>[
                          Icon(
                            Icons.clear,
                            size: 16,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(_userTabs[index])),
                          ),
                        ],
                      )
                    : Text(_userTabs[index])),
          );
        });
  }

  Widget _part3() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(color: Colors.grey[200], width: 1),
              top: BorderSide(color: Colors.grey[200], width: 1))),
      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
      child: Row(
        children: <Widget>[
          Text(
            "更多频道",
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _part4() {
    all = List<String>();
    all.addAll(allTabs);
//    all.remove("推荐");
    for (int i = 0; i < _userTabs.length; i++) {
      all.remove(_userTabs[i]);
    }

    return GridView.builder(
        padding: EdgeInsets.all(10),
        itemCount: all.length,
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 3),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            color: Colors.white,
            child: OutlineButton(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(all[index])),
                  ),
                ],
              ),
              onPressed: () {
                _addTabs(index);
              },
            ),
          );
        });
  }

  void _addTabs(int index) {
    _userTabs.add(all[index]);
    setState(() {
      _userTabs;
    });
  }

  _tabsAction(int index) {
    if (_isDone) {
      _userTabs.removeAt(index);
    } else {}
    setState(() {
      _userTabs;
    });
  }

  void _saveTabs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
//    _userTabs.remove("推荐");
    prefs.setStringList("news_tabs", _userTabs);
  }

  void _loadUserTabs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userTabs = prefs.getStringList("news_tabs");
    if (_userTabs == null) {
      _userTabs = List<String>();
    }

//    _userTabs.insert(0, "推荐");
    setState(() {
      _userTabs;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _saveTabs();
  }
}

const List<String> allTabs = <String>[
  "推荐",
  "房产",
  "股票",
  "互联网",
  "汽车",
  "数码",
  "科技",
  "美食",
  "军事",
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
