import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_tazza_tv_flutter/Providers/DataProvider.dart';
import 'package:new_tazza_tv_flutter/Screens/CitizenJournalist/CitizenJournalist.dart';
import 'package:new_tazza_tv_flutter/Screens/Contact%20Us/ContactUs.dart';
import 'package:new_tazza_tv_flutter/Screens/Dashboard.dart';
import 'package:new_tazza_tv_flutter/Screens/LikedNews/LikedNews.dart';
import 'package:new_tazza_tv_flutter/Screens/OptionSelection.dart';
import 'package:new_tazza_tv_flutter/Screens/SavedNews/SavedNews.dart';
import 'package:new_tazza_tv_flutter/Screens/Terms%20&%20Conditions/TermsCondition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyCustomDrawer extends StatefulWidget {
  const MyCustomDrawer({Key? key}) : super(key: key);

  @override
  State<MyCustomDrawer> createState() => _MyCustomDrawerState();
}

class _MyCustomDrawerState extends State<MyCustomDrawer> {
  var name = "";
  var language = "Hindi";

  Future<void> getName() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString("uname")!;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getName();
      //name = GetStorage().read("uname") ?? "";
      //language = GetStorage().read("lang") == "en" ? "Hindi" : "English";
      if (GetStorage().read("lang") == "en") {
        language = "Hindi";
      } else if (GetStorage().read("lang") == "hin") {
        language = "English";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<DataProvider>(context, listen: false);
    provider.showStateList();

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          SizedBox(
            height: 200,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * .15,
                      child: const Image(
                        image: AssetImage(
                          "assets/images/taazalogo.png",
                        ),
                      ),
                    ),
                    const Gap(15),
                    Text(
                      "Welcome $name",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  ]),
            ),
          ),
          ListTile(
            title: const Text(
              'Choose State',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Icon(
              Icons.place,
              color: Colors.black,
              size: 24,
            ),
            onTap: () {
              showStateDialog();
              //Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text(
              'Switch to $language',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Image(
                image: AssetImage(
                  "assets/images/change_lang.png",
                ),
                width: 24,
                height: 24,
                color: Colors.black),
            //const Icon(Icons.change,color: Colors.black,size: 24,),
            onTap: () {
              print("CLICKED");
              if (language == "Hindi") {
                GetStorage().write("lang", "hin");
              } else if (language == "English") {
                GetStorage().write("lang", "en");
              }
              setState(() {

              });
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Dashboard(
                      indexing: 0,
                    ),
                  ));
            },
          ),
          ListTile(
            title: const Text(
              'About Us',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Image(
                image: AssetImage(
                  "assets/images/information.png",
                ),
                width: 24,
                height: 24,
                color: Colors.black),
            //const Icon(Icons.change,color: Colors.black,size: 24,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text(
              'Saved News',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Image(
                image: AssetImage(
                  "assets/images/save_news.png",
                ),
                width: 24,
                height: 24,
                color: Colors.black),
            //const Icon(Icons.change,color: Colors.black,size: 24,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              //Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SavedNews()));
            },
          ),
          ListTile(
            title: const Text(
              'Liked News',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Image(
                image: AssetImage(
                  "assets/images/like.png",
                ),
                width: 24,
                height: 24,
                color: Colors.black),
            //const Icon(Icons.change,color: Colors.black,size: 24,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              //Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LikedNews()));
            },
          ),
          ListTile(
            title: const Text(
              'Contact Us',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Image(
                image: AssetImage(
                  "assets/images/contact.png",
                ),
                width: 24,
                height: 24,
                color: Colors.black),
            //const Icon(Icons.change,color: Colors.black,size: 24,),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ContactUs()));
            },
          ),
          ListTile(
            title: const Text(
              'Terms and Conditions',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Image(
                image: AssetImage(
                  "assets/images/tnc.png",
                ),
                width: 24,
                height: 24,
                color: Colors.black),
            //const Icon(Icons.change,color: Colors.black,size: 24,),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const TermsCondition()));
            },
          ),
          ListTile(
            title: const Text(
              'Citizen Journalist',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Image(
                image: AssetImage(
                  "assets/images/journalist.png",
                ),
                width: 24,
                height: 24,
                color: Colors.black),
            //const Icon(Icons.change,color: Colors.black,size: 24,),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CitizenJournalist()));
            },
          ),
          ListTile(
            title: const Text(
              'Logout',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            leading: const Image(
                image: AssetImage(
                  "assets/images/power.png",
                ),
                width: 24,
                height: 24,
                color: Colors.black),
            //const Icon(Icons.change,color: Colors.black,size: 24,),
            onTap: () {
              logout();
            },
          ),
        ],
      ),
    );
  }

  void showStateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<DataProvider>(
          builder: (context, value, child) {
            return StatefulBuilder(
              builder: (context, setState) {
                return Dialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 16,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      print("LOGO->${value.stateModel!.list![index].logo}");
                      return InkWell(
                        onTap: () {
                          print(
                              "STATE_NAME=>${value.stateModel!.list![index].name}");
                          GetStorage().write(
                              "state", value.stateModel!.list![index].name);
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Dashboard(
                                  indexing: 0,
                                ),
                              ));
                          //setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      value.stateModel!.list![index].logo ??
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJLICBu_i2rNNd8l9Zz-DUNSwFXR9xAzCutg&usqp=CAU",
                                      fit: BoxFit.cover,
                                      width: 80,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        value.stateModel!.list![index].name,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(5),
                              const Divider(
                                height: 1,
                                color: Colors.black,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: value.stateModel!.list!.length,
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const OptionSelection()));
  }
}
