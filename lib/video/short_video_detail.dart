import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hammer_chat/bean/short_video_bean.dart';
import 'package:video_player/video_player.dart';
import 'package:event_bus/event_bus.dart';

class ShortVideoDetailPage extends StatefulWidget {
  ShortVideoDetailPage(this._videoBean, this.index);

  ShortVideoBean _videoBean;
  int index;

  @override
  State<StatefulWidget> createState() {
//    SystemChrome.setEnabledSystemUIOverlays([]);
    return ShortVideoDetailState();
  }
}

class ShortVideoDetailState extends State<ShortVideoDetailPage> {
  VideoPlayerController _controller;
  PageController pageController;
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
            onPageChanged: (int index) {
              currentPage = index;
            },
            scrollDirection: Axis.vertical,
            controller: pageController,
            itemCount: widget._videoBean.returnData.records.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                  child: Video(
                      widget._videoBean.returnData.records[index].videoUrl,
                      index));
            }),
        GestureDetector(
          child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(50)),
            margin: EdgeInsets.all(30),
            child: Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
          onTap: () {
            print(Navigator.pop(context));
          },
        )
      ],
    );
    return PageView.builder(
        onPageChanged: (int index) {
          currentPage = index;
        },
        scrollDirection: Axis.vertical,
        controller: pageController,
        itemCount: widget._videoBean.returnData.records.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              child: Video(
                  widget._videoBean.returnData.records[index].videoUrl, index));
        });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
    pageController.addListener(() {
      if (pageController.page == currentPage.toDouble()) {
        print("页面切换");
        eventBus.fire(0);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class Video extends StatefulWidget {
  Video(this.url, this.index);

  String url;
  int index;

  @override
  State<StatefulWidget> createState() {
    return VideoState();
  }
}

EventBus eventBus = EventBus();

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
        setState(() {});
      });
    _controller.setLooping(true);
    eventBus.on<int>().listen((event) {
      setState(() {
        _controller.play();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.pause();
    _controller.dispose();
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
  }
}
