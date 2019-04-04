import 'package:flutter/material.dart';

class WithItemWidget extends StatelessWidget {
  WithItemWidget({this.title, this.img, this.imgRight, this.subTitle});

  String title;
  String subTitle;
  String img;
  String imgRight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 12, right: 12),
            width: 35,
            height: 35,
            child: Image(image: AssetImage(img)),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                ),
                Text(
                  subTitle,
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          ),
          _createImg(),
          Icon(
            Icons.chevron_right,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }

  Widget _createImg() {
    if (imgRight == null) {
      return Container();
    }
    return Expanded(
        child: Align(
      alignment: Alignment.centerRight,
      child: Image(
        width: 20,
        height: 20,
        image: AssetImage(imgRight),
      ),
    ));
  }
}
