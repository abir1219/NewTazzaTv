import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_tazza_tv_flutter/Screens/Category/CategoryDetails.dart';
import 'package:new_tazza_tv_flutter/Screens/Dashboard.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/CategoryWiseSportsArticles/CategoryWiseSportsArticles.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/NewsDetails/NewsDetails.dart';
import 'package:new_tazza_tv_flutter/Utils/AppColors.dart';
import 'package:new_tazza_tv_flutter/Widgets/AddMobHelper.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyAppBar.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyCustomDrawer.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../Providers/DataProvider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  BannerAd? _bottomBannerAd;
  bool isLoaded = false;
  late AddMobHelper adManager;

  var strState = "West Bengal";

  //var strState;

  BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.file, "assets/images/video.flv");

  void getBottomBannerAd(AddMobHelper adManager) {
    _bottomBannerAd = BannerAd(
      adUnitId: adManager.bannerAdUnitId,
      size: AdSize.largeBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            isLoaded = true;
            print('Ad loaded to load: $isLoaded !!!!!!');
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          //ad.dispose();
          print('Ad failed to load: $error');
        },
      ),
    )..load();
  }

  Widget showAd() {
    return isLoaded
        ? Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffffda11),
              ),
              //color: Color(0xffffda11),
            ),
            alignment: Alignment.center,
            height: _bottomBannerAd!.size.height.toDouble(),
            width: _bottomBannerAd!.size.width.toDouble(),
            child: AdWidget(ad: _bottomBannerAd!),
          )
        : Container(
            color: Colors.black87,
            alignment: Alignment.center,
            width: double.infinity,
            height: 50,
          );
  }

