class SecondSportsNewsModel {
  var message;
  var flag;
  List<NewsList>? list;

  SecondSportsNewsModel({this.message, this.flag, this.list});

  SecondSportsNewsModel.fromJson(Map<String, dynamic> json) {
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
  var id;
  var title;
  var image;
  var createdOn;

  NewsList({this.id, this.title, this.image, this.createdOn});

  NewsList.fromJson(Map<String, dynamic> json) {
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