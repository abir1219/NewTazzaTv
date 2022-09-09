class BreakingNewsModel {
  var message;
  var flag;
  List<BreakingNewsList>? newsList;

  BreakingNewsModel({this.message, this.flag, this.newsList});

  BreakingNewsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    flag = json['flag'];
    if (json['list'] != null) {
      newsList = [];
      json['list'].forEach((v){
        newsList!.add(BreakingNewsList.fromJson(v));
      });
    }
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['message'] = message;
    data['flag'] = flag;
    if(newsList!= null){
      data['list'] = newsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BreakingNewsList {
  var id;
  var title;

  BreakingNewsList({this.id, this.title});

  BreakingNewsList.fromJson(Map<String,dynamic> json){
    id = json['id'];
    title =json['title'];
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data = <String,dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }

}
