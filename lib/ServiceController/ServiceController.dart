import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:new_tazza_tv_flutter/Models/AllNewsDataModel.dart';
import 'package:http/http.dart' as http;
import 'package:new_tazza_tv_flutter/Models/MenuModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Category/ViewAllModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/CategoryWiseSportsArticles/CategoryWiseSportsArticlesModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/EntertainmentNewsModel/FourthEntertainmentNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/EntertainmentNewsModel/SecondEntertainmentNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/EntertainmentNewsModel/ThirdEntertainmentNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/EntertainmentNewsModel/TopEntertainmentNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/NationalNews/TopNationalNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/NewsDetails/NewsDetailsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/NewsDetails/RelatedNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/SportsNewsModel/SecondSportsNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/SportsNewsModel/ThirdSportsNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/SportsNewsModel/TopSportsNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/StateModel/StateModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/StateNews/StateTopNews/StateFourthTopNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/StateNews/StateTopNews/StateSecondTopNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/StateNews/StateTopNews/StateThirdTopNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/VideoNewsModel/VideoNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/LikedNews/LikedNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/SavedNews/SavedNewsModel.dart';

import '../Screens/Home/BreakingNewsModel/BreakingNewsModel.dart';
import '../Screens/Home/FourthTopNewsModel/FourthTopNewsModel.dart';
import '../Screens/Home/InternationalNews/TopInternationalNewsModel.dart';
import '../Screens/Home/NationalNews/BelowNationalNewsModel.dart';
import '../Screens/Home/SecondTopNewsModel/SecondTopNewsModel.dart';
import '../Screens/Home/SportsNewsModel/CateforyWiseSportsModel.dart';
import '../Screens/Home/StateListModel/StateListModel.dart';
import '../Screens/Home/StateNews/StateTopNews/StateTopNewsModel.dart';
import '../Screens/Home/ThirdTopNewsModel/ThirdTopNewsModel.dart';
import '../Screens/Home/TopNewsModel/TopNewsModel.dart';
import '../Utils/Urls.dart';


Future<AllNewsDataModel?> getAllNewsData() async {
  AllNewsDataModel? dataModel;
  try {
    final response = await http.get(Uri.parse(Urls.BASE_URL));
    if (response.statusCode == 200) {
      final item = json.decode(response.body);
      print("ITEMS_RES : $item");
      dataModel = AllNewsDataModel.fromJson(item);
    } else {
      print("Getting some troubles");
    }
  } catch (e) {
    print(e.toString());
  }

  return dataModel;
}

Future<List<StateListModel>> showAllStates() async {
  List<StateListModel> stateList = [];
  Map<String, dynamic> body = {
    'type': 'showstate'
  };
  var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    List<dynamic> state = data['list'];
    state.forEach((element) {
      StateListModel model = StateListModel.fromJson(element);
      stateList.add(model);
    });
    return stateList;
  } else {
    return [];
  }
}

