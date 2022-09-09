class StateThirdTopNewsModel {
  var message;
  var flag;
  List<StateList>? list;

  StateThirdTopNewsModel({this.message, this.flag, this.list});

  StateThirdTopNewsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    flag = json['flag'];
    if (json['list'] != null) {
      list = <StateList>[];
      json['list'].forEach((v) {
        list!.add(StateList.fromJson(v));
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

class StateList {
  var id;
  var title;
  var image;
  var createdOn;

  StateList({this.id, this.title, this.image, this.createdOn});

  StateList.fromJson(Map<String, dynamic> json) {
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