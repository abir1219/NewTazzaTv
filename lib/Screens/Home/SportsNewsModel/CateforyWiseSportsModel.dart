class CateforyWiseSportsModel {
  var message;
  var flag;
  List<SportsList>? list;

  CateforyWiseSportsModel({this.message, this.flag, this.list});

  CateforyWiseSportsModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    flag = json['flag'];
    if (json['list'] != null) {
      list = <SportsList>[];
      json['list'].forEach((v) {
        list!.add(SportsList.fromJson(v));
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

class SportsList {
  var id;
  var bannerImage;
  var subCategory;

  SportsList({this.id, this.bannerImage, this.subCategory});

  SportsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bannerImage = json['banner_image'];
    subCategory = json['sub_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['banner_image'] = bannerImage;
    data['sub_category'] = subCategory;
    return data;
  }
}