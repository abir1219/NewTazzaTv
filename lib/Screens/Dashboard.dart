import 'package:flutter/material.dart';
import 'package:new_tazza_tv_flutter/Screens/Category/Category.dart';
import 'package:new_tazza_tv_flutter/Screens/CitizenJournalist/CitizenJournalist.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/Home.dart';
import 'package:new_tazza_tv_flutter/Screens/LiveVideo/LiveVideo.dart';
import 'package:new_tazza_tv_flutter/Screens/VideoPlayer/VideoPlayer.dart';

class Dashboard extends StatefulWidget {
  //const Dashboard({Key? key}) : super(key: key);
  int indexing;

  Dashboard({
    Key? key,
    /* this.indexing,*/
    this.indexing = 0,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late int page;
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = [
    const Home(),
    const Category(),
    const LiveVideo(),
    /*Center(
      child: Text("Live Streaming"),
    ),*/
    const VideoPlayer(),
    const CitizenJournalist()
    /*Center(
      child: Text("Reporter Journal"),
    ),*/
    /*const Meetup(),
    const ActionPage(),
    const MessagePage(),
    const MyAccount()*/
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print("INDEX=>${widget.indexing}");
    _selectedIndex = widget.indexing;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: _onItemTapped,
          /*(int index) {
            setState(() {
              page = index;
            });
          },*/
          type: BottomNavigationBarType.fixed,
          iconSize: 25,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/home.png",
                  height: 40,
                  width: 40,
                ),
                activeIcon: Image.asset(
                  "assets/images/home.png",
                  height: 40,
                  width: 40,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/menu.png",
                  height: 40,
                  width: 40,
                ),
                activeIcon: Image.asset(
                  "assets/images/menu.png",
                  height: 40,
                  width: 40,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/play-button.png",
                  height: 45,
                  width: 45,
                ),
                activeIcon: Image.asset(
                  "assets/images/play-button.png",
                  height: 45,
                  width: 45,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/video.png",
                  height: 50,
                  width: 50,
                ),
                activeIcon: Image.asset(
                  "assets/images/video.png",
                  height: 50,
                  width: 50,
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Image.asset(

                  "assets/images/microphone.png",
                  height: 50,
                  width: 50,
                ),
                activeIcon: Image.asset(
                  "assets/images/microphone.png",
                  height: 50,
                  width: 50,
                ),
                label: ""),
          ],
        ),
        body: _widgetOptions[_selectedIndex] //currentpages(page),
        );
  }
}
