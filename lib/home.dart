import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hammer_chat/assets/icons.dart';
import 'package:hammer_chat/chat.dart';
import 'package:hammer_chat/discovery.dart';
import 'package:hammer_chat/money.dart';
import 'package:hammer_chat/news/news.dart';
import 'package:hammer_chat/user_center.dart';
import 'package:hammer_chat/video/anim.dart';
import 'package:hammer_chat/video/short_video.dart';
import 'package:hammer_chat/video/video.dart';

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
  bool shortVideo = false;

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
        title: _createTitle(),
        centerTitle: true,
        actions: <Widget>[
          PopupMenuButton<String>(
            offset: Offset(0, 100),
            child: Image(
                width: 46,
                height: 46,
                fit: BoxFit.contain,
                image: AssetImage("images/standard_more_normal.png")),
            itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                    child: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage(titlebar_menu_icon_addfriend),
                          size: 18,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "添加好友/群",
                              style: TextStyle(fontSize: 13),
                            )),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    child: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage(titlebar_menu_icon_group),
                          size: 18,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "创建群聊",
                              style: TextStyle(fontSize: 13),
                            )),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    child: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage(titlebar_menu_icon_flicking),
                          size: 18,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "扫二维码",
                              style: TextStyle(fontSize: 13),
                            )),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    child: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage(titlebar_menu_icon_paycode),
                          size: 18,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "扫码支付",
                              style: TextStyle(fontSize: 13),
                            )),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    child: Row(
                      children: <Widget>[
                        ImageIcon(
                          AssetImage(titlebar_menu_icon_personal),
                          size: 18,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(
                              "通讯录",
                              style: TextStyle(fontSize: 13),
                            )),
                      ],
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
                icon: icn_me_normal, text: '我的', iconselet: icn_me_active),
          ],
        ));
  }

  Widget _pages() {
    return TabBarView(
        dragStartBehavior: DragStartBehavior.start,
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: <Widget>[
          ChatPage(),
          DiscoveryPage(),
          NewsPage(),
          shortVideo ? ShortVideoPage() : VideoPage(),
          UserCenterPage()
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
        return MyAnimation(shortVideo, _videoTabChanged);
        break;
      case 4:
        title = "我的";
        break;
    }
    return Text(
      title,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    );
  }

  _videoTabChanged(bool changed) {
    setState(() {
      shortVideo = changed;
    });
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
