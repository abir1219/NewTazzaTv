import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_tazza_tv_flutter/Providers/DataProvider.dart';
import 'package:new_tazza_tv_flutter/Screens/Dashboard.dart';
import 'package:new_tazza_tv_flutter/Utils/AppColors.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyCustomDrawer.dart';
import 'package:provider/provider.dart';

class NewsDetails extends StatefulWidget {
  final newsId;

  const NewsDetails({Key? key, required this.newsId}) : super(key: key);

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {

  var strState = "West Bengal";

  @override
  void initState() {
    super.initState();
    GetStorage().read("state")!=null ? strState = GetStorage().read("state") : "West Bengal";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<DataProvider>(context,listen: false);
    provider.getNewsFromNewsId(widget.newsId);
    provider.getRelatedNewsId(widget.newsId);

    final GlobalKey<ScaffoldState> _key = GlobalKey();
    final size = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(
      endDrawer: const MyCustomDrawer(),
      appBar: AppBar(
        backgroundColor: const Color(0xFF196df9),
        elevation: 0,
        leading: InkWell(
          onTap: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Dashboard(
                    indexing: 0,
                  ),
                ));
          },
          child: Container(
            margin: const EdgeInsets.only(left: 5),
            child: Image.asset("assets/images/logo.png"),
          ),
        ),
        title: Center(
            child: Text(
              strState,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            )),
        actions: [
          const Icon(
            Icons.search,
            color: Colors.white,
            size: 28,
          ),
          const SizedBox(
            width: 15,
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              _key.currentState!.openEndDrawer();
            },
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: Consumer<DataProvider>(builder: (context, value, child) {
        return !value.isLoading ? SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                    child: Text(value.newsDetailsModel!.list![0].title,style: const TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,fontSize: 18),),
                  ),
                  HtmlWidget(value.newsDetailsModel!.list![0].shortDesc,
                    textStyle: const TextStyle(color: Colors.black,fontSize: 15),),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    height: size.height * .35,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(12)),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      child: SizedBox(
                        width: size.width,
                        child: CachedNetworkImage(
                          imageUrl: value.newsDetailsModel!.list![0].bannerImage,
                          placeholder: (context, url) => Image.asset("assets/images/loader.png"),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                   Padding(padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          value
                              .newsDetailsModel!
                              .list![0]
                              .createdOn,
                          style: const TextStyle(
                              fontSize:
                              13,
                              color: AppColors.smallTextColor),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(icon: Image.asset("assets/images/facebook.png",),onPressed: (){
                            },),
                            IconButton(icon: Image.asset("assets/images/whatsapp.png",),onPressed: (){

                            },),
                            IconButton(icon: Image.asset("assets/images/twitter.png",),onPressed: (){

                            },)
                          ],
                        ),
                      )
                    ],
                  ),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                    child: HtmlWidget(
                      value.newsDetailsModel!.list![0].description,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: (){
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
                          Text("Tags:  ",style: TextStyle(fontSize: 13),),
                          //Flexible(child: Text(value.newsDetailsModel!.list![0].tags,style: TextStyle(color: Colors.blue[800],fontSize: 13,decoration: TextDecoration.underline),maxLines: 3,overflow: TextOverflow.ellipsis,)),
                        ],
                      ),
                    ),
                  ),
                  const Gap(20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
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
                        padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),
                        child: SizedBox(
                          height: size.height * .35,
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
                                                    .relatedNewsModel!.list![index].id.toString(),
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
                                              imageUrl: value.relatedNewsModel!.list![index].image,
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
                                              value.relatedNewsModel!.list![index].createdOn,
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
                                              value.relatedNewsModel!.list![index].title,
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
                              itemCount: value.relatedNewsModel!.list!.length),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          )
        ):const Center(child: CircularProgressIndicator(),);
      },),
    ));
  }
}
