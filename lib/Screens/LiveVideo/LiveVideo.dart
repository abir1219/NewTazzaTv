import 'package:flutter/material.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyAppBar.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyCustomDrawer.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class LiveVideo extends StatefulWidget {
  const LiveVideo({Key? key}) : super(key: key);

  @override
  State<LiveVideo> createState() => _LiveVideoState();
}

class _LiveVideoState extends State<LiveVideo> {
  late VideoPlayerController controller;

  //await controller.initialize();

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }


  loadVideoPlayer(){
    controller = VideoPlayerController.network('https://bradmax.com/client/embed-player/ae5100d161f01d3871ca6e9a729b7e1a45977967_7821?mediaUrl=https://stream.we2live.in/taaza/taaza/playlist.m3u8');
    controller.addListener(() {
      setState(() {});
    });
    controller.initialize().then((value){
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();
    final size = MediaQuery.of(context).size;

    final chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
      looping: true,
    );

    return SafeArea(
      child: Scaffold(
        key: _key,
        endDrawer: const MyCustomDrawer(),
        appBar: MyAppBar(key_state: _key),
        body: Center(
          child: SizedBox(
            height: size.height *.5,
            child: Chewie(
            controller: chewieController,
            ),
          ),
        ),
      ),
    );
  }
}
