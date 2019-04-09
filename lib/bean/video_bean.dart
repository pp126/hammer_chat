class VideoBean {
  String returnCode;
  String returnMsg;
  ReturnData returnData;

  VideoBean({this.returnCode, this.returnMsg, this.returnData});

  VideoBean.fromJson(Map<String, dynamic> json) {
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
  String id;
  String title;
  int channel;
  Null text;
  String videoUrl;
  String videoCoverUrl;
  Null isMinVideo;
  Null browseCount;
  Null commentCount;
  String createBy;
  String createTime;
  Null updateTime;

  Records(
      {this.id,
      this.title,
      this.channel,
      this.text,
      this.videoUrl,
      this.videoCoverUrl,
      this.isMinVideo,
      this.browseCount,
      this.commentCount,
      this.createBy,
      this.createTime,
      this.updateTime});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    channel = json['channel'];
    text = json['text'];
    videoUrl = json['videoUrl'];
    videoCoverUrl = json['videoCoverUrl'];
    isMinVideo = json['isMinVideo'];
    browseCount = json['browseCount'];
    commentCount = json['commentCount'];
    createBy = json['createBy'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['channel'] = this.channel;
    data['text'] = this.text;
    data['videoUrl'] = this.videoUrl;
    data['videoCoverUrl'] = this.videoCoverUrl;
    data['isMinVideo'] = this.isMinVideo;
    data['browseCount'] = this.browseCount;
    data['commentCount'] = this.commentCount;
    data['createBy'] = this.createBy;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
