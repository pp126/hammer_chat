import 'package:flutter/material.dart';
import 'package:hammer_chat/assets/colors.dart';
import 'package:hammer_chat/news/news_tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NewsPageState();
  }
}

class NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;
  List<String> _userTabs = List<String>();

  Future<List<String>> _loadUserTabs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userTabs = prefs.getStringList("news_tabs");
    if (_userTabs == null) {
      _userTabs = List<String>();
    }
    if (_userTabs.length < 1) {
      _userTabs.addAll(allTabs.sublist(0, 8));
      prefs.setStringList("news_tabs", _userTabs);
//      _userTabs.insert(0, "推荐");
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _userTabs.length);
    _loadUserTabs().then((listValue) {
      setState(() {
        _controller = TabController(vsync: this, length: _userTabs.length);
        _userTabs;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          _tab(),
          Divider(
            color: Colors.grey,
          ),
          Expanded(child: _content()),
        ],
      ),
    );
  }

  Widget _tab() {
    List<Tab> tabs = _userTabs.map((String title) {
      return Tab(
        text: title,
      );
    }).toList();
    tabs.add(Tab(
      text: "       ",
    ));

    return Stack(
      children: <Widget>[
        TabBar(
          controller: _controller,
          isScrollable: true,
          labelPadding: EdgeInsets.only(left: 13, right: 13),
          unselectedLabelColor: Colors.black87,
          labelColor: Colors.blue,
          indicator: BoxDecoration(),
          tabs: tabs,
        ),
        Center(
          child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: <Color>[
                  white55,
                  whiteff,
                  whiteff,
                  whiteff,
                ])),
                child: IconButton(
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) => NewsTabsPage()),
                    );
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ),
                ),
              )),
        ),
      ],
    );
  }

  Widget _content() {
    return TabBarView(
        controller: _controller,
        children: _userTabs.map((String title) {
          return Container();
        }).toList());
  }

  @override
  bool get wantKeepAlive => false;

  @override
  void deactivate() {
    super.deactivate();
    _loadUserTabs();
  }
}
