class LikedNewsModel {
  var message;
  var flag;
  List<LikedList>? list;

  LikedNewsModel({this.message, this.flag, this.list});

  LikedNewsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    flag = json['flag'];
    if (json['list'] != null) {
      list = <LikedList>[];
      json['list'].forEach((v) {
        list!.add(LikedList.fromJson(v));
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

class LikedList {
  var title;
  var createdOn;
  var bannerImage;

  LikedList({this.title, this.createdOn, this.bannerImage});

  LikedList.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    createdOn = json['created_on'];
    bannerImage = json['banner_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['created_on'] = createdOn;
    data['banner_image'] = bannerImage;
    return data;
  }
}