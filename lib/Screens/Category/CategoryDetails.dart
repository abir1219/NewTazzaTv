import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_tazza_tv_flutter/Providers/DataProvider.dart';
import 'package:new_tazza_tv_flutter/Screens/Dashboard.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/NewsDetails/NewsDetails.dart';
import 'package:new_tazza_tv_flutter/Utils/AppColors.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyAppBar.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyCustomDrawer.dart';
import 'package:provider/provider.dart';

class CategoryDetails extends StatefulWidget {
  final type;
  final index;

  const CategoryDetails({Key? key, required this.type, required this.index})
      : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  var strState = "West Bengal";

  @override
  void initState() {
    super.initState();
    GetStorage().read("state") != null
        ? strState = GetStorage().read("state")
        : "West Bengal";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("TYPE => ${widget.type}");

    var provider = Provider.of<DataProvider>(context, listen: false);
    provider.showViewAllList(widget.type);

    final GlobalKey<ScaffoldState> _key = GlobalKey();
    final size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
          key: _key,
          endDrawer: const MyCustomDrawer(),
          appBar: MyAppBar(strState: strState, key_state: _key),
          body: Consumer<DataProvider>(
            builder: (context, value, child) {
              return !value.isLoading
                  ? RefreshIndicator(
                  color: const Color(0xFF196df9),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // const Gap(15),
                        Row(
                          children: [
                            IconButton(
                              iconSize: 27,
                              padding: EdgeInsets.all(0),
                              icon: const Icon(Icons.arrow_back,
                                  color: Colors.black),
                              onPressed: () {
                                Navigator.pop(context);
                                // widget.key_state.currentState!.openEndDrawer();
                              },
                            ),
                            Text(
                              widget.type,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ],
                        ),
                        // const Gap(15),
                        ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NewsDetails(
                                          newsId: value
                                              .viewAllModel!.list![index].id
                                              .toString(),
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
                                              BorderRadius.circular(12)),
                                          child: CachedNetworkImage(
                                            imageUrl: value.viewAllModel!
                                                .list![index].image,
                                            errorWidget:
                                                (context, url, error) =>
                                            const Icon(Icons.error),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const Gap(10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Text(
                                            value.viewAllModel!.list![index]
                                                .createdOn,
                                            maxLines: 5,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                AppColors.smallTextColor),
                                          ),
                                        ),
                                        const Gap(10),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4.0),
                                          child: Text(
                                            value.viewAllModel!.list![index]
                                                .title,
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
                                ),
                              );
                            },
                            itemCount: value.viewAllModel!.list!.length),
                      ],
                    ),
                  ),
                  onRefresh: () {
                    return Future.delayed(const Duration(seconds: 1), () {
                      setState(() {});
                    });
                  })
                  : const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          //bottomNavigationBar: Dashboard(),
        ));
  }
}
