import 'package:flutter/material.dart';
import 'package:hammer_chat/widgets/normal_item.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DiscoveryPageState();
  }
}

class DiscoveryPageState extends State<DiscoveryPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[50],
      child: ListView(
        children: <Widget>[
          Card(
            elevation: 0.3,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: <Widget>[
                NormalItemWidget(
                    "熟人圈", "images/discovery/icon_explore_moment.png",small: true,),
                Divider(
                  height: 0,
                  color: Colors.grey[200],
                ),
                NormalItemWidget(
                    "话题广场", "images/discovery/icon_explore_topic.png",small: true),
                Divider(
                  height: 0,
                  color: Colors.grey[200],
                ),
                NormalItemWidget(
                    "附近", "images/discovery/icon_nearby_discovery.png",small: true),
              ],
            ),
          ),
          Card(
            elevation: 0.3,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: NormalItemWidget(
                "好东西", "images/discovery/icon_explore_shop.png",small: true),
          ),
          Card(
            elevation: 0.3,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: <Widget>[
                NormalItemWidget(
                    "摇钱树（测试版）", "images/discovery/icon_explore_tree.png",small: true),
                Divider(
                  height: 0,
                  color: Colors.grey[200],
                ),
                NormalItemWidget(
                    "小游戏", "images/discovery/icon_explore_game.png",small: true),
                Divider(
                  height: 0,
                  color: Colors.grey[200],
                ),
                NormalItemWidget("小说", "images/discovery/icon_novel_color.png",small: true),
              ],
            ),
          ),
          Card(
            elevation: 0.3,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: NormalItemWidget(
                "锤子阅读", "images/discovery/icon_reader_discover.png",small: true),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
