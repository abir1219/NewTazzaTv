class StateListModel{
  var message;
  var flag;
  List<StateList>? stateList;

  StateListModel({this.message, this.flag, this.stateList});

  StateListModel.fromJson(Map<String,dynamic> json){
    message = json['message'];
    flag = json['flag'];
    if (json['list'] != null) {
      stateList = <StateList>[];
      json['list'].forEach((v) {
        stateList!.add(StateList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (stateList != null) {
      data['list'] = stateList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StateList {
  var name;
  var logo;

  StateList({this.name, this.logo});

  StateList.fromJson(Map<String,dynamic> json){
    json['name'] = name;
    json['logo'] = logo;
  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['logo'] = logo;
    return data;
}
}