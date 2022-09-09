class VideoNewsModel {
  var message;
  var flag;
  List<VideoList>? list;

  VideoNewsModel({this.message, this.flag, this.list});

  VideoNewsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    flag = json['flag'];
    if (json['list'] != null) {
      list = <VideoList>[];
      json['list'].forEach((v) {
        list!.add(VideoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['flag'] = flag;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoList {
  var title;
  var link;
  var position;

  VideoList({this.title, this.link, this.position});

  VideoList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    link = json['link'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['link'] = link;
    data['position'] = position;
    return data;
  }
}