import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:new_tazza_tv_flutter/Screens/Dashboard.dart';
import 'package:new_tazza_tv_flutter/Screens/LoginPage.dart';
import 'package:new_tazza_tv_flutter/Screens/OptionSelection.dart';
import 'package:new_tazza_tv_flutter/Screens/PermissionScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
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

  Future<void> redirect() async {
    // print("GOO");
    final prefs = await SharedPreferences.getInstance();
    print('USER_ID => ${prefs.getInt("uid")}');
    Timer(const Duration(seconds: 3), () {
      prefs.getInt("uid") != null
          ? Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const OptionSelection(),
          ))
          : Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const PermissionScreen()));
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/SplashScreenBackgroundImage.jpeg"),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
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
                            // GradientText(
                            //   "Welcome To",
                            //   colors: const [
                            //     Color.fromARGB(255, 54, 24, 138),
                            //     Color.fromARGB(255, 42, 168, 199),
                            //     // Color.fromARGB(255, 42, 128, 199),
                            //     Color.fromARGB(255, 73, 32, 188),
                            //   ],
                            //   style: const TextStyle(
                            //     fontSize: 35,
                            //     color: Colors.black,
                            //     fontWeight: FontWeight.bold,
                            //     shadows: [
                            //       Shadow(
                            //         blurRadius: 5.0,
                            //         color: Color.fromARGB(75, 0, 0, 0),
                            //         offset: Offset(4.0, 2.0),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            const Gap(250),
                            Image.asset('assets/images/logo.png', scale: 3),
                            const Gap(250),
                            const Text(
                              "Welcome",
                              style: TextStyle(
                                fontSize: 30,
                                color: Colors.grey,
                                // fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
