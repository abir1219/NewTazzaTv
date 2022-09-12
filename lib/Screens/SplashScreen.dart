import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:new_tazza_tv_flutter/Screens/Dashboard.dart';
import 'package:new_tazza_tv_flutter/Screens/LoginPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  final _splashDelay = 3000;
  late AnimationController _animationController;

  /*@override
  void initState() {
    redirect();
    GetStorage().write("state","West Bengal");
    GetStorage().write("lang","en");
    //GetStorage.init();
    //final prefs = SharedPreferences.getInstance();

    super.initState();
  }*/

  @override
  void initState() {
    // TODO: implement initState
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animationController.forward();
    super.initState();
    _loadWidget();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _loadWidget() async {
    var _duration = Duration(milliseconds: _splashDelay);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    print("Animation done");
    // ! Navigator Here
    redirect();
  }

  Future<void> redirect() async{
    print("GOO");
    final prefs = await SharedPreferences.getInstance();
    print("USER_ID => no");
    Timer(const Duration(seconds: 3), () {
      prefs.getInt("uid") != null ? Navigator.push(context, MaterialPageRoute(builder: (context) =>  Dashboard(indexing: 0,))):
      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: ScaleTransition(
                scale: _animationController,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Welcome To",style:TextStyle(fontSize: 40,color: Colors.black,fontWeight: FontWeight.bold)),
                      const Gap(15),
                      Image.asset('assets/images/logo.png'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
