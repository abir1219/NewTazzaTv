import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:new_tazza_tv_flutter/Providers/DataProvider.dart';
import 'package:new_tazza_tv_flutter/ServiceController/ServiceController.dart';
import 'package:provider/provider.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();
  final _detailsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(50),
                      const Text(
                        "CONTACT US",
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 34, 34, 34),
                            fontWeight: FontWeight.w900),
                      ),
                      const Gap(25),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Name", focusColor: Colors.grey),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const Gap(25),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Email", focusColor: Colors.grey),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const Gap(25),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          controller: _messageController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Message", focusColor: Colors.grey),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const Gap(25),
                      Padding(
                        padding: EdgeInsets.only(left: 12.0, right: 12.0),
                        child: TextFormField(
                          controller: _detailsController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              hintText: "Details", focusColor: Colors.grey),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                      const Gap(25),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: size.width * .8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  var name = _nameController.text.toString();
                                  var email = _emailController.text.toString();
                                  var message = _messageController.text.toString();
                                  var details = _detailsController.text.toString();

                                  print('$name $email $message $details');
                                  var provider = Provider.of<DataProvider>(context,
                                      listen: false);

                                  await provider.contactUs(
                                      name, email, message, details);

                                  // if (await provider.contactUs(
                                  //         name, email, message, details) ==
                                  //     'Y') {
                                  //   Fluttertoast.showToast(msg: provider.message);
                                  // } else {
                                  //   Fluttertoast.showToast(msg: provider.message);
                                  // }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  (_nameController.text.isNotEmpty &&
                                      _emailController.text.isNotEmpty &&
                                      _messageController.text.isNotEmpty &&
                                      _detailsController.text.isNotEmpty)
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
                      const Gap(50),
                      const Center(
                        child: Text(
                          "Get in touch with us \n response@taazatv.com",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 0, 0, 0),
                            // color: Color.fromARGB(255, 0, 0, 0),
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
