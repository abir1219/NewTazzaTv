import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_tazza_tv_flutter/Providers/DataProvider.dart';
import 'package:new_tazza_tv_flutter/Screens/Dashboard.dart';
import 'package:new_tazza_tv_flutter/Utils/AppColors.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyAppBar.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyCustomDrawer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsDetails extends StatefulWidget {
  final newsId;

  const NewsDetails({Key? key, required this.newsId}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  var strState = "West Bengal";
  var userId;
  var prefs;

  bool isSaved = false;
  bool isLiked = false;

  Future<void> getUserId() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs.getInt('uid');
    setState(() {});
  }

  final _commentController = TextEditingController();

  /*var provider = Provider.of<DataProvider>(context, listen: false);
  provider.getNewsFromNewsId(widget.newsId);
  provider.getRelatedNewsId(widget.newsId);*/

  @override
  void initState() {
    super.initState();
    getUserId();
    /*var provider = Provider.of<DataProvider>(context, listen: false);
    checkIsLiked(provider);
    checkIsSaved(provider);*/

    GetStorage().read("state") != null
        ? strState = GetStorage().read("state")
        : "West Bengal";
    setState(() {});
  }

  int likeLoopCount = 0;
  int saveLoopCount = 0;

  Future<void> checkIsLiked(DataProvider provider) async {
    if (await provider.checkLikedArticleByUser(
            userId.toString(), widget.newsId.toString()) == 'Y') {
      isLiked = true;
      likeLoopCount = 1;
      setState(() {});
    } else {
      isLiked = false;
      likeLoopCount = 2;
      setState(() {});
    }
  }

  Future<void> checkIsSaved(DataProvider provider) async {
    if (await provider.checkSavedArticleByUser(
            userId.toString(), widget.newsId.toString()) == 'Y') {
      isSaved = true;
      saveLoopCount = 1;
      setState(() {});
    } else {
      isSaved = false;
      saveLoopCount = 2;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DataProvider>(context, listen: false);
    provider.getNewsFromNewsId(widget.newsId);
    provider.getRelatedNewsId(widget.newsId);

    likeLoopCount == 0 ? checkIsLiked(provider) : null;
    saveLoopCount == 0 ? checkIsSaved(provider) : null;

    final GlobalKey<ScaffoldState> _key = GlobalKey();
    final size = MediaQuery.of(context).size;

    Future<void> _saveArticle() async {
      saveLoopCount = 0;
      print("_USERID => $userId");
      if (await provider.saveArticleByUser(
              userId.toString(), widget.newsId.toString()) ==
          'Y') {
        Fluttertoast.showToast(msg: provider.message);
      } else {
        Fluttertoast.showToast(msg: provider.message);
      }
    }

    Future<void> _likeArticle() async {
      likeLoopCount = 0;
      print("_USERID => $userId");
      if (await provider.likeArticleByUser(
              userId.toString(), widget.newsId.toString()) ==
          'Y') {
        Fluttertoast.showToast(msg: provider.message);
      } else {
        Fluttertoast.showToast(msg: provider.message);
      }
    }

    return SafeArea(
        child: Scaffold(
          key: _key,
      endDrawer: const MyCustomDrawer(),
      appBar: MyAppBar(strState: strState),
      body: Consumer<DataProvider>(
        builder: (context, value, child) {
          return !value.isLoading
              ? SingleChildScrollView(
                  child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Text(
                            value.newsDetailsModel!.list![0].title,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          height: size.height * .35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: SizedBox(
                              width: size.width,
                              child: CachedNetworkImage(
                                imageUrl: value
                                    .newsDetailsModel!.list![0].bannerImage,
                                placeholder: (context, url) =>
                                    Image.asset("assets/images/loader.png"),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                value.newsDetailsModel!.list![0].createdOn,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.smallTextColor),
                              ),
                              const Spacer(),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  IconButton(
                                    icon: Image.asset(
                                      "assets/images/facebook.png",
                                      height: 25,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                      "assets/images/whatsapp.png",
                                      height: 25,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: Image.asset(
                                      "assets/images/twitter.png",
                                      height: 25,
                                    ),
                                    onPressed: () {},
                                  ),
                                  IconButton(
                                    icon: userId != null
                                        ? Image.asset(
                                            isSaved
                                                ? "assets/images/after_save.png"
                                                : "assets/images/before_save.png",
                                            height: 25,
                                          )
                                        : Container(
                                            width: 0,
                                          ),
                                    onPressed: () {
                                      _saveArticle();
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: HtmlWidget(
                            value.newsDetailsModel!.list![0].shortDesc,
                            textStyle: const TextStyle(
                                color: Colors.black, fontSize: 15),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: HtmlWidget(
                            value.newsDetailsModel!.list![0].description,
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Dashboard(
                                      indexing: 0,
                                    ),
                                  ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "Tags:  ",
                                  style: TextStyle(fontSize: 13),
                                ),
                                //Flexible(child: Text(value.newsDetailsModel!.list![0].tags,style: TextStyle(color: Colors.blue[800],fontSize: 13,decoration: TextDecoration.underline),maxLines: 3,overflow: TextOverflow.ellipsis,)),
                              ],
                            ),
                          ),
                        ),
                        userId != null
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 8),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showCommentBox();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xFF196df9),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 12.0, vertical: 8),
                                          child: Text(
                                            "Comment",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Gap(10),
                                    IconButton(
                                      onPressed: () {
                                        _likeArticle();
                                      },
                                      icon: Image.asset(
                                        isLiked
                                            ? "assets/images/after_like.png"
                                            : "assets/images/before_like.png",
                                        height: 25,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : Container(),
                        const Gap(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Other Relevant Stories",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          ),
                        ),
                        const Gap(20),
                        Consumer<DataProvider>(
                          builder: (context, value, child) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 8.0),
                              child: SizedBox(
                                height: size.height * .345,
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
                                                      .relatedNewsModel!
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
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: size.height * .20,
                                                  width: size.width,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: CachedNetworkImage(
                                                    imageUrl: value
                                                        .relatedNewsModel!
                                                        .list![index]
                                                        .image,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const Gap(10),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 4.0),
                                                  child: Text(
                                                    value.relatedNewsModel!
                                                        .list![index].createdOn,
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
                                                    value.relatedNewsModel!
                                                        .list![index].title,
                                                    maxLines: 5,
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
                                        ),
                                      );
                                    },
                                    itemCount:
                                        value.relatedNewsModel!.list!.length),
                              ),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                ))
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    ));
  }

  void showCommentBox() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              elevation: 16,
              title: const Text(
                "Write your comment",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              content: Container(
                height: 150,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: const InputDecoration.collapsed(
                      hintText: "Write a comment",
                    ),
                    maxLines: 5,
                    controller: _commentController,
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xFF196df9),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                //const Gap(15),
                InkWell(
                  onTap: () {
                    _commentController.text = "";
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xFF196df9),
                          borderRadius: BorderRadius.circular(8)),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 12),
                        child: Text(
                          "Close",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ]);
        });
  }
}
