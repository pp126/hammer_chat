import 'package:flutter/material.dart';
import 'package:hammer_chat/chat.dart';
import 'package:hammer_chat/discovery.dart';
import 'package:hammer_chat/money.dart';
import 'package:hammer_chat/news.dart';
import 'package:hammer_chat/user_center.dart';
import 'package:hammer_chat/video.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 5);
    _controller.addListener(() {
      if (_controller.indexIsChanging) {
        setState(() {
          index = _controller.index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => UserCenterPage()),
            );
          },
          child: Container(
            padding: EdgeInsets.all(4),
            width: 18,
            height: 18,
            child: Image(
                fit: BoxFit.cover,
                image:
                    AssetImage("images/standard_personal_center_normal.png")),
          ),
        ),
        title: _createTitle(),
        centerTitle: true,
        actions: <Widget>[
          Image(
              width: 36,
              height: 36,
              fit: BoxFit.contain,
              image: AssetImage("images/reward_progress_bar.png")),
          PopupMenuButton<String>(
            offset: Offset(0, 100),
            child: Image(
                width: 46,
                height: 46,
                fit: BoxFit.contain,
                image: AssetImage("images/standard_more_normal.png")),
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on),
                          Text("添加好友/群")
                        ],
                      ),
                    ),
                  ),
                  PopupMenuItem<String>(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on),
                          Text("创建群聊")
                        ],
                      ),
                    ),
                  ),

                  PopupMenuItem<String>(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on),
                          Text("添加好友")
                        ],
                      ),
                    ),
                  ),
                ],
          ),
        ],
      ),
      bottomNavigationBar: _navigation(),
      body: _pages(),
    );
  }

  Widget _navigation() {
    return Container(
        decoration: BoxDecoration(
            color: Colors.blueGrey[50],
            border: Border(top: BorderSide(width: 0.3, color: Colors.blue))),
        child: TabBar(
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.blue,
          labelPadding: EdgeInsets.all(0),
          controller: _controller,
          indicator: BoxDecoration(),
          isScrollable: false,
          tabs: <_Tab>[
            _Tab(index == 0,
                icon: "images/icn_chat_normal.png",
                text: '聊天',
                iconselet: "images/icn_chat_active.png"),
            _Tab(index == 1,
                icon: "images/icn_discover_normal.png",
                text: '探索',
                iconselet: "images/icn_discover_active.png"),
            _Tab(index == 2,
                icon: "images/icn_news_normal.png",
                text: '新闻',
                iconselet: "images/icn_news_active.png"),
            _Tab(index == 3,
                icon: "images/icn_video_normal.png",
                text: '视频',
                iconselet: "images/icn_video_active.png"),
            _Tab(index == 4,
                icon: "images/icn_money_normal.png",
                text: '领钱',
                iconselet: "images/icn_money_active.png"),
          ],
        ));
  }

  Widget _pages() {
    return TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          ChatPage(),
          DiscoveryPage(),
          NewsPage(),
          VideoPage(),
          MoneyPage()
        ]);
  }

  bool video = false;

  Widget _createTitle() {
    String title;
    switch (index) {
      case 0:
        title = "聊天";
        break;
      case 1:
        title = "探索";
        break;
      case 2:
        title = "新闻";
        break;
      case 3:
        title = "视频";
        break;
      case 4:
        title = "领钱";
        break;
    }
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }
}

class _Tab extends StatelessWidget {
  _Tab(this.select, {this.icon, this.text, this.iconselet});

  String icon;
  String iconselet;
  String text;
  bool select;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 52,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
                width: 24,
                height: 24,
                image: AssetImage(select ? iconselet : icon)),
            Text(
              text,
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(color: Colors.blue),
        ),
        Image(
            width: 24,
            height: 24,
            image: AssetImage(select ? iconselet : icon)),
      ],
    );
    return Tab(
      text: text,
      icon: Container(
        width: 20,
        height: 20,
        child: Image(image: AssetImage(select ? iconselet : icon)),
      ),
    );
  }
}

//const List<_Tab> _allPages = <_Tab>[
//  _Tab(
//      icon: "images/icn_chat_normal.png",
//      text: '聊天',
//      iconselet: "images/icn_chat_active.png"),
//  _Tab(
//      icon: "images/icn_discover_normal.png",
//      text: '探索',
//      iconselet: "images/icn_discover_active.png"),
//  _Tab(
//      icon: "images/icn_news_normal.png",
//      text: '新闻',
//      iconselet: "images/icn_active_active.png"),
//  _Tab(
//      icon: "images/icn_video_normal.png",
//      text: '视频',
//      iconselet: "images/icn_video_active.png"),
//  _Tab(
//      icon: "images/icn_money_normal.png",
//      text: '领钱',
//      iconselet: "images/icn_money_active.png"),
//];
