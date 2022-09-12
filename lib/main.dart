import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_tazza_tv_flutter/Screens/SplashScreen.dart';
import 'package:new_tazza_tv_flutter/Widgets/AddMobHelper.dart';
import 'package:provider/provider.dart';
import 'package:new_tazza_tv_flutter/Providers/DataProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color.fromARGB(255, 73, 32, 188),
    ),
  );
  final adInitialize = MobileAds.instance.initialize();
  final adManager = AddMobHelper(initialization: adInitialize);
  runApp(Provider.value(
    value: adManager,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TazzaTv',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        home: const SplashScreen(),

        /*ChangeNotifierProvider(
          builder: (context, child) => DataProvider(),
          create: (BuildContext context) {
            return SplashScreen();
          },
        ),*/
      ),
    );
  }
}

