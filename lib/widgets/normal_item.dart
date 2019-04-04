import 'package:flutter/material.dart';

class NormalItemWidget extends StatelessWidget {
  NormalItemWidget(this.title, this.img, {this.small = false, Key key})
      : super(key: key);
  String img;
  String title;
  bool small;

  @override
  Widget build(BuildContext context) {
    double width = 24;
    if (small) {
      width = 18;
    }
    return Container(
      height: 50,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 13, right: 13),
            width: width,
            height: width,
            child: Image(fit: BoxFit.fill, image: AssetImage(img)),
          ),
          Container(
            child: Text(title),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.chevron_right,
              color: Colors.black54,
            ),
          )),
        ],
      ),
    );
  }
}
