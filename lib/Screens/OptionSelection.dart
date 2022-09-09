import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_tazza_tv_flutter/Providers/DataProvider.dart';
import 'package:provider/provider.dart';

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
  String strState = "Select State";
  String strLang = "Select Language";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<DataProvider>(context, listen: false);
    provider.showStateList();

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
                openStateBottomSheetDialog();
              },
              child: Container(
                width: size.width * .60,
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Select Language",
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
              onTap: (){
                showDialog(context: context, builder: (context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 16,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            strLang = languageList[index];
                            Navigator.pop(context);
                            setState(() {

                            });
                          },
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(languageList[index],style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                              ),
                              const Gap(5),
                              const Divider(height: 1,color: Colors.black,)
                            ],
                          ),
                        );
                      },itemCount: languageList.length,),
                    )
                  );
                },);
              },
              child: Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 1)),
                child: Text(
                  strLang,
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Dashboard(
                            indexing: 0,
                          ),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      //primary: Colors.grey[400],
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

  void showStateDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<DataProvider>(
          builder: (context, value, child) {
            return StatefulBuilder(builder: (context, setState) {
              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 16,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    print(
                        "LOGO->${value.stateModel!.list![index].logo}");
                    return InkWell(
                      onTap: () {
                        print(
                            "STATE_NAME=>${value.stateModel!.list![index].name}");
                        GetStorage().write("state",value.stateModel!.list![index].name);
                        strState =
                            value.stateModel!.list![index].name;
                        Navigator.pop(context);
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(8.0),
                                  child: Image.network(
                                    value.stateModel!.list![index]
                                        .logo ??
                                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJLICBu_i2rNNd8l9Zz-DUNSwFXR9xAzCutg&usqp=CAU",
                                    fit: BoxFit.cover,
                                    width: 80,
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      value.stateModel!.list![index]
                                          .name,
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
            },);
          },
        );
      },
    );
  }

  void openStateBottomSheetDialog() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Consumer<DataProvider>(builder: (context, value, child) {
            return !value.isLoading ? ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                print(
                    "LOGO->${value.stateModel!.list![index].logo}");
                return InkWell(
                  onTap: () {
                    print(
                        "STATE_NAME=>${value.stateModel!.list![index].name}");
                    GetStorage().write("state",value.stateModel!.list![index].name);
                    strState =
                        value.stateModel!.list![index].name;
                    Navigator.pop(context);
                    setState(() {});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(8.0),
                              child: Image.network(
                                value.stateModel!.list![index]
                                    .logo ??
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJLICBu_i2rNNd8l9Zz-DUNSwFXR9xAzCutg&usqp=CAU",
                                fit: BoxFit.cover,
                                width: 80,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(
                                    horizontal: 8.0),
                                child: Text(
                                  value.stateModel!.list![index]
                                      .name,
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
            ):const Center(child: CircularProgressIndicator(),);
          },);
        }
    );
  }

}
