class StateModel {
  var message;
  var flag;
  List<StateList>? list;

  StateModel({this.message, this.flag, this.list});

  StateModel.fromJson(Map<String, dynamic> json) {
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
  var name;
  var logo;

  StateList({this.name, this.logo});

  StateList.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['logo'] = logo;
    return data;
  }
}