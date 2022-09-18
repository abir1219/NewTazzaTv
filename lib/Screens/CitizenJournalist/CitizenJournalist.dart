import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_tazza_tv_flutter/Providers/DataProvider.dart';
import 'package:new_tazza_tv_flutter/ServiceController/ServiceController.dart';
import 'package:provider/provider.dart';

class CitizenJournalist extends StatefulWidget {
  const CitizenJournalist({Key? key}) : super(key: key);

  @override
  State<CitizenJournalist> createState() => _CitizenJournalistState();
}

class _CitizenJournalistState extends State<CitizenJournalist> {
  final articleCategoryList = [
    'International News',
    'Health News',
    'Political News',
    'Bollywood News',
    'Technology News',
    'World News',
    'Sports News',
  ];
  final articleSubCategoryList = [
    'Cricket',
    'Football',
    'Hocky',
    'Tennis',
  ];
  final selectStateList = [
    'West Bengal',
    'Bihar',
    'Jharkhand',
    'Uttar Pradesh',
  ];
  final selectLanguageList = [
    'English',
    'Hindi',
    'Bengli',
  ];

  final _titleController = TextEditingController();
  final _shortNoteController = TextEditingController();
  final _descriptionController = TextEditingController();
  late String _articleCategory = "";
  late String _articleSubCategory = "";
  late String _selectState = "";
  late String _selectLanguage = "";
  late String _ImagePath = "";

  // Style
  final double selectBoxWidth = 150.0;

  final _formKey = GlobalKey<FormState>();
  // PlatformFile? _selectFile;
  // FilePickerResult? _filePickerResult;
  bool _isAllFill() {
    if (_titleController.text.isEmpty ||
        _shortNoteController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _articleCategory.isEmpty ||
        _articleSubCategory.isEmpty ||
        _selectState.isEmpty ||
        _selectLanguage.isEmpty) return false;

    return true;
  }

  // final ImagePicker _picker = ImagePicker();
  late bool _isImageSelected = false;
  late File imageFileOBJ;

  void _cameraPick() async {
    print("____________________________________________");
    // Pick an image
    final XFile? image =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (image!.name == null) return;

    print(image.name);
    imageFileOBJ = File(image.path);
    setState(() {
      _isImageSelected = true;
      _ImagePath = image.path;
    });
  }

  void _imagePick() async {
    final XFile? image =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image!.name == null) return;

    print(image.name);
    imageFileOBJ = File(image.path);
    setState(() {
      _isImageSelected = true;
      _ImagePath = image.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var provider = Provider.of<DataProvider>(context, listen: false);
    provider.showStateList();

    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(50),
                      const Text(
                        "ADD YOUR ARTICLE",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 22, 57, 118),
                            fontWeight: FontWeight.w900),
                      ),
                      const Gap(15),
                      TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Title", focusColor: Colors.grey),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const Gap(15),
                      TextFormField(
                        controller: _shortNoteController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Short Note", focusColor: Colors.grey),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const Gap(15),
                      TextFormField(
                        controller: _descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: "Description", focusColor: Colors.grey),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          Text("Category"),
                          Spacer(),
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
                                                _articleCategory =
                                                articleCategoryList[index];
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Text(
                                                        articleCategoryList[index],
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.bold,
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
                                          itemCount: articleCategoryList.length,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                // alignment: Alignment.centerRight,transformAlignment: ,
                                width: selectBoxWidth,
                                // margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                    Border.all(color: Colors.black, width: 1)),
                                child: Text(
                                  _articleCategory,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          Text("SubCategory"),
                          Spacer(),
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
                                                _articleSubCategory =
                                                articleSubCategoryList[index];
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Text(
                                                        articleSubCategoryList[
                                                        index],
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.bold,
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
                                          itemCount: articleSubCategoryList.length,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: selectBoxWidth,
                                // margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                    Border.all(color: Colors.black, width: 1)),
                                child: Text(
                                  _articleSubCategory,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          Text("State"),
                          Spacer(),
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
                                                _selectState =
                                                selectStateList[index];
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Text(
                                                        selectStateList[index],
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.bold,
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
                                          itemCount: selectStateList.length,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: selectBoxWidth,
                                // margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                    Border.all(color: Colors.black, width: 1)),
                                child: Text(
                                  _selectState,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          Text("Language"),
                          Spacer(),
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
                                                _selectLanguage =
                                                selectLanguageList[index];
                                                Navigator.pop(context);
                                                setState(() {});
                                              },
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(8.0),
                                                    child: Text(
                                                        selectLanguageList[index],
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                            FontWeight.bold,
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
                                          itemCount: selectLanguageList.length,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: selectBoxWidth,
                                // margin: const EdgeInsets.all(16),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border:
                                    Border.all(color: Colors.black, width: 1)),
                                child: Text(
                                  _selectLanguage,
                                  style: const TextStyle(
                                      fontSize: 15, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(15),
                      Row(
                        children: [
                          Text("Image"),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                      elevation: 16,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 20),
                                        child: Row(children: [
                                          InkWell(
                                            onTap: () {
                                              _cameraPick();
                                              Navigator.pop(context);
                                            },
                                            child: Image.asset(
                                              'assets/images/dslr-camera.png',
                                              height: 100,
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              _imagePick();
                                              Navigator.pop(context);
                                            },
                                            child: Image.asset(
                                              'assets/images/image-gallery.png',
                                              height: 100,
                                            ),
                                          )
                                        ]),
                                      ),
                                    );
                                  });

                              // ! Image Picker
                              // _pickFile();
                              // print("object");
                              // var picked = await FilePicker.platform.pickFiles();

                              // if (picked != null) {
                              //   print(picked.files.first.name);
                              // }
                            },
                            child: Container(
                              width: 130,
                              height: 130,
                              child: _isImageSelected
                                  ? Image.file(imageFileOBJ)
                                  : Image.asset('assets/images/gallery.png'),
                            ),
                          ),
                        ],
                      ),
                      // const Gap(5),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: size.width * .8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (!_isAllFill()) {
                                  Fluttertoast.showToast(msg: "It's incomplete");
                                  return;
                                }

                                var title = _titleController.text.toString();
                                var shortNote =
                                _shortNoteController.text.toString();
                                var description =
                                _descriptionController.text.toString();

                                var category = _articleCategory.toString();
                                var subCategory = _articleSubCategory.toString();
                                var state = _selectState.toString();
                                var language = _selectLanguage.toString();

                                print(
                                    ' title: $title  shortNote: $shortNote  description: $description category: $category  subCategory: $subCategory  state: $state   language: $language    ');
                                var provider = Provider.of<DataProvider>(context,
                                    listen: false);

                                if (await provider.addYourArticle(
                                    title,
                                    shortNote,
                                    description,
                                    category,
                                    subCategory,
                                    state,
                                    language) ==
                                    'Y') {
                                  Fluttertoast.showToast(msg: provider.message);
                                } else {
                                  Fluttertoast.showToast(msg: provider.message);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: _isAllFill()
                                      ? const Color(0xFF196df9)
                                      : Colors.grey[400],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  "SUBMIT",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
