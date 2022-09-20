import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_tazza_tv_flutter/Providers/DataProvider.dart';
import 'package:new_tazza_tv_flutter/Screens/LoginPage.dart';
import 'package:new_tazza_tv_flutter/Screens/PermissionScreen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Dashboard.dart';

class OptionSelection extends StatefulWidget {
  const OptionSelection({Key? key}) : super(key: key);

  @override
  State<OptionSelection> createState() => _OptionSelectionState();
}

class _OptionSelectionState extends State<OptionSelection> {
  final stateList = ['West Bengal', 'Jharkhand', 'Odisa'];
  final languageList = ['Hindi', 'English'];
  String? value;
  String? langValue;
  late String strState = "West Bengal";
  late String strLang = "English";


  @override
  void initState() {
    super.initState();
    GetStorage().write("state", "West Bengal");
    GetStorage().write("lang", "en");
  }

  void ognClickNext() async {
    final prefs = await SharedPreferences.getInstance();
    print("State => ${GetStorage().read("state")}");
    print("Language => ${GetStorage().read("lang")}");

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => Dashboard(
    //       indexing: 0,
    //     ),
    //   ),
    // );
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Dashboard(
        indexing: 0,
      ),
    ));
  }

  void onClickNext() async {
    print("GOO");
    final prefs = await SharedPreferences.getInstance();
    print("State => ${GetStorage().read("state")}");
    print("Language => ${GetStorage().read("lang")}");

    if (GetStorage().read("state") == null) {
      GetStorage().write("state", "west bengal");
    }

    if (GetStorage().read("lang") == null) {
      GetStorage().write("lang", "en");
    }

    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => Dashboard(
        indexing: 0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<DataProvider>(context, listen: false);

    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: size.height * .15,
                child: Center(
                    child: Image.asset(
                      "assets/images/logo.png",
                      height: size.height * .2,
                      width: size.width * .50,
                    )),
              ),
              const Gap(22),
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Text(
                  "Select State",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                ),
              ),
              const Gap(5),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    //showStateDialog();
                    openStateBottomSheetDialog(provider);
                  },
                  child: Container(
                    width: size.width * .60,
                    margin: const EdgeInsets.all(16),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Text(
                      strState,
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ),
              ),
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  GetStorage().read("state") ?? "Select State",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 18),
                ),
              ),
              const Gap(5),
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 16,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 14.0, vertical: 10),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      strLang = languageList[index];
                                      print("strLang=>$strLang");
                                      strLang == "Hindi"
                                          ? GetStorage().write("lang", "hin")
                                          : strLang == "English"
                                          ? GetStorage().write("lang", "en")
                                          : "en";
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(languageList[index],
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black)),
                                        ),
                                        const Gap(5),
                                        const Divider(
                                          height: 1,
                                          color: Colors.black,
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: languageList.length,
                              ),
                            ));
                      },
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.all(16),
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Text(
                      GetStorage().read("lang") == "en" ? "English" :GetStorage().read("lang") == "hin"? "Hindi" : "Select Language",
                      style: const TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                ),
              ),
              const Gap(15),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: size.width * .8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        onClickNext();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF196df9),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "NEXT",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
    ),
  );

  void openStateBottomSheetDialog(DataProvider provider) {
    provider.showStateListForOptionPage();
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Consumer<DataProvider>(
            builder: (context, value, child) {
              return !value.isLoading
                  ? ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  print("LOGO->${value.stateModel!.list![index].logo}");
                  return InkWell(
                    onTap: () {
                      print(
                          "STATE_NAME=>${value.stateModel!.list![index].name}");
                      strState = value.stateModel!.list![index].name;
                      setState(() {
                        GetStorage().write(
                            "state", value.stateModel!.list![index].name);
                        print(
                            "SELECT_STATE => ${GetStorage().read("state")}");
                      });
                      Navigator.pop(context);
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
              )
                  : const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        });
  }
}
