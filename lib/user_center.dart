import 'package:flutter/material.dart';
import 'package:hammer_chat/widgets/normal_item.dart';
import 'package:hammer_chat/widgets/with_item.dart';

class UserCenterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserCenterPageState();
  }
}

class UserCenterPageState extends State<UserCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            width: 18,
            height: 18,
            child:
                Image(image: AssetImage("images/standard_back_normal.png")),
          ),
        ),
        centerTitle: true,
        title: Text("个人中心"),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            elevation: 0.3,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: WithItemWidget(
              title: "pp",
              subTitle: "聊天宝账号：lllll",
              img: "images/user_center/default_avatar.png",
              imgRight: "images/user_center/qr_code_normal.png",
            ),
          ),
          Card(
            elevation: 0.3,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: WithItemWidget(
              title: "通讯录",
              subTitle: "2位联系人",
              img: "images/user_center/icon_address_book.png",
            ),
          ),
          Card(
            elevation: 0.3,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: NormalItemWidget(
                "熟人圈个人主页", "images/user_center/icon_moments_profile.png"),
          ),

          Card(
            elevation: 0.3,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: <Widget>[
                NormalItemWidget(
                    "我的收藏", "images/user_center/icon_personal_favorite.png"),
                Divider(height: 0,color: Colors.grey[200],),
                NormalItemWidget(
                    "最近的文件", "images/user_center/group_list_icon_file.png"),
                Divider(height: 0,color: Colors.grey[200],),
                NormalItemWidget(
                    "稍后处理", "images/user_center/icon_todo.png"),
                Divider(height: 0,color: Colors.grey[200],),
                NormalItemWidget(
                    "红包记录", "images/user_center/icon_money.png"),
              ],
            ),
          ),

          Card(
            elevation: 0.3,
            margin: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: <Widget>[
                NormalItemWidget(
                    "账号", "images/user_center/icon_account_security.png"),
                Divider(height: 0,color: Colors.grey[200],),
                NormalItemWidget(
                    "通知管理", "images/user_center/icon_notification.png"),
                Divider(height: 0,color: Colors.grey[200],),
                NormalItemWidget(
                    "聊天管理", "images/user_center/icon_chatting.png"),
                Divider(height: 0,color: Colors.grey[200],),
                NormalItemWidget(
                    "其他设置", "images/user_center/icon_setting.png"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
