import 'package:flutter/material.dart';
import 'package:hammer_chat/assets/colors.dart';

class MyAnimation extends StatefulWidget {
  MyAnimation(this._shortVideo, this.tabChanged);

  ValueChanged<bool> tabChanged;

  bool _shortVideo;

  @override
  State<StatefulWidget> createState() {
    return _AnimationSampleState();
  }
}

class _AnimationSampleState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  Animation<Alignment> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    animation = Tween<Alignment>(
            begin: Alignment.centerLeft, end: Alignment.centerRight)
        .animate(curve)
          ..addListener(() {
            setState(() {
              // the state that has changed here is the animation object’s value
            });
          });
    if (widget._shortVideo) {
      controller.forward();
    }
  }

  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
          color: Colors.blue[600],
          border: Border(),
          borderRadius: BorderRadius.circular(24)),
      width: 180,
      child: Stack(
        children: <Widget>[
          Container(
              child: Row(
            children: <Widget>[
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  controller.reverse();
                  widget.tabChanged(false);
                },
                child: Container(
                  child: Center(
                    child: Text(
                      "视频",
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                ),
              )),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      controller.forward();
                      widget.tabChanged(true);
                    },
                    child: Container(
                      child: Center(
                        child: Text(
                          "小视频",
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ),
                    )),
              ),
            ],
          )),
          Align(
            alignment: animation.value,
            child: Container(
              margin: EdgeInsets.all(2),
              width: 100,
              foregroundDecoration: BoxDecoration(
                  color: kBlue, borderRadius: BorderRadius.circular(24)),
            ),
          ),
        ],
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}
