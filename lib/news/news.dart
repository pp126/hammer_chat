import 'package:flutter/material.dart';
import 'package:hammer_chat/assets/colors.dart';
import 'package:hammer_chat/news/news_tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewsPageState();
  }
}

class NewsPageState extends State<NewsPage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _controller;
  List<String> _userTabs = List<String>();

  Future<Null> _loadUserTabs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userTabs = prefs.getStringList("tabs");
    if (_userTabs == null) {
      _userTabs = List<String>();
    }
    if (_userTabs.length < 1) {
      _userTabs.addAll(allTabs.sublist(0, 8));
      prefs.setStringList("news_tabs", _userTabs);
    }

    _userTabs.insert(0, "推荐");
    setState(() {
      _controller = TabController(vsync: this, length: _userTabs.length);
      _userTabs;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: _userTabs.length);
    _loadUserTabs();
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
          )
        ],
      ),
    );
  }

  Widget _tab() {
    return Stack(
      children: <Widget>[
        TabBar(
          controller: _controller,
          isScrollable: true,
          labelPadding: EdgeInsets.only(left: 13, right: 13),
          unselectedLabelColor: Colors.black87,
          labelColor: Colors.blue,
          indicator: BoxDecoration(),
          tabs: _userTabs.map((String title) {
            return Tab(
              text: title,
            );
          }).toList(),
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

  @override
  bool get wantKeepAlive => true;
}
