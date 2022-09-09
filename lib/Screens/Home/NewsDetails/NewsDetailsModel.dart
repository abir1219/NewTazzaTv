class NewsDetailsModel {
  var message;
  var flag;
  List<NewsList>? list;

  NewsDetailsModel({this.message, this.flag, this.list});

  NewsDetailsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    flag = json['flag'];
    if (json['list'] != null) {
      list = <NewsList>[];
      json['list'].forEach((v) {
        list!.add(NewsList.fromJson(v));
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

class NewsList {
  int? id;
  var title;
  var shortDesc;
  var description;
  var bannerImage;
  var createdOn;
  var tags;

  NewsList(
      {this.id,
        this.title,
        this.shortDesc,
        this.description,
        this.bannerImage,
        this.createdOn,
        this.tags});

  NewsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDesc = json['short_desc'];
    description = json['description'];
    bannerImage = json['banner_image'];
    createdOn = json['created_on'];
    tags = json['tags'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['short_desc'] = shortDesc;
    data['description'] = description;
    data['banner_image'] = bannerImage;
    data['created_on'] = createdOn;
    data['tags'] = tags;
    return data;
  }
}