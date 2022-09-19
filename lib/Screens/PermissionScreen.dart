import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:new_tazza_tv_flutter/Screens/LoginPage.dart';
import 'package:new_tazza_tv_flutter/Screens/Privacy%20Policy/PrivacyPolicy.dart';
import 'package:new_tazza_tv_flutter/Screens/Terms%20&%20Conditions/TermsCondition.dart';
import 'package:new_tazza_tv_flutter/Utils/AppColors.dart';

class PermissionScreen extends StatefulWidget {
  const PermissionScreen({Key? key}) : super(key: key);

  @override
  State<PermissionScreen> createState() => _PermissionScreenState();
}

class _PermissionScreenState extends State<PermissionScreen> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;

    /*if(isChecked == true){
      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }*/

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              //crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: Size.height * .25,
                  width: Size.width,
                  child: Image.asset(
                    "assets/images/permission.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Text(
                        "Hi there",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.smallTextColor),
                      ),
                      Gap(5),
                      Text(
                        "To approve and disburse your loan quickly,\nWe need the following permissions.",
                        style: TextStyle(
                            fontSize: 14, color: AppColors.smallTextColor),
                      ),
                      Gap(15),
                      Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: Text(
                          "version, unique device identifier, wifi\nand mobile network information, profile\ninformation to prevent fraud by uniquely\nidentifying the devices and restricting\nunauthorized devices to act on your behalf.",
                          style: TextStyle(
                              fontSize: 14, color: AppColors.smallTextColor),
                        ),
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                const ListTile(
                  leading: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.grey,
                    size: 40,
                  ),
                  title: Text(
                    "Camera",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  subtitle: Text(
                    "Allow you to capture images of documents\nand pictures for loan application.",
                    style: TextStyle(
                        color: AppColors.smallTextColor, fontSize: 14),
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.storage,
                    color: Colors.grey,
                    size: 40,
                  ),
                  title: Text(
                    "Storage",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  subtitle: Text(
                    "Allow you to capture images of documents\nand pictures for loan application.",
                    style: TextStyle(
                        color: AppColors.smallTextColor, fontSize: 14),
                  ),
                ),
                const ListTile(
                  leading: Icon(
                    Icons.location_on,
                    color: Colors.grey,
                    size: 40,
                  ),
                  title: Text(
                    "Location",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  subtitle: Text(
                    "Allow you to capture images of documents\nand pictures for loan application.",
                    style: TextStyle(
                        color: AppColors.smallTextColor, fontSize: 14),
                  ),
                ),
                const Gap(45),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: [
                      const Divider(
                        height: 1,
                        color: AppColors.smallTextColor,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              print("changed");
                              isChecked = value;
                              setState(() {});
                              Timer(const Duration(milliseconds: 500), () {
                                /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginPage()));*/
                              });
                            },
                          ),
                          //const Gap(5),
                          const Text(
                            "I hereby agree to the",
                            style: TextStyle(
                                color: AppColors.smallTextColor, fontSize: 15),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children:  [
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const PrivacyPolicy()));
                              },
                              child: const Text(
                                "Privacy Policy",
                                style: TextStyle(
                                    color: AppColors.blueColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const Gap(3),
                            const Text(
                              "and",
                              style: TextStyle(
                                  color: AppColors.smallTextColor,
                                  fontSize: 15),
                            ),
                            const Gap(3),
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const TermsCondition()));
                              },
                              child: const Text(
                                "Terms and Conditions",
                                style: TextStyle(
                                    color: AppColors.blueColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment:Alignment.center,
                        child: SizedBox(
                          width: Size.width * .8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginPage()/*Dashboard(indexing: 0,)*/,));
                            },style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[400],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                )
                            ),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text("Next",style: TextStyle(color: Colors.white),),
                              ),),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
