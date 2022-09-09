class BelowNationalNewsModel {
  var message;
  var flag;
  List<NationalNewsList>? list;

  BelowNationalNewsModel({this.message, this.flag, this.list});

  BelowNationalNewsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    flag = json['flag'];
    if (json['list'] != null) {
      list = <NationalNewsList>[];
      json['list'].forEach((v) {
        list!.add(NationalNewsList.fromJson(v));
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

class NationalNewsList {
  var id;
  var title;
  var image;
  var createdOn;

  NationalNewsList({this.id, this.title, this.image, this.createdOn});

  NationalNewsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['created_on'] = createdOn;
    return data;
  }
}