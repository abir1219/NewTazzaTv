import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
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
import 'package:new_tazza_tv_flutter/Screens/Home/SportsNewsModel/CateforyWiseSportsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/SportsNewsModel/SecondSportsNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/SportsNewsModel/TopSportsNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/StateModel/StateModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/StateNews/StateTopNews/StateFourthTopNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/StateNews/StateTopNews/StateSecondTopNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/StateNews/StateTopNews/StateThirdTopNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/StateNews/StateTopNews/StateTopNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/TopNewsModel/TopNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/VideoNewsModel/VideoNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/LikedNews/LikedNewsModel.dart';
import 'package:new_tazza_tv_flutter/Screens/SavedNews/SavedNewsModel.dart';
import 'package:new_tazza_tv_flutter/ServiceController/ServiceController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Models/AllNewsDataModel.dart';
import '../Screens/Home/BreakingNewsModel/BreakingNewsModel.dart';
import '../Screens/Home/FourthTopNewsModel/FourthTopNewsModel.dart';
import '../Screens/Home/InternationalNews/TopInternationalNewsModel.dart';
import '../Screens/Home/NationalNews/BelowNationalNewsModel.dart';
import '../Screens/Home/SecondTopNewsModel/SecondTopNewsModel.dart';
import '../Screens/Home/SportsNewsModel/ThirdSportsNewsModel.dart';
import '../Screens/Home/ThirdTopNewsModel/ThirdTopNewsModel.dart';

class DataProvider extends ChangeNotifier {
  AllNewsDataModel? postModel;
  BreakingNewsModel? breakingNewsModel;
  TopNewsModel? topNewsModel;
  SecondTopNewsModel? secondTopNewsModel;
  ThirdTopNewsModel? thirdTopNewsModel;
  FourthTopNewsModel? fourthTopNewsModel;
  StateModel? stateModel;
  StateTopNewsModel? stateTopNewsModel;
  StateSecondTopNewsModel? stateSecondTopNewsModel;
  StateThirdTopNewsModel? stateThirdTopNewsModel;
  StateFourthTopNewsModel? stateFourthTopNewsModel;
  TopNationalNewsModel? topNationalNewsModel;
  BelowNationalNewsModel? belowNationalNewsModel;
  TopInternationalNewsModel? topInternationalNewsModel;
  TopEntertainmentNewsModel? topEntertainmentNewsModel;
  SecondEntertainmentNewsModel? secondEntertainmentNewsModel;
  ThirdEntertainmentNewsModel? thirdEntertainmentNewsModel;
  FourthEntertainmentNewsModel? fourthEntertainmentNewsModel;
  TopSportsNewsModel? topSportsNewsModel;
  SecondSportsNewsModel? secondSportsNewsModel;
  ThirdSportsNewsModel? thirdSportsNewsModel;
  VideoNewsModel? videoNewsModel;
  CateforyWiseSportsModel? cateforyWiseSportsModel;
  NewsDetailsModel? newsDetailsModel;
  RelatedNewsModel? relatedNewsModel;
  CategoryWiseSportsArticlesModel? categoryWiseSportsArticlesModel;
  MenuModel? menuModel;
  ViewAllModel? viewAllModel;
  SavedNewsModel? savedNewsModel;
  LikedNewsModel? likedNewsModel;

  String strNews = "";

  bool isLoading = false;
  bool isLoggedIn = false;
  bool isSignedUp = false;

  var message = "";

  getAllData() async {
    ////isLoading = true;
    postModel = (await getAllNewsData())!;
    ////isLoading = false;
    notifyListeners();
  }

  /*List<StateList> stateList = [];
  Future<void> getAllState() async{
    stateList = await showAllStates();
    notifyListeners();
  }*/

  breakingNews() async {
    breakingNewsModel = (await showBreakingNews())!;

    for (var i = 0; i < breakingNewsModel!.newsList!.length; i++) {
      strNews += breakingNewsModel!.newsList![i].title + ". ";
      if (i == breakingNewsModel!.newsList!.length - 1) {
        notifyListeners();
      }
    }
    notifyListeners();
  }

  showTopNewsWithImage() async {
    ////isLoading = true;
    notifyListeners();
    topNewsModel = await showTopNews();
    ////isLoading = false;
    notifyListeners();
  }

  showSecondTopNewsWithImage() async {
    ////isLoading = true;
    notifyListeners();
    secondTopNewsModel = await showSecondTopNews();
    //isLoading= false;
    notifyListeners();
  }

  showThirdTopNewsWithImage() async {
    ////isLoading = true;
    notifyListeners();
    thirdTopNewsModel = await showThirdTopNews();
    ////isLoading = false;
    notifyListeners();
  }

  showFourthTopNewsWithImage() async {
    ////isLoading = true;
    notifyListeners();
    fourthTopNewsModel = await showFourthTopNews();
    ////isLoading = false;
    notifyListeners();
  }

  showStateList() async {
    //isLoading = true;
    //notifyListeners();
    stateModel = await showStates();
    //isLoading = false;
    notifyListeners();
  }

  showStateListForOptionPage() async {
    isLoading = true;
    notifyListeners();
    stateModel = await showStates();
    isLoading = false;
    notifyListeners();
  }

  showstateTopNewsList(String state) async {
    print("ST_RES=>$state");
    ////isLoading = true;
    //notifyListeners();
    stateTopNewsModel = await showStatesTopNews(state);
    ////isLoading = false;
    notifyListeners();
  }

  showstateSecondTopNewsList(String state) async {
    print("ST_RES=>$state");
    ////isLoading = true;
    //notifyListeners();
    stateSecondTopNewsModel = await showStatesSecondTopNews(state);
    ////isLoading = false;
    notifyListeners();
  }

  showstateThirdTopNewsList(String state) async {
    print("ST_RES=>$state");
    ////isLoading = true;
    //notifyListeners();
    stateThirdTopNewsModel = await showStatesThirdTopNews(state);
    ////isLoading = false;
    notifyListeners();
  }

  showstateFourthTopNewsList(String state) async {
    print("ST4_RES=>$state");
    ////isLoading = true;
    //notifyListeners();
    stateFourthTopNewsModel = await showStatesFourthTopNews(state);
    ////isLoading = false;
    notifyListeners();
  }

  showTopNatioalNewsList() async {
    ////isLoading = true;
    //notifyListeners();
    topNationalNewsModel = await showTopNatioalNews();
    ////isLoading = false;
    notifyListeners();
  }

  showBelowNatioalNewsList() async {
    ////isLoading = true;
    //notifyListeners();
    belowNationalNewsModel = await showBelowNatioalNews();
    ////isLoading = false;
    notifyListeners();
  }

  showInternatioalNewsList() async {
    ////isLoading = true;
    //notifyListeners();
    topInternationalNewsModel = await showInternationalNews();
    ////isLoading = false;
    notifyListeners();
  }

  showTopEntertainmentNewsList() async {
    ////isLoading = true;
    //notifyListeners();
    topEntertainmentNewsModel = await showTopEntertainmentNews();
    ////isLoading = false;
    notifyListeners();
  }

  showSecondEntertainmentNewsList() async {
    ////isLoading = true;
    //notifyListeners();
    secondEntertainmentNewsModel = await showSecondEntertainmentNews();
    ////isLoading = false;
    notifyListeners();
  }

  showThirdEntertainmentNewsList() async {
    ////isLoading = true;
    //notifyListeners();
    thirdEntertainmentNewsModel = await showThirdEntertainmentNews();
    ////isLoading = false;
    notifyListeners();
  }

  showFourthEntertainmentNewsList() async {
    ////isLoading = true;
    //notifyListeners();
    fourthEntertainmentNewsModel = await showFourthEntertainmentNews();
    ////isLoading = false;
    notifyListeners();
  }

  showTopSportsNewsList() async {
    ////isLoading = true;
    //notifyListeners();
    topSportsNewsModel = await showTopSportsNews();
    ////isLoading = false;
    notifyListeners();
  }

  showSecondSportsNewsList() async {
    ////isLoading = true;
    //notifyListeners();
    secondSportsNewsModel = await showSecondSportsNews();
    ////isLoading = false;
    notifyListeners();
  }

  showThirdSportsNewsList() async {
    ////isLoading = true;
    //notifyListeners();
    thirdSportsNewsModel = await showThirdSportsNews();
    ////isLoading = false;
    notifyListeners();
  }

  showAllVideoNewsList() async {
    ////isLoading = true;
    //notifyListeners();
    videoNewsModel = await showAllVideoNews();
    ////isLoading = false;
    notifyListeners();
  }

  showCategoryWiseSportsList() async {
    isLoading = true;
    notifyListeners();
    cateforyWiseSportsModel = await categoryWiseSports();
    isLoading = false;
    notifyListeners();
  }

  getNewsFromNewsId(String newsId) async {
    isLoading = true;
    notifyListeners();
    newsDetailsModel = await showNewsDetails(newsId);
    isLoading = false;
    notifyListeners();
  }

  getRelatedNewsId(String newsId) async {
    //isLoading = true;
    //notifyListeners();
    relatedNewsModel = await showRelatedNews(newsId);
    //isLoading = false;
    notifyListeners();
  }

  showCategoryWiseSportsArticleList(String catName) async {
    isLoading = true;
    notifyListeners();
    categoryWiseSportsArticlesModel = await showCategoryWiseSportsNews(catName);
    isLoading = false;
    notifyListeners();
  }

  showMenuList() async {
    isLoading = true;
    notifyListeners();
    menuModel = await showMenu();
    isLoading = false;
    notifyListeners();
  }

  showViewAllList(String type) async {
    isLoading = true;
    notifyListeners();
    viewAllModel = await showViewAllNews(type);
    isLoading = false;
    notifyListeners();
  }

  Future<String> loginUser(String email, String password) async {
    isLoggedIn = true;
    notifyListeners();
    Map<String, dynamic> response = await login(email, password);
    if (response['flag'] == "Y") {
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt("uid", response['user_id']);
      prefs.setString("uname", response['username']);
      message = response['message'];
      isLoggedIn = true;
      notifyListeners();
      notifyListeners();
    }
    message = response['flag'];
    notifyListeners();
    return response['flag'];
  }

  Future<String> signupUser(String name, String email, String number,
      String state, String password) async {
    isSignedUp = true;
    notifyListeners();
    //   work left
    Map<String, dynamic> response =
    await signup(name, email, number, state, password);
    print("RESPONSE_DATA_TYPE=>${response}");
    print("FLAG_RES => ${response['flag']}");
    if (response['flag'] == "Y") {
      //var data = jsonDecode(response.body);
      //print("SIGNUP_DATE => ${data.toString()}");
      print("UID => ${response['user_id']}");
      print("UNAME => ${response['username']}");
      final prefs = await SharedPreferences.getInstance();
      prefs.setInt("uid", response['user_id']);
      prefs.setString("uname", response['username']);
      //GetStorage().write("uid",response['user_id']);
      print('<<<<<<<<<<<<<<<<<<< ${GetStorage().read("uid").toString()}');
      //GetStorage().write("uname",response['username']);
      isSignedUp = false;
      message = response['message'];
      print("MESSAGE => ${response['message']}");
      notifyListeners();
    }
    message = response['message'];
    notifyListeners();
    return response['flag'];
  }

