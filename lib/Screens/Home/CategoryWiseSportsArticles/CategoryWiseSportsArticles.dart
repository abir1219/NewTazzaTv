import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:new_tazza_tv_flutter/Providers/DataProvider.dart';
import 'package:new_tazza_tv_flutter/Screens/Dashboard.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/NewsDetails/NewsDetails.dart';
import 'package:new_tazza_tv_flutter/Utils/AppColors.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyAppBar.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyCustomDrawer.dart';
import 'package:provider/provider.dart';

class CategoryWiseSportsArticles extends StatefulWidget {
  final categoryName;
  const CategoryWiseSportsArticles({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<CategoryWiseSportsArticles> createState() => _CategoryWiseSportsArticlesState();
}

class _CategoryWiseSportsArticlesState extends State<CategoryWiseSportsArticles> {

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    final size = MediaQuery.of(context).size;
    var strState = "West Bengal";

    final postModel = Provider.of<DataProvider>(context, listen: false);
    postModel.showCategoryWiseSportsArticleList(widget.categoryName);

    return SafeArea(child: Scaffold(
        key: _key,
        endDrawer: const MyCustomDrawer(),
        appBar: MyAppBar(strState: strState,key_state: _key),
      body: Consumer<DataProvider>(
        builder: (context, value, child) {
          return !value.isLoading ? SingleChildScrollView(
            child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(15),
                Text(widget.categoryName,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                const Gap(15),
                SizedBox(
                  //height: dou,
                  width: double.infinity,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
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
                                            .categoryWiseSportsArticlesModel!.list![index].id.toString(),
                                      ),
                                ));
                          },
                          child: SizedBox(
                            width: size.width * .85,
                            child: Card(
                              elevation: 2,
                              shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                      12)),
                              child: Column(
                                mainAxisSize:
                                MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    child: CachedNetworkImage(
                                      imageUrl: value.categoryWiseSportsArticlesModel!.list![index].bannerImage,
                                      errorWidget: (context, url, error) => const Icon(Icons.error),
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
                                      value.categoryWiseSportsArticlesModel!.list![index].createdOn,
                                      maxLines: 5,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight:
                                          FontWeight.bold,
                                          color: AppColors.smallTextColor),
                                    ),
                                  ),
                                  const Gap(10),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: Text(
                                      value.categoryWiseSportsArticlesModel!.list![index].title,
                                      maxLines: 5,
                                      style:
                                      const TextStyle(
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
                      itemCount: value.categoryWiseSportsArticlesModel!.list!.length),
                )
              ],
            ),)
          ): const Center(child: CircularProgressIndicator(),);
        },
      ),
    ));
  }
}
