import 'package:flutter/material.dart';
import 'package:hammer_chat/video/short_video_list.dart';

class ShortVideoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ShortVideoPageState();
  }
}

class ShortVideoPageState extends State<ShortVideoPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ShortVideoListPage();
  }

  @override
  bool get wantKeepAlive => true;
}
