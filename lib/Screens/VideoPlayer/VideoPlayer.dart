import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_tazza_tv_flutter/Providers/DataProvider.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyAppBar.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyCustomDrawer.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  const VideoPlayer({Key? key}) : super(key: key);

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {

  String strState = "West Bengal";

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
    final postModel = Provider.of<DataProvider>(context, listen: false);
    postModel.showAllVideoNewsList();

    final GlobalKey<ScaffoldState> _key = GlobalKey();
    final size = MediaQuery
        .of(context)
        .size;

    return SafeArea(child: Scaffold(
      key: _key,
      endDrawer: const MyCustomDrawer(),
      appBar: MyAppBar(strState: strState),
      body: Consumer<DataProvider>(
        builder: (context, value, child) {
          return RefreshIndicator(
              color: const Color(0xFF196df9),
              onRefresh: () {
                return Future.delayed(const Duration(seconds: 1), () {
                  setState(() {});
                });
              },
              child: Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      String videoId;
                      videoId = YoutubePlayer.convertUrlToId(
                          value.videoNewsModel!.list![index].link)!;

                      return Container(
                          color: const Color.fromARGB(255, 22, 56, 117),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                YoutubePlayer(
                                  controller: YoutubePlayerController(
                                      initialVideoId: videoId,
                                      flags: const YoutubePlayerFlags(
                                        autoPlay: false,

                                      )),
                                ),
                                const Gap(25),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      value.videoNewsModel!.list![index].title,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const Gap(10)
                              ],
                            ),
                          ));
                    },
                  itemCount: value.videoNewsModel!.list!.length,
                ),
              )
          );
        },
      ),
    ));
  }
}
