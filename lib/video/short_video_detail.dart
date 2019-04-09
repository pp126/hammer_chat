import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hammer_chat/bean/short_video_bean.dart';
import 'package:video_player/video_player.dart';

class ShortVideoDetailPage extends StatefulWidget {
  ShortVideoDetailPage(this._videoBean, this.index);

  ShortVideoBean _videoBean;
  int index;

  @override
  State<StatefulWidget> createState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ShortVideoDetailState();
  }
}

class ShortVideoDetailState extends State<ShortVideoDetailPage> {
  VideoPlayerController _controller;
  PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        scrollDirection: Axis.vertical,
        controller: pageController,
        itemCount: widget._videoBean.returnData.records.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Video(widget._videoBean.returnData.records[index].videoUrl)
          );
        });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      print(_controller.textureId);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class Video extends StatefulWidget {
  Video(this.url);

  String url;

  @override
  State<StatefulWidget> createState() {
    return VideoState();
  }
}

class VideoState extends State<Video> {
  VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return VideoPlayer(_controller);
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
        });
      });
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause();
    _controller.dispose();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }

}
