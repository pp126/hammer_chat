import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

class NewsDetailPage extends StatefulWidget {
  NewsDetailPage(this.url);

  String url;

  @override
  State<StatefulWidget> createState() {
    return NewsDetailPageState();
  }
}

class NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                print("share");
                Share.share(widget.url);
              },
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: WebView(
            onWebViewCreated: (WebViewController controller) {
              controller.loadUrl(widget.url);
            },
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ));
  }
}
