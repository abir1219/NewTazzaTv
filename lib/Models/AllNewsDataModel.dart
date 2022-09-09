class AllNewsDataModel {
  var status;
  List<ArticleList>? articleList;

  AllNewsDataModel({
    this.status,
    this.articleList,
  });

  AllNewsDataModel.fromJson(Map<String, dynamic> json) {
    print("STATUS : ${json['status']}");

    status = json['status'];
    if (json['articles'] != null) {
      //articleList = json['articles'];
      //print("articles : ${articleList.toString()}");
      articleList = <ArticleList>[];
      json['articles'].forEach((v) {
        articleList!.add(ArticleList.fromJson(v));
      });

    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    if (articleList != null) {
      data['articles'] = articleList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ArticleList {
  var title;
  var description;
  var urlToImage;

  ArticleList({this.title, this.description, this.urlToImage});

  ArticleList.fromJson(Map<dynamic, dynamic> json) {
    title = json['title'];
    description = json['description'];
    urlToImage = json['urlToImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['urlToImage'] = urlToImage;

    return data;
  }
}
