class NewsBean {
  String returnCode;
  String returnMsg;
  ReturnData returnData;

  NewsBean({this.returnCode, this.returnMsg, this.returnData});

  NewsBean.fromJson(Map<String, dynamic> json) {
    returnCode = json['returnCode'];
    returnMsg = json['returnMsg'];
    returnData = json['returnData'] != null
        ? new ReturnData.fromJson(json['returnData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['returnCode'] = this.returnCode;
    data['returnMsg'] = this.returnMsg;
    if (this.returnData != null) {
      data['returnData'] = this.returnData.toJson();
    }
    return data;
  }
}

class ReturnData {
  List<Records> records;
  int total;
  int size;
  int current;
  bool searchCount;
  int pages;

  ReturnData(
      {this.records,
      this.total,
      this.size,
      this.current,
      this.searchCount,
      this.pages});

  ReturnData.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = new List<Records>();
      json['records'].forEach((v) {
        records.add(new Records.fromJson(v));
      });
    }
    total = json['total'];
    size = json['size'];
    current = json['current'];
    searchCount = json['searchCount'];
    pages = json['pages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    data['size'] = this.size;
    data['current'] = this.current;
    data['searchCount'] = this.searchCount;
    data['pages'] = this.pages;
    return data;
  }
}

class Records {
  String title;
  Null text;
  String author;
  int channel;
  String coverImages;
  Null tag;
  Null viewTimes;
  Null searchTimes;
  String createTime;
  Null updateTime;
  String newsId;

  Records(
      {this.title,
      this.text,
      this.author,
      this.channel,
      this.coverImages,
      this.tag,
      this.viewTimes,
      this.searchTimes,
      this.createTime,
      this.updateTime,
      this.newsId});

  Records.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    text = json['text'];
    author = json['author'];
    channel = json['channel'];
    coverImages = json['coverImages'];
    tag = json['tag'];
    viewTimes = json['viewTimes'];
    searchTimes = json['searchTimes'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    newsId = json['newsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['text'] = this.text;
    data['author'] = this.author;
    data['channel'] = this.channel;
    data['coverImages'] = this.coverImages;
    data['tag'] = this.tag;
    data['viewTimes'] = this.viewTimes;
    data['searchTimes'] = this.searchTimes;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['newsId'] = this.newsId;
    return data;
  }
}