  Future<String> saveArticleByUser(var userId, var articleId) async {
    isLoading = true;
    notifyListeners();
    //   work left
    print("<<<<<<<<<<<<<<<<<<<< ${userId}");
    Map<String, dynamic> response = await saveArticle(userId, articleId);
    if (response['flag'] == "Y") {
      isLoading = false;
      message = response['message'];
      print("MESSAGE => ${response['message']}");
      notifyListeners();
    }
    isLoading = false;
    message = response['message'];
    notifyListeners();
    return response['flag'];
  }

  Future<String> likeArticleByUser(var userId, var articleId) async {
    isLoading = true;
    notifyListeners();
    //   work left
    print("<<<<<<<<<<<<<<<<<<<< ${userId}");
    Map<String, dynamic> response = await likeArticle(userId, articleId);
    if (response['flag'] == "Y") {
      isLoading = false;
      message = response['message'];
      print("MESSAGE => ${response['message']}");
      notifyListeners();
    }
    isLoading = false;
    message = response['message'];
    notifyListeners();
    return response['flag'];
  }

  Future<String> checkLikedArticleByUser(var userId, var articleId) async {
    //isLoading = true;
    //notifyListeners();
    //   work left
    print("<<<<<<<<<<<<<<<<<<<< ${userId}");
    Map<String, dynamic> response = await checkLikedArticle(userId, articleId);
    if (response['flag'] == "Y") {
      //isLoading = false;
      message = response['message'];
      print("MESSAGE => ${response['message']}");
      notifyListeners();
    }
    //isLoading = false;
    message = response['message'];
    notifyListeners();
    return response['flag'];
  }

  Future<String> checkSavedArticleByUser(var userId, var articleId) async {
    //isLoading = true;
    //notifyListeners();
    //   work left
    print("<<<<<<<<<<<<<<<<<<<< ${userId}");
    Map<String, dynamic> response = await checkSavedArticle(userId, articleId);
    if (response['flag'] == "Y") {
      //isLoading = false;
      message = response['message'];
      print("MESSAGE => ${response['message']}");
      notifyListeners();
    }
    //isLoading = false;
    message = response['message'];
    notifyListeners();
    return response['flag'];
  }

  showAllSavedNewsList(var userId) async {
    print("USER_ID_RES=>$userId");
    isLoading = true;
    notifyListeners();
    savedNewsModel = await showAllSavedNews(userId);
    isLoading = false;
    notifyListeners();
  }

  showAllLikedNewsList(var userId) async {
    isLoading = true;
    notifyListeners();
    likedNewsModel = await showAllLikedNews(userId);
    isLoading = false;
    notifyListeners();
  }

  Future<String> commentByUser(
      String review, String userId, String articleId) async {
    print("++++++++++++++++++++++++");
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> response = await addComment(review, userId, articleId);
    if (response['flag'] == "Y") {
      isLoading = false;
      message = response['message'];
      print("MESSAGE => ${response['message']}");
      notifyListeners();
    }
    isLoading = false;
    message = response['message'];
    notifyListeners();
    return response['flag'];
  }

  Future<String> contactUs(
      String name, String email, String message, String details) async {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> response =
    await addContactUs(name, email, message, details);
    if (response['flag'] == "Y") {
      isLoading = false;
      message = response['message'];
      print("MESSAGE => ${response['message']}");
      notifyListeners();
    }
    isLoading = false;
    message = response['message'];
    notifyListeners();
    return response['flag'];
  }

  Future<String> addYourArticle(
      String title,
      String shortNote,
      String description,
      String category,
      String subCategory,
      String state,
      String language) async {
    isLoading = true;
    notifyListeners();
    Map<String, dynamic> response = await addArticleByUser(
      title,
      shortNote,
      description,
      category,
      subCategory,
      state,
      language,
    );
    if (response['flag'] == "Y") {
      isLoading = false;
      message = response['message'];
      print("MESSAGE => ${response['message']}");
      notifyListeners();
    }
    isLoading = false;
    message = response['message'];
    notifyListeners();
    return response['flag'];
  }

}

//showAllLikedNews