//------- AdMobAds -----------
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
// //------- AdMobAds -----------
//     adManager = Provider.of<AddMobHelper>(context);
//     adManager.initialization!.then((value) {
//       getBottomBannerAd(adManager);
//     });
//     //------- AdMobAds -----------
//   }

  @override
  void dispose() {
    super.dispose();
    // _bottomBannerAd!.dispose(); //------- AdMobAds -----------
    //_controller.dispose();
  }

  ///------- AdMobAds ----------- ///

  @override
  void initState() {
    super.initState();

    print("STATE_GET => ${GetStorage().read("state")}");
    print("LANG_GET => ${GetStorage().read("lang")}");
    GetStorage().read("state") != null
        ? strState = GetStorage().read("state")
        : "West Bengal";
    setState(() {});
    /*final postModel = Provider.of<DataProvider>(context, listen: false);
    postModel.breakingNews();
    postModel.showTopNewsWithImage();
    postModel.showSecondTopNewsWithImage();
    postModel.showThirdTopNewsWithImage();
    postModel.showFourthTopNewsWithImage();
    postModel.showstateTopNewsList(strState);
    postModel.showstateSecondTopNewsList(strState);
    postModel.showstateThirdTopNewsList(strState);
    postModel.showstateFourthTopNewsList(strState);*/
    //print("ALL_DATA=>"+postModel.getAllData());
    //print("NEWS_RES : "+postModel.postModel?.articleList!.length);
  }

  //ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataProvider>(context, listen: false);
    postModel.breakingNews();
    postModel.showTopNewsWithImage();
    postModel.showSecondTopNewsWithImage();
    postModel.showThirdTopNewsWithImage();
    postModel.showFourthTopNewsWithImage();
    postModel.showStateList();
    postModel.showstateTopNewsList(strState);
    postModel.showstateSecondTopNewsList(strState);
    postModel.showstateThirdTopNewsList(strState);
    postModel.showstateFourthTopNewsList(strState);
    postModel.showTopNatioalNewsList();
    postModel.showBelowNatioalNewsList();
    postModel.showInternatioalNewsList();
    postModel.showTopEntertainmentNewsList();
    postModel.showSecondEntertainmentNewsList();
    postModel.showThirdEntertainmentNewsList();
    postModel.showFourthEntertainmentNewsList();
    postModel.showTopSportsNewsList();
    postModel.showSecondSportsNewsList();
    postModel.showThirdSportsNewsList();
    postModel.showAllVideoNewsList();
    postModel.showCategoryWiseSportsList();

    /*_scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200), curve: Curves.easeOut);*/
    final size = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    // final postModel = Provider.of<DataProvider>(context);
    // print("NEWS_RES : ${postModel.postModel?.articleList!.length}");

    return SafeArea(
        child: Scaffold(
      key: _key,
      endDrawer: const MyCustomDrawer(),
      appBar: MyAppBar(strState: strState,key_state: _key),
      body: Consumer<DataProvider>(
        builder: (context, value, child) {
          return value.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  color: const Color(0xFF196df9),
                  onRefresh: () {
                    return Future.delayed(const Duration(seconds: 1), () {
                      setState(() {});
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4),
                    child: Column(
                      children: [
                        /*Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                                top: 5, left: 5, right: 2, bottom: 5),
                            padding: const EdgeInsets.only(
                                top: 6, left: 10, right: 10, bottom: 6),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  topLeft: Radius.circular(15)),
                            ),
                            child: const Text(
                              "BREAKING NEWS",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Consumer<DataProvider>(
                              builder: (context, value, child) {
                            return value.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : Expanded(
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                          top: 5, left: 2, right: 5, bottom: 5),
                                      padding: const EdgeInsets.only(
                                          top: 6,
                                          left: 10,
                                          right: 10,
                                          bottom: 6),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                            topRight: Radius.circular(15)),
                                      ),
                                      child: TextScroll(
                                        value.strNews,
                                        textDirection: TextDirection.rtl,
                                        mode: TextScrollMode.bouncing,
                                        velocity: const Velocity(
                                            pixelsPerSecond: Offset(50, 0)),
                                        delayBefore:
                                            const Duration(milliseconds: 1000),
                                        numberOfReps: 10000,
                                        //intervalSpaces: 10,
                                        pauseBetween:
                                            const Duration(milliseconds: 1000),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.right,
                                        selectable: false,
                                      ),
                                    ),
                                  );
                          }),
                        ],
                      ),*/
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                const Gap(3),
                                Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NewsDetails(
                                                newsId: value
                                                    .topNewsModel!.list![0].id
                                                    .toString(),
                                              ),
                                            ));
                                      },
                                      child: Column(
                                        children: [
                                          Text(
                                            value.topNewsModel!.list![0].title,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          const Gap(10),
                                          Container(
                                            height: size.height * .25,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: SizedBox(
                                              width: size.width,
                                              child: Image.network(
                                                value.topNewsModel!.list![0]
                                                    .image,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                const Gap(5),
                                Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                    return value.isLoading
                                        ? Center(
                                            child: Container(),
                                          )
                                        : Consumer<DataProvider>(
                                            builder: (context, value, child) {
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      NewsDetails(
                                                                newsId: value
                                                                    .secondTopNewsModel!
                                                                    .list![
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                              ),
                                                            ));
                                                      },
                                                      child: SizedBox(
                                                        height:
                                                            100, //size.height * .15,
                                                        child: Card(
                                                          elevation: 2,
                                                          shadowColor:
                                                              Colors.grey,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: SizedBox(
                                                              height: 80,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .stretch,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              4.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            value.secondTopNewsModel!.list![index].createdOn,
                                                                            style: const TextStyle(
                                                                                fontSize: 13,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: AppColors.smallTextColor),
                                                                          ),
                                                                          const Gap(
                                                                              15),
                                                                          Text(
                                                                            value.secondTopNewsModel!.list![index].title,
                                                                            style:
                                                                                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .network(
                                                                      value.secondTopNewsModel!.list![index]
                                                                              .image ??
                                                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJLICBu_i2rNNd8l9Zz-DUNSwFXR9xAzCutg&usqp=CAU",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      width:
                                                                          130,
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  itemCount: value
                                                      .secondTopNewsModel!
                                                      .list!
                                                      .length);
                                            },
                                          );
                                  },
                                ),
                                const Gap(5),
                                Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                    return value.isLoading
                                        ? Center(
                                            child: Container(),
                                          )
                                        : Consumer<DataProvider>(
                                            builder: (context, value, child) {
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      NewsDetails(
                                                                newsId: value
                                                                    .thirdTopNewsModel!
                                                                    .list![
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                              ),
                                                            ));
                                                      },
                                                      child: SizedBox(
                                                        height:
                                                            100, //size.height * .15,
                                                        child: Card(
                                                          elevation: 2,
                                                          shadowColor:
                                                              Colors.grey,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: SizedBox(
                                                              height: 80,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .stretch,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              4.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            value.thirdTopNewsModel!.list![index].createdOn,
                                                                            style: const TextStyle(
                                                                                fontSize: 13,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: AppColors.smallTextColor),
                                                                          ),
                                                                          const Gap(
                                                                              15),
                                                                          Text(
                                                                            value.thirdTopNewsModel!.list![index].title,
                                                                            style:
                                                                                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  /*ClipRRect(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        child: Image.network(
                                                          value.thirdTopNewsModel!.list![index].image ??
                                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJLICBu_i2rNNd8l9Zz-DUNSwFXR9xAzCutg&usqp=CAU",
                                                          fit: BoxFit.cover,
                                                          width: 130,
                                                        ),
                                                      )*/
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  itemCount: value
                                                      .thirdTopNewsModel!
                                                      .list!
                                                      .length);
                                            },
                                          );
                                  },
                                ),
                                /*VlcPlayer(controller: _videoPlayerController, aspectRatio: 16/9,
                                placeholder:  Center(child:LoadingAnimationWidget.hexagonDots(
                                  */ /*leftDotColor: const Color(0xFF1A1A3F),
                                  rightDotColor: const Color(0xFFEA3799),*/ /*
                                  size: 70, color: Colors.black,
                                ) */ /*CircularProgressIndicator()*/ /*),
                              ),*/
                                AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: BetterPlayer.network(
                                    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
                                    betterPlayerConfiguration:
                                        const BetterPlayerConfiguration(
                                            aspectRatio: 16 / 9,
                                            autoPlay: true),
                                  ),
                                ),
                                const Gap(5),
                                /*Consumer<DataProvider>(
                                builder: (context, value, child) {
                                  return value.isLoading
                                      ? Center(
                                          child: Container(),
                                        )
                                      : value.fourthTopNewsModel!.list!.length >
                                              0
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewsDetails(
                                                            newsId: value
                                                                .fourthTopNewsModel!
                                                                .list![index]
                                                                .id
                                                                .toString(),
                                                          ),
                                                        ));
                                                  },
                                                  child: SizedBox(
                                                    height:
                                                        108, //size.height * .15,
                                                    child: Card(
                                                      elevation: 2,
                                                      shadowColor: Colors.grey,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: SizedBox(
                                                          height: 88,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                child: Image
                                                                    .network(
                                                                  value
                                                                          .fourthTopNewsModel!
                                                                          .list![
                                                                              index]
                                                                          .image ??
                                                                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJLICBu_i2rNNd8l9Zz-DUNSwFXR9xAzCutg&usqp=CAU",
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  width: 130,
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          4.0),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        value
                                                                            .fourthTopNewsModel!
                                                                            .list![index]
                                                                            .createdOn,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                            color: AppColors.smallTextColor),
                                                                      ),
                                                                      const Gap(
                                                                          15),
                                                                      Text(
                                                                        value
                                                                            .fourthTopNewsModel!
                                                                            .list![index]
                                                                            .title,
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: value
                                                  .fourthTopNewsModel!
                                                  .list!
                                                  .length)
                                          : Container();
                                },
                              ),*/

                                Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                    return Container(
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF196df9),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            //Text("HELLO")
                                            ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    print(
                                                        "State->${value.stateModel!.list![index].name}");
                                                    setState(() {
                                                      strState = value
                                                          .stateModel!
                                                          .list![index]
                                                          .name;
                                                      postModel
                                                          .showstateTopNewsList(
                                                              strState);
                                                      postModel
                                                          .showstateSecondTopNewsList(
                                                              strState);
                                                      postModel
                                                          .showstateThirdTopNewsList(
                                                              strState);
                                                      postModel
                                                          .showstateFourthTopNewsList(
                                                              strState);
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.5),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Text(
                                                        //"Hello",
                                                        value.stateModel!
                                                            .list![index].name,
                                                        style: TextStyle(
                                                            color: strState ==
                                                                    value
                                                                        .stateModel!
                                                                        .list![
                                                                            index]
                                                                        .name
                                                                ? Colors.red
                                                                : Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              itemCount: value
                                                  .stateModel!.list!.length,
                                            ),
                                          ],
                                        ));
                                  },
                                ),
                                // strState == "West Bengal" ?
                                //const Gap(10),
                                Column(
                                  children: [
                                    Consumer<DataProvider>(
                                      builder: (context, value, child) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          NewsDetails(
                                                        newsId: value
                                                            .stateTopNewsModel!
                                                            .list![0]
                                                            .id
                                                            .toString(),
                                                      ),
                                                    ));
                                              },
                                              child: Container(
                                                height: size.height * .25,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: SizedBox(
                                                  width: size.width,
                                                  child: Image.network(
                                                    value.stateTopNewsModel!
                                                        .list![0].image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Gap(10),
                                            Text(
                                              value.stateTopNewsModel!.list![0]
                                                  .createdOn,
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColors.smallTextColor),
                                            ),
                                            const Gap(5),
                                            Text(
                                              value.stateTopNewsModel!.list![0]
                                                  .title,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            Consumer<DataProvider>(
                                              builder: (context, value, child) {
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        NewsDetails(
                                                                  newsId: value
                                                                      .stateSecondTopNewsModel!
                                                                      .list![
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                ),
                                                              ));
                                                        },
                                                        child: SizedBox(
                                                          height: 100,
                                                          //size.height * .15,
                                                          child: Card(
                                                            elevation: 2,
                                                            shadowColor:
                                                                Colors.grey,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(2.0),
                                                              child: SizedBox(
                                                                height: 80,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .stretch,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.symmetric(horizontal: 4.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              value.stateSecondTopNewsModel!.list![index].createdOn,
                                                                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.smallTextColor),
                                                                            ),
                                                                            const Gap(15),
                                                                            Text(
                                                                              value.stateSecondTopNewsModel!.list![index].title,
                                                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    itemCount: value
                                                        .stateSecondTopNewsModel!
                                                        .list!
                                                        .length);
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    ),
                                    const Gap(5),
                                  ],
                                ),
                                //:Container(),
                                Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetails(
                                                    newsId: value
                                                        .stateThirdTopNewsModel!
                                                        .list![index]
                                                        .id
                                                        .toString(),
                                                  ),
                                                ));
                                          },
                                          child: SizedBox(
                                            height: 120, //size.height * .15,
                                            child: Card(
                                              elevation: 2,
                                              shadowColor: Colors.grey,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: SizedBox(
                                                  height: 100,
                                                  width: 150,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.network(
                                                          value
                                                                  .stateThirdTopNewsModel!
                                                                  .list![index]
                                                                  .image ??
                                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJLICBu_i2rNNd8l9Zz-DUNSwFXR9xAzCutg&usqp=CAU",
                                                          fit: BoxFit.cover,
                                                          width: 150,
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                value
                                                                    .stateThirdTopNewsModel!
                                                                    .list![
                                                                        index]
                                                                    .createdOn,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: AppColors
                                                                        .smallTextColor),
                                                              ),
                                                              const Gap(15),
                                                              Text(
                                                                value
                                                                    .stateThirdTopNewsModel!
                                                                    .list![
                                                                        index]
                                                                    .title,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: value
                                          .stateThirdTopNewsModel!.list!.length,
                                    );
                                  },
                                ),
                                Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                    return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: value.stateFourthTopNewsModel!
                                          .list!.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      NewsDetails(
                                                    newsId: value
                                                        .stateFourthTopNewsModel!
                                                        .list![index]
                                                        .id
                                                        .toString(),
                                                  ),
                                                ));
                                          },
                                          child: Card(
                                            elevation: 2,
                                            shadowColor: Colors.grey,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: size.height * .25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: SizedBox(
                                                    width: size.width,
                                                    child: Image.network(
                                                      value
                                                          .stateFourthTopNewsModel!
                                                          .list![index]
                                                          .image,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const Gap(10),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    value
                                                        .stateFourthTopNewsModel!
                                                        .list![index]
                                                        .createdOn,
                                                    style: const TextStyle(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: AppColors
                                                            .smallTextColor),
                                                  ),
                                                ),
                                                const Gap(5),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Text(
                                                    value
                                                        .stateFourthTopNewsModel!
                                                        .list![index]
                                                        .title,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                const Gap(10),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                const Gap(10),
                                const Divider(
                                  height: 1,
                                  color: Colors.black,
                                ),
                                const Gap(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children:  [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "NATIONAL NEWS",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CategoryDetails(type:"National News", index: 0,),));
                                      },
                                      child: const Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "View More",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                const Gap(20),
                                Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        height: size.height * .319,
                                        width: double.infinity,
                                        child: ListView.builder(
                                            //physics: const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            NewsDetails(
                                                          newsId: value
                                                              .topNationalNewsModel!
                                                              .list![index]
                                                              .id
                                                              .toString(),
                                                        ),
                                                      ));
                                                },
                                                child: SizedBox(
                                                  width: size.width * .65,
                                                  child: Card(
                                                    elevation: 2,
                                                    shadowColor: Colors.grey,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height:
                                                              size.height * .20,
                                                          width: size.width,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: Image.network(
                                                            value
                                                                .topNationalNewsModel!
                                                                .list![index]
                                                                .image,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        const Gap(10),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          child: Text(
                                                            value
                                                                .topNationalNewsModel!
                                                                .list![index]
                                                                .createdOn,
                                                            maxLines: 5,
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .smallTextColor),
                                                          ),
                                                        ),
                                                        const Gap(10),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          child: Text(
                                                            value
                                                                .topNationalNewsModel!
                                                                .list![index]
                                                                .title,
                                                            maxLines: 5,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        const Gap(10),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: value
                                                .topNationalNewsModel!
                                                .list!
                                                .length),
                                      ),
                                    );
                                  },
                                ),
                                Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                    return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewsDetails(
                                                      newsId: value
                                                          .belowNationalNewsModel!
                                                          .list![index]
                                                          .id
                                                          .toString(),
                                                    ),
                                                  ));
                                            },
                                            child: Card(
                                              elevation: 2,
                                              shadowColor: Colors.grey,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: size.height * .25,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12)),
                                                    child: SizedBox(
                                                      width: size.width,
                                                      child: Image.network(
                                                        value
                                                            .belowNationalNewsModel!
                                                            .list![index]
                                                            .image,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  const Gap(10),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4.0),
                                                    child: Text(
                                                      value
                                                          .belowNationalNewsModel!
                                                          .list![index]
                                                          .createdOn,
                                                      maxLines: 5,
                                                      style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: AppColors
                                                              .smallTextColor),
                                                    ),
                                                  ),
                                                  const Gap(10),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4.0),
                                                    child: Text(
                                                      value
                                                          .belowNationalNewsModel!
                                                          .list![index]
                                                          .title,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  const Gap(10),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: value.belowNationalNewsModel!
                                            .list!.length);
                                  },
                                ),
                                const Gap(20),
                                Container(
                                  height: size.height * .42,
                                  width: double.infinity,
                                  color: const Color(0xFF196df9),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:15.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children:  [
                                              const Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "VIDEO NEWS",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold),
                                                  )),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => Dashboard(
                                                          indexing: 3,
                                                        ),
                                                      ));
                                                },
                                                child: const Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                      "View More",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                        decoration:
                                                        TextDecoration.underline,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(20),
                                        Consumer<DataProvider>(
                                          builder: (context, value, child) {
                                            return SizedBox(
                                              height: size.height * .339,
                                              width: double.infinity,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection: Axis.horizontal,
                                                itemBuilder: (context, index) {
                                                  String videoId;
                                                  videoId = YoutubePlayer.convertUrlToId(
                                                      value.videoNewsModel!.list![index].link)!;

                                                  return SizedBox(
                                                    width: size.width * .65,
                                                    child: Card(
                                                      elevation: 2,
                                                      shadowColor: Colors.grey,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(12)),
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Container(
                                                            height:
                                                            size.height * .25,
                                                            width: size.width,
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    12)),
                                                            child: YoutubePlayer(
                                                              controller: YoutubePlayerController(
                                                                  initialVideoId: videoId,
                                                                  flags: const YoutubePlayerFlags(
                                                                    autoPlay: false,

                                                                  )),
                                                            ),
                                                          ),
                                                          const Gap(18),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal:
                                                                8.0),
                                                            child: Text(
                                                              value.videoNewsModel!.list![index].title,
                                                              maxLines: 5,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: Colors.black),
                                                            ),
                                                          ),
                                                          const Gap(10),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                                itemCount: value.videoNewsModel!.list!.length,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Gap(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children:  [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "INTERNATIONAL NEWS",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CategoryDetails(type:"International News", index: 0,),));
                                      },
                                      child: const Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "View More",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                const Gap(20),
                                Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        height: size.height * .319,
                                        width: double.infinity,
                                        child: ListView.builder(
                                            //physics: const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            NewsDetails(
                                                          newsId: value
                                                              .topInternationalNewsModel!
                                                              .list![index]
                                                              .id
                                                              .toString(),
                                                        ),
                                                      ));
                                                },
                                                child: SizedBox(
                                                  width: size.width * .65,
                                                  child: Card(
                                                    elevation: 2,
                                                    shadowColor: Colors.grey,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height:
                                                              size.height * .20,
                                                          width: size.width,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                          child: Image.network(
                                                            value
                                                                .topInternationalNewsModel!
                                                                .list![index]
                                                                .image,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                        const Gap(10),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          child: Text(
                                                            value
                                                                .topInternationalNewsModel!
                                                                .list![index]
                                                                .createdOn,
                                                            maxLines: 5,
                                                            style: const TextStyle(
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: AppColors
                                                                    .smallTextColor),
                                                          ),
                                                        ),
                                                        const Gap(10),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      4.0),
                                                          child: Text(
                                                            value
                                                                .topInternationalNewsModel!
                                                                .list![index]
                                                                .title,
                                                            maxLines: 5,
                                                            style: const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ),
                                                        const Gap(10),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: value
                                                .topInternationalNewsModel!
                                                .list!
                                                .length),
                                      ),
                                    );
                                  },
                                ),
                                const Gap(20),
                                Container(
                                  height: size.height*1.8,
                                  decoration: const BoxDecoration(
                                    gradient:
                                    LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: <Color>[
                                        Color.fromARGB(188,211,254,1),
                                        Color.fromARGB(118,167,188,1),
                                        Color.fromARGB(79,120,120,1),
                                        Color.fromARGB(54,74,63,1),
                                        Color.fromARGB(28,31,22,1)
                                      ],
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:15.0),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children:  [
                                              const Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "ENTERTAINMENT NEWS",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.bold),
                                                  )),
                                              InkWell(
                                                onTap: (){
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CategoryDetails(type:"Entertainment News", index: 0,),));
                                                },
                                                child: const Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text(
                                                      "View More",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        decoration:
                                                        TextDecoration.underline,
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Gap(20),
                                        Consumer<DataProvider>(
                                          builder: (context, value, child) {
                                            return Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              NewsDetails(
                                                                newsId: value
                                                                    .topEntertainmentNewsModel!
                                                                    .list![0]
                                                                    .id
                                                                    .toString(),
                                                              ),
                                                        ));
                                                  },
                                                  child: Container(
                                                    height: size.height * .25,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                        BorderRadius.circular(12)),
                                                    child: SizedBox(
                                                      width: size.width,
                                                      child: Image.network(
                                                        value.topEntertainmentNewsModel!
                                                            .list![0].image,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Gap(10),
                                                Text(
                                                  value.topEntertainmentNewsModel!
                                                      .list![0].createdOn,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.smallTextColor),
                                                ),
                                                const Gap(10),
                                                Text(
                                                  value.topEntertainmentNewsModel!
                                                      .list![0].title,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        //Second Top Entertainment News place
                                        const Gap(5),
                                        Consumer<DataProvider>(
                                          builder: (context, value, child) {
                                            return value.isLoading
                                                ? Center(
                                              child: Container(),
                                            )
                                                : Consumer<DataProvider>(
                                              builder: (context, value, child) {
                                                return ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                    const NeverScrollableScrollPhysics(),
                                                    itemBuilder:
                                                        (context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                    NewsDetails(
                                                                      newsId: value
                                                                          .secondEntertainmentNewsModel!
                                                                          .list![
                                                                      index]
                                                                          .id
                                                                          .toString(),
                                                                    ),
                                                              ));
                                                        },
                                                        child: SizedBox(
                                                          height:
                                                          100, //size.height * .15,
                                                          child: Card(
                                                            elevation: 2,
                                                            shadowColor:
                                                            Colors.grey,
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(2.0),
                                                              child: SizedBox(
                                                                height: 80,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                                  crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .stretch,
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                            4.0),
                                                                        child:
                                                                        Column(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              value.secondEntertainmentNewsModel!.list![index].createdOn,
                                                                              style: const TextStyle(
                                                                                  fontSize: 13,
                                                                                  fontWeight: FontWeight.bold,
                                                                                  color: AppColors.smallTextColor),
                                                                            ),
                                                                            const Gap(
                                                                                15),
                                                                            Text(
                                                                              value.secondEntertainmentNewsModel!.list![index].title,
                                                                              style:
                                                                              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    /*ClipRRect(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                        child: Image.network(
                                                          value.thirdTopNewsModel!.list![index].image ??
                                                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJLICBu_i2rNNd8l9Zz-DUNSwFXR9xAzCutg&usqp=CAU",
                                                          fit: BoxFit.cover,
                                                          width: 130,
                                                        ),
                                                      )*/
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    itemCount: value
                                                        .secondEntertainmentNewsModel!
                                                        .list!
                                                        .length);
                                              },
                                            );
                                          },
                                        ),
                                        const Gap(5),
                                        Consumer<DataProvider>(
                                          builder: (context, value, child) {
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                const NeverScrollableScrollPhysics(),
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                NewsDetails(
                                                                  newsId: value
                                                                      .thirdEntertainmentNewsModel!
                                                                      .list![index]
                                                                      .id
                                                                      .toString(),
                                                                ),
                                                          ));
                                                    },
                                                    child: SizedBox(
                                                      height: 100, //size.height * .15,
                                                      child: Card(
                                                        elevation: 2,
                                                        shadowColor: Colors.grey,
                                                        child: Padding(
                                                          padding:
                                                          const EdgeInsets.all(2.0),
                                                          child: SizedBox(
                                                            height: 80,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .stretch,
                                                              children: [
                                                                Expanded(
                                                                  child: Padding(
                                                                    padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                        4.0),
                                                                    child: Column(
                                                                      mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      children: [
                                                                        Text(
                                                                          value
                                                                              .thirdEntertainmentNewsModel!
                                                                              .list![
                                                                          index]
                                                                              .createdOn,
                                                                          style: const TextStyle(
                                                                              fontSize:
                                                                              13,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .bold,
                                                                              color: AppColors
                                                                                  .smallTextColor),
                                                                        ),
                                                                        const Gap(15),
                                                                        Text(
                                                                          value
                                                                              .thirdEntertainmentNewsModel!
                                                                              .list![
                                                                          index]
                                                                              .title,
                                                                          style: const TextStyle(
                                                                              fontSize:
                                                                              14,
                                                                              fontWeight:
                                                                              FontWeight
                                                                                  .bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                ClipRRect(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      8.0),
                                                                  child: Image.network(
                                                                    value
                                                                        .thirdEntertainmentNewsModel!
                                                                        .list![
                                                                    index]
                                                                        .image ??
                                                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJLICBu_i2rNNd8l9Zz-DUNSwFXR9xAzCutg&usqp=CAU",
                                                                    fit: BoxFit.cover,
                                                                    width: 130,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                itemCount: value
                                                    .thirdEntertainmentNewsModel!
                                                    .list!
                                                    .length);
                                          },
                                        ),
                                        const Gap(5),
                                        Consumer<DataProvider>(
                                          builder: (context, value, child) {
                                            return Align(
                                              alignment: Alignment.centerLeft,
                                              child: SizedBox(
                                                height: size.height * .329,
                                                width: double.infinity,
                                                child: ListView.builder(
                                                  //physics: const NeverScrollableScrollPhysics(),
                                                    scrollDirection: Axis.horizontal,
                                                    shrinkWrap: true,
                                                    itemBuilder: (context, index) {
                                                      return InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    NewsDetails(
                                                                      newsId: value
                                                                          .fourthEntertainmentNewsModel!
                                                                          .list![index]
                                                                          .id
                                                                          .toString(),
                                                                    ),
                                                              ));
                                                        },
                                                        child: SizedBox(
                                                          width: size.width * .65,
                                                          child: Card(
                                                            elevation: 2,
                                                            shadowColor: Colors.grey,
                                                            shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    12)),
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize.min,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Container(
                                                                  height:
                                                                  size.height * .20,
                                                                  width: size.width,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                          12)),
                                                                  child: Image.network(
                                                                    value
                                                                        .fourthEntertainmentNewsModel!
                                                                        .list![index]
                                                                        .image,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                                const Gap(10),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      4.0),
                                                                  child: Text(
                                                                    value
                                                                        .fourthEntertainmentNewsModel!
                                                                        .list![index]
                                                                        .createdOn,
                                                                    maxLines: 5,
                                                                    style: const TextStyle(
                                                                        fontSize: 13,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                        color: AppColors
                                                                            .smallTextColor),
                                                                  ),
                                                                ),
                                                                const Gap(10),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      horizontal:
                                                                      4.0),
                                                                  child: Text(
                                                                    value
                                                                        .fourthEntertainmentNewsModel!
                                                                        .list![index]
                                                                        .title,
                                                                    maxLines: 5,
                                                                    style: const TextStyle(
                                                                        fontSize: 14,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                        color: Colors
                                                                            .black),
                                                                  ),
                                                                ),
                                                                const Gap(10),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    itemCount: value
                                                        .fourthEntertainmentNewsModel!
                                                        .list!
                                                        .length),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const Gap(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children:  [
                                    const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "SPORTS NEWS",
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        )),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const CategoryDetails(type:"Sports", index: 0,),));
                                      },
                                      child: const Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "View More",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                                const Gap(20),
                                Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        NewsDetails(
                                                      newsId: value
                                                          .topSportsNewsModel!
                                                          .list![0]
                                                          .id
                                                          .toString(),
                                                    ),
                                                  ));
                                            },
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: size.height * .25,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: SizedBox(
                                                    width: size.width,
                                                    child: Image.network(
                                                      value.topSportsNewsModel!
                                                          .list![index].image,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const Gap(10),
                                                Text(
                                                  value.topSportsNewsModel!
                                                      .list![index].createdOn,
                                                  style: const TextStyle(
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: AppColors
                                                          .smallTextColor),
                                                ),
                                                const Gap(10),
                                                Text(
                                                  value.topSportsNewsModel!
                                                      .list![0].title,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                const Gap(10),
                                              ],
                                            ),
                                          );
                                        },
                                        itemCount: value
                                            .topSportsNewsModel!.list!.length);
                                  },
                                ),
                                const Gap(20),
                                Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                    return value.isLoading
                                        ? Center(
                                            child: Container(),
                                          )
                                        : Consumer<DataProvider>(
                                            builder: (context, value, child) {
                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder:
                                                      (context, index) {
                                                    return InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      NewsDetails(
                                                                newsId: value
                                                                    .secondSportsNewsModel!
                                                                    .list![
                                                                        index]
                                                                    .id
                                                                    .toString(),
                                                              ),
                                                            ));
                                                      },
                                                      child: SizedBox(
                                                        height:
                                                            100, //size.height * .15,
                                                        child: Card(
                                                          elevation: 2,
                                                          shadowColor:
                                                              Colors.grey,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: SizedBox(
                                                              height: 80,
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .stretch,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .network(
                                                                      value.secondSportsNewsModel!.list![index]
                                                                              .image ??
                                                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJLICBu_i2rNNd8l9Zz-DUNSwFXR9xAzCutg&usqp=CAU",
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      width:
                                                                          130,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              4.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            value.secondSportsNewsModel!.list![index].createdOn,
                                                                            style: const TextStyle(
                                                                                fontSize: 13,
                                                                                fontWeight: FontWeight.bold,
                                                                                color: AppColors.smallTextColor),
                                                                          ),
                                                                          const Gap(
                                                                              15),
                                                                          Text(
                                                                            value.secondSportsNewsModel!.list![index].title,
                                                                            style:
                                                                                const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  itemCount: value
                                                      .secondSportsNewsModel!
                                                      .list!
                                                      .length);
                                            },
                                          );
                                  },
                                ),
                                Consumer<DataProvider>(
                                  builder: (context, value, child) {
                                    return GridView.builder(
                                      shrinkWrap: true,
                                      physics: const ClampingScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              crossAxisSpacing: 2.0,
                                              mainAxisSpacing: 2.0),
                                      itemCount: value.cateforyWiseSportsModel!
                                          .list!.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CategoryWiseSportsArticles(
                                                    categoryName: value
                                                        .cateforyWiseSportsModel!
                                                        .list![index]
                                                        .subCategory,
                                                  ),
                                                ));
                                          },
                                          child: SizedBox(
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Card(
                                                  elevation: 2,
                                                  shadowColor: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  child: Positioned.fill(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: SizedBox(
                                                        height:
                                                            size.height * .15,
                                                        child: ClipRect(
                                                          child: Image.network(
                                                            value
                                                                .cateforyWiseSportsModel!
                                                                .list![index]
                                                                .bannerImage,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  child: Text(
                                                    value
                                                        .cateforyWiseSportsModel!
                                                        .list![index]
                                                        .subCategory,
                                                    style: const TextStyle(
                                                        fontSize: 22,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    ));
  }

  Widget getAdd() {
    BannerAdListener bannerAdListener =
        BannerAdListener(onAdWillDismissScreen: (ad) {
      ad.dispose();
    }, onAdLoaded: (ad) {
      debugPrint("Ad Got Closed");
    });
    BannerAd bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: Platform.isAndroid
          ? "ca-app-pub-3940256099942544/6300978111"
          : "ca-app-pub-3940256099942544/2934735716",
      listener: bannerAdListener,
      request: const AdRequest(),
    );
    bannerAd.load();

    return SizedBox(
      height: 100,
      child: AdWidget(
        ad: bannerAd,
      ),
    );
  }
}
