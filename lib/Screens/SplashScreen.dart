import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_tazza_tv_flutter/Screens/Dashboard.dart';
import 'package:new_tazza_tv_flutter/Screens/LoginPage.dart';
import 'package:new_tazza_tv_flutter/Screens/PermissionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    redirect();
    GetStorage().write("state","West Bengal");
    GetStorage().write("lang","en");
    //GetStorage.init();
    //final prefs = SharedPreferences.getInstance();

    super.initState();
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
      body: Center(
        child: Image.asset("assets/images/logo.png"),
      ),
    ));
  }
}
