import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:new_tazza_tv_flutter/Providers/DataProvider.dart';
import 'package:new_tazza_tv_flutter/Screens/Category/CategoryDetails.dart';
import 'package:new_tazza_tv_flutter/Widgets/MyCustomDrawer.dart';
import 'package:provider/provider.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  String strState = "West Bengal";

  @override
  void initState() {
    super.initState();
    GetStorage().read("state")!=null ? strState = GetStorage().read("state") : "West Bengal";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final postModel = Provider.of<DataProvider>(context, listen: false);
    postModel.showMenuList();

    final GlobalKey<ScaffoldState> _key = GlobalKey();
    final size = MediaQuery.of(context).size;


    return SafeArea(
      child: Scaffold(
        key: _key,
        endDrawer: const MyCustomDrawer(),
        appBar: AppBar(
          backgroundColor: const Color(0xFF196df9),
          elevation: 0,
          leading: Container(
            margin: const EdgeInsets.only(left: 5),
            child: Image.asset("assets/images/logo.png"),
          ),
          title: Center(
              child: Text(
                strState,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              )),
          actions: [
            const Icon(
              Icons.search,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(
              width: 15,
            ),
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                _key.currentState!.openEndDrawer();
              },
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        body: Consumer<DataProvider>(builder: (context, value, child) {
          return !value.isLoading ?
          RefreshIndicator(
            color: const Color(0xFF196df9),
            onRefresh: (){
              return Future.delayed(const Duration(seconds: 1),(){
                setState(() {
                });
              });
            },
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  CategoryDetails(type:value.menuModel!.list![index].name),));
                  },
                  child: SizedBox(
                    height:100,// size.height * .15,
                    child: Card(
                      elevation: 2,
                      shadowColor:
                      Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(value.menuModel!.list![index].name,style: const TextStyle(
                            fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ),
                  ),
                );
              },itemCount: value.menuModel!.list!.length,),
            ),
          ) : const Center(
            child: CircularProgressIndicator(),
          );
        },),
      ),
    );
  }
}