Future<BreakingNewsModel?> showBreakingNews() async {
  BreakingNewsModel? model;
  Map<String, dynamic> body = {
    'type': 'showbreaking',
    'lang': 'en'
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("BREAKING_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      model = BreakingNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return model;
}

Future<TopNewsModel?> showTopNews() async {
  TopNewsModel? topNewsModel;
  Map<String, dynamic> body = {
    'type': 'showarticles2',
    'lang': 'en',
    'state': GetStorage().read("state").toString(),
    //GetStorage().read('state'),
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("BREAKING_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      topNewsModel = TopNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return topNewsModel;
}

Future<SecondTopNewsModel?> showSecondTopNews() async {
  print("STORAGE_STATE => ${GetStorage().read('state')}");
  SecondTopNewsModel? secondTopNewsModel;
  Map<String, dynamic> body = {
    'type': 'showarticles3',
    'lang': 'en',
    'state': GetStorage().read("state").toString(),
    //GetStorage().read('state'),
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("BREAKING_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      secondTopNewsModel =
          SecondTopNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return secondTopNewsModel;
}

Future<ThirdTopNewsModel?> showThirdTopNews() async {
  ThirdTopNewsModel? thirdTopNewsModel;
  Map<String, dynamic> body = {
    'type': 'showarticles4',
    'lang': 'en',
    'state': GetStorage().read("state").toString(),
    //GetStorage().read('state'),
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("BREAKING_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      thirdTopNewsModel =
          ThirdTopNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return thirdTopNewsModel;
}

Future<FourthTopNewsModel?> showFourthTopNews() async {
  FourthTopNewsModel? fourthTopNewsModel;
  Map<String, dynamic> body = {
    'type': 'showarticles1',
    'lang': 'en',
    'state': GetStorage().read("state").toString(),
    //GetStorage().read('state'),
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("4_TOp_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      fourthTopNewsModel =
          FourthTopNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return fourthTopNewsModel;
}

Future<StateModel?> showStates() async {
  StateModel? stateModel;
  Map<String, dynamic> body = {
    'type': 'showstate',
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("STATE_RES_MENU => ${response.body}");
    if (response.statusCode == 200) {
      stateModel = StateModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return stateModel;
}

Future<StateTopNewsModel?> showStatesTopNews(String state) async {
  StateTopNewsModel? stateTopNewsModel;
  print("St=>$state");
  Map<String, dynamic> body = {
    'type': 'statewise',
    'state': state,
    'lang': 'en',
    'limit': "1"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("STATE_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      stateTopNewsModel =
          StateTopNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return stateTopNewsModel;
}

Future<StateSecondTopNewsModel?> showStatesSecondTopNews(String state) async {
  StateSecondTopNewsModel? stateSecondTopNewsModel;
  print("St=>$state");
  Map<String, dynamic> body = {
    'type': 'statewise',
    'state': state,
    'lang': 'en',
    'limit': "1,2"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("STATE_2_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      stateSecondTopNewsModel =
          StateSecondTopNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return stateSecondTopNewsModel;
}

Future<StateThirdTopNewsModel?> showStatesThirdTopNews(String state) async {
  StateThirdTopNewsModel? stateThirdTopNewsModel;
  print("St=>$state");
  Map<String, dynamic> body = {
    'type': 'statewise',
    'state': state,
    'lang': 'en',
    'limit': "3,4"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("STATE_3_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      stateThirdTopNewsModel =
          StateThirdTopNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return stateThirdTopNewsModel;
}

Future<StateFourthTopNewsModel?> showStatesFourthTopNews(String state) async {
  StateFourthTopNewsModel? stateFourthTopNewsModel;
  print("St4=>$state");
  Map<String, dynamic> body = {
    'type': 'statewise',
    'state': state,
    'lang': 'en',
    'limit': "7,2"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("STATE_4_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      stateFourthTopNewsModel =
          StateFourthTopNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return stateFourthTopNewsModel;
}

Future<ViewAllModel?> showViewAllNews(String type) async {
  print("TYPE => $type");
  ViewAllModel? viewAllModel;
  Map<String, dynamic> body = {
    'type': 'CategoryWiseNews',
    'lang': 'en',
    'category': type,
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("TYPE => ${response.body}");
    if (response.statusCode == 200) {
      viewAllModel = ViewAllModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return viewAllModel;
}

Future<TopNationalNewsModel?> showTopNatioalNews() async {
  print("NATIONAL");
  TopNationalNewsModel? topNationalNewsModel;
  Map<String, dynamic> body = {
    'type': 'CategoryWiseNews',
    'lang': 'en',
    'category': 'National',
    'limit': "4"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("NATIONAL_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      topNationalNewsModel =
          TopNationalNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return topNationalNewsModel;
}

Future<BelowNationalNewsModel?> showBelowNatioalNews() async {
  print("NATIONAL");
  BelowNationalNewsModel? belowNationalNewsModel;
  Map<String, dynamic> body = {
    'type': 'CategoryWiseNews',
    'lang': 'en',
    'category': 'National',
    'limit': "4,3"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("NATIONAL_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      belowNationalNewsModel =
          BelowNationalNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return belowNationalNewsModel;
}

Future<TopInternationalNewsModel?> showInternationalNews() async {
  print("INTERNATIONAL");
  TopInternationalNewsModel? topInternationalNewsModel;
  Map<String, dynamic> body = {
    'type': 'CategoryWiseNews',
    'lang': 'en',
    'category': 'International',
    'limit': "3"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("INTERNATIONAL_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      topInternationalNewsModel =
          TopInternationalNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return topInternationalNewsModel;
}

Future<TopEntertainmentNewsModel?> showTopEntertainmentNews() async {
  print("ENTERTAINMENT");
  TopEntertainmentNewsModel? topEntertainmentNewsModel;
  Map<String, dynamic> body = {
    'type': 'CategoryWiseNews',
    'lang': 'en',
    'category': 'Entertainment',
    'limit': "1"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("INTERNATIONAL_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      topEntertainmentNewsModel =
          TopEntertainmentNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return topEntertainmentNewsModel;
}

Future<SecondEntertainmentNewsModel?> showSecondEntertainmentNews() async {
  print("ENTERTAINMENT");
  SecondEntertainmentNewsModel? secondEntertainmentNewsModel;
  Map<String, dynamic> body = {
    'type': 'CategoryWiseNews',
    'lang': 'en',
    'category': 'Entertainment',
    'limit': "1,3"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("SECOND_ENTERTAINMENT_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      secondEntertainmentNewsModel =
          SecondEntertainmentNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return secondEntertainmentNewsModel;
}

Future<ThirdEntertainmentNewsModel?> showThirdEntertainmentNews() async {
  print("ENTERTAINMENT");
  ThirdEntertainmentNewsModel? thirdEntertainmentNewsModel;
  Map<String, dynamic> body = {
    'type': 'CategoryWiseNews',
    'lang': 'en',
    'category': 'Entertainment',
    'limit': "4,5"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("INTERNATIONAL_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      thirdEntertainmentNewsModel =
          ThirdEntertainmentNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return thirdEntertainmentNewsModel;
}

Future<FourthEntertainmentNewsModel?> showFourthEntertainmentNews() async {
  print("ENTERTAINMENT");
  FourthEntertainmentNewsModel? fourthEntertainmentNewsModel;
  Map<String, dynamic> body = {
    'type': 'CategoryWiseNews',
    'lang': 'en',
    'category': 'Entertainment',
    'limit': "9,3"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("INTERNATIONAL_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      fourthEntertainmentNewsModel =
          FourthEntertainmentNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return fourthEntertainmentNewsModel;
}

Future<TopSportsNewsModel?> showTopSportsNews() async {
  print("ENTERTAINMENT");
  TopSportsNewsModel? topSportsNewsModel;
  Map<String, dynamic> body = {
    'type': 'CategoryWiseNews',
    'lang': 'en',
    'category': 'Sports',
    'limit': "2"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("SPORTS_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      topSportsNewsModel =
          TopSportsNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return topSportsNewsModel;
}

Future<SecondSportsNewsModel?> showSecondSportsNews() async {
  print("ENTERTAINMENT");
  SecondSportsNewsModel? secondSportsNewsModel;
  Map<String, dynamic> body = {
    'type': 'CategoryWiseNews',
    'lang': 'en',
    'category': 'Sports',
    'limit': "2,4"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("INTERNATIONAL_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      secondSportsNewsModel =
          SecondSportsNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return secondSportsNewsModel;
}

Future<ThirdSportsNewsModel?> showThirdSportsNews() async {
  print("ENTERTAINMENT");
  ThirdSportsNewsModel? thirdSportsNewsModel;
  Map<String, dynamic> body = {
    'type': 'CategoryWiseNews',
    'lang': 'en',
    'category': 'Sports',
    'limit': "6,1"
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("INTERNATIONAL_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      thirdSportsNewsModel =
          ThirdSportsNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return thirdSportsNewsModel;
}

Future<CateforyWiseSportsModel?> categoryWiseSports() async {
  print("ENTERTAINMENT");
  CateforyWiseSportsModel? cateforyWiseSportsModel;
  Map<String, dynamic> body = {
    'type': 'categorywisesports',
    'lang': 'en',
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("CATEGORY_WISE_SPORTS_RES => ${response.body}");
    if (response.statusCode == 200) {
      cateforyWiseSportsModel =
          CateforyWiseSportsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return cateforyWiseSportsModel;
}

Future<VideoNewsModel?> showAllVideoNews() async {
  print("VideoNews");
  VideoNewsModel? videoNewsModel;
  Map<String, dynamic> body = {
    'type': 'VideosNews',
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("INTERNATIONAL_TOP_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      videoNewsModel = VideoNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return videoNewsModel;
}

Future<NewsDetailsModel?> showNewsDetails(String newsId) async {
  print("NewsDetails => $newsId");
  NewsDetailsModel? newsDetailsModel;
  Map<String, dynamic> body = {
    'type': 'ViewArticlesNews',
    'id': newsId,
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("News_Details_RES => ${response.body}");
    if (response.statusCode == 200) {
      newsDetailsModel = NewsDetailsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return newsDetailsModel;
}

Future<RelatedNewsModel?> showRelatedNews(String newsId) async {
  RelatedNewsModel? relatedNewsModel;
  Map<String, dynamic> body = {
    'type': 'relatedArticles',
    'id': newsId,
    'lang': 'en',
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("RELATED_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      relatedNewsModel = RelatedNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return relatedNewsModel;
}

Future<CategoryWiseSportsArticlesModel?> showCategoryWiseSportsNews(
    String catName) async {
  CategoryWiseSportsArticlesModel? categoryWiseSportsArticles;
  Map<String, dynamic> body = {
    'type': 'subcategorywise',
    'sub_category': catName,
    'lang': 'en',
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("CATEGORY_SPORTS_NEWS_RES => ${response.body}");
    if (response.statusCode == 200) {
      categoryWiseSportsArticles =
          CategoryWiseSportsArticlesModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return categoryWiseSportsArticles;
}

Future<MenuModel?> showMenu() async {
  MenuModel? menuModel;
  Map<String, dynamic> body = {
    'type': 'showmenu',
    'lang': 'en',
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("Menu_RES => ${response.body}");
    if (response.statusCode == 200) {
      menuModel = MenuModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return menuModel;
}

Future<Map<String,dynamic>> login(String email, String password) async{
  Map<String, dynamic>body = {
    'type':'login',
    'email':email,
    'password':password,
  };
  var response = await http.post(Uri.parse(Urls.BASE_URL),body: body);
  var data = jsonDecode(response.body);

  return data;
}

Future<Map<String,dynamic>> signup(String name, String email, String number,String state, String password)async{

  print('name: ${name} \n email: ${email} \n number: ${number} \n state: ${state} \n password: ${password} \n ');

  Map<String, dynamic>body = {
    'type':'signup',
    'name':name,
    'email':email,
    'mobile':number,
    'state':state,
    'password':password,
    'confirm_password':password,
  };
  var response = await http.post(Uri.parse(Urls.BASE_URL),body: body);
  print(response);
  var data = jsonDecode(response.body);
  print("DATA_TYPE => ${jsonDecode(response.body).runtimeType}");
  return data;
}


Future<Map<String,dynamic>> saveArticle(var userId, var articleId)async{

  Map<String, dynamic>body = {
    'type':'SaveArticle',
    'user_id':userId,
    'article_id':articleId
  };
  var response = await http.post(Uri.parse(Urls.BASE_URL),body: body);
  var data = jsonDecode(response.body);
  print("<<<<<<<<<<<<<<<<<<<<<< response Save Artile");
  // print()
  return data;
}

Future<Map<String,dynamic>> likeArticle(var userId, var articleId)async{
  print("Userid_LIKE=>${userId}");
  print("Article_id_LIKE=>${articleId}");
  Map<String, dynamic>body = {
    'type':'LikeArticle',
    'user_id':userId,
    'article_id':articleId
  };
  var response = await http.post(Uri.parse(Urls.BASE_URL),body: body);
  var data = jsonDecode(response.body);
  print("<<<<<<<<<<<<<<<<<<<<<< response Like Artile");
  print("LIKE_ARTICLE_DATA=>${data}");
  return data;
}

Future<Map<String,dynamic>> checkLikedArticle(var userId, var articleId)async{

  Map<String, dynamic>body = {
    'type':'CheckLikedArticle',
    'user_id':userId,
    'article_id':articleId
  };
  var response = await http.post(Uri.parse(Urls.BASE_URL),body: body);
  var data = jsonDecode(response.body);
  print("<<<<<<<<<<<<<<<<<<<<<< response Save Artile");
  // print()
  return data;
}

Future<Map<String,dynamic>> checkSavedArticle(var userId, var articleId)async{

  Map<String, dynamic>body = {
    'type':'CheckSaveArticle',
    'user_id':userId,
    'article_id':articleId
  };
  var response = await http.post(Uri.parse(Urls.BASE_URL),body: body);
  var data = jsonDecode(response.body);
  print("<<<<<<<<<<<<<<<<<<<<<< response Save Artile");
  // print()
  return data;
}

Future<SavedNewsModel?> showAllSavedNews(var userId) async {
  print("userId => $userId");
  SavedNewsModel? savedNewsModel;
  Map<String, dynamic> body = {
    'type': 'ViewSaveArticle',
    'user_id': userId,
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("TYPE => ${response.body}");
    if (response.statusCode == 200) {
      savedNewsModel = SavedNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return savedNewsModel;
}

Future<LikedNewsModel?> showAllLikedNews(var userId) async {
  print("userId => $userId");
  LikedNewsModel? likedNewsModel;
  Map<String, dynamic> body = {
    'type': 'ViewLikeArticle',
    'user_id': userId,
  };
  try {
    var response = await http.post(Uri.parse(Urls.BASE_URL), body: body);
    print("TYPE => ${response.body}");
    if (response.statusCode == 200) {
      likedNewsModel = LikedNewsModel.fromJson(json.decode(response.body));
    }
  } catch (e) {

  }
  return likedNewsModel;
}
