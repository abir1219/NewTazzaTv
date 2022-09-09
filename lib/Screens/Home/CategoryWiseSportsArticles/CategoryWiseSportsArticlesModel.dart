class CategoryWiseSportsArticlesModel {
  var message;
  var flag;
  List<CategoryList>? list;

  CategoryWiseSportsArticlesModel({this.message, this.flag, this.list});

  CategoryWiseSportsArticlesModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    flag = json['flag'];
    if (json['list'] != null) {
      list = <CategoryList>[];
      json['list'].forEach((v) {
        list!.add(CategoryList.fromJson(v));
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

class CategoryList {
  var id;
  var title;
  var bannerImage;
  var createdOn;

  CategoryList({this.id, this.title, this.bannerImage, this.createdOn});

  CategoryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    bannerImage = json['banner_image'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['banner_image'] = bannerImage;
    data['created_on'] = createdOn;
    return data;
  }
}