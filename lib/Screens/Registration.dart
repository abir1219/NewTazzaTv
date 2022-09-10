import 'package:country_pickers/country.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:new_tazza_tv_flutter/Screens/LoginPage.dart';
import 'package:new_tazza_tv_flutter/Utils/AppColors.dart';

import 'OtpVerification.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final Country _selectedFilteredDialogCountry = CountryPickerUtils.getCountryByPhoneCode('91');
  final _phNumberController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailAddressController = TextEditingController();
  final _stateController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cnfirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;


    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(25),
              SizedBox(
                height: size.height * .20,
                child: Center(child: Image.asset("assets/images/logo.png",height: size.height * .5,width: size.width * .80,)),
              ),
              const Text("Looks like you are new here!",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 20),),
              const Gap(8),
              const Text("Sign up with your mobile number to get access to features like-",style: TextStyle(fontWeight: FontWeight.normal,color: AppColors.smallTextColor,fontSize: 15),),
              const Gap(3),
              const Text("Commenting, Saving Articles, Accessing Premium Articles.",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 18),),
              const Gap(8),
              const Text("Get started now.",style: TextStyle(fontWeight: FontWeight.normal,color: AppColors.smallTextColor,fontSize: 18),),
              const Gap(15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _fullNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: "Enter full name",
                      focusColor: Colors.grey
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _emailAddressController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      hintText: "Enter email address",
                      focusColor: Colors.grey
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _phNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                      hintText: "Enter Mobile Number",
                      focusColor: Colors.grey
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _stateController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                      hintText: "Enter State",
                      focusColor: Colors.grey
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Enter Password",
                      focusColor: Colors.grey
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _cnfirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      hintText: "Confirm Password",
                      focusColor: Colors.grey
                  ),
                ),
              ),
              const Gap(10),
              Align(
                alignment:Alignment.center,
                child: SizedBox(
                  width: size.width * .8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const OtpVerification()/*const OptionSelection() / Dashboard(indexing: 0,)*/,));
                    },style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF196df9),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)
                        )
                    ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text("CONTINUE",style: TextStyle(color: Colors.white),),
                      ),),
                  ),
                ),
              ),
              const Gap(8),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginPage(),));
                },
                child: const Align(
                  alignment: Alignment.center,
                  child: Text("Already Have an account? Click Here"),
                ),
              ),
              const Gap(30),
            ],
          ),
        ),
      ),
    ));
  }
}
