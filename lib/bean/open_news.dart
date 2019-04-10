class OpenNewsBean {
  List<Data> data;

  OpenNewsBean({this.data});

  OpenNewsBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] =
          this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Null liveInfo;
  String docid;
  String source;
  String title;
  int priority;
  int hasImg;
  String url;
  int commentCount;
  String imgsrc3gtype;
  String stitle;
  String digest;
  String imgsrc;
  String ptime;

  Data(
      {this.liveInfo,
        this.docid,
        this.source,
        this.title,
        this.priority,
        this.hasImg,
        this.url,
        this.commentCount,
        this.imgsrc3gtype,
        this.stitle,
        this.digest,
        this.imgsrc,
        this.ptime});

  Data.fromJson(Map<String, dynamic> json) {
    liveInfo = json['liveInfo'];
    docid = json['docid'];
    source = json['source'];
    title = json['title'];
    priority = json['priority'];
    hasImg = json['hasImg'];
    url = json['url'];
    commentCount = json['commentCount'];
    imgsrc3gtype = json['imgsrc3gtype'];
    stitle = json['stitle'];
    digest = json['digest'];
    imgsrc = json['imgsrc'];
    ptime = json['ptime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['liveInfo'] = this.liveInfo;
    data['docid'] = this.docid;
    data['source'] = this.source;
    data['title'] = this.title;
    data['priority'] = this.priority;
    data['hasImg'] = this.hasImg;
    data['url'] = this.url;
    data['commentCount'] = this.commentCount;
    data['imgsrc3gtype'] = this.imgsrc3gtype;
    data['stitle'] = this.stitle;
    data['digest'] = this.digest;
    data['imgsrc'] = this.imgsrc;
    data['ptime'] = this.ptime;
    return data;
  }
}
