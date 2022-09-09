import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dialog.dart';
import 'package:country_pickers/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:new_tazza_tv_flutter/Screens/Dashboard.dart';
import 'package:new_tazza_tv_flutter/Screens/Home/OtpVerification.dart';
import 'package:new_tazza_tv_flutter/Screens/OptionSelection.dart';
import 'package:new_tazza_tv_flutter/Screens/Registration.dart';
import 'package:new_tazza_tv_flutter/Utils/AppColors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Country _selectedFilteredDialogCountry = CountryPickerUtils.getCountryByPhoneCode('91');
  final _phNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(25),
                SizedBox(
                  height: size.height * .30,
                  child: Center(child: Image.asset("assets/images/logo.png",height: size.height * .5,width: size.width * .80,)),
                ),
                const Text("Welcome!",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 22),),
                const Text("Enter your mobile number to continue.",style: TextStyle(fontWeight: FontWeight.normal,color: AppColors.smallTextColor,fontSize: 15),),

                Row(
                  children: [
                    InkWell(
                      onTap: _openFilteredCountryPickerDialog,
                      child: SizedBox(
                          width: size.width* .20,
                          child: _buildDialogItem(_selectedFilteredDialogCountry)),
                    ),
                     SizedBox(
                       width: size.width* .7,
                       child: TextField(
                        controller: _phNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: "Mobile Number",
                          focusColor: Colors.grey
                        ),
                    ),
                     ),
                  ],
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
                          backgroundColor: Colors.grey[400],
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
                const Gap(10),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  const Registration(),));
                  },
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text("Don't have account? Click Here"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openFilteredCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.pink),
        child: CountryPickerDialog(
            titlePadding: const EdgeInsets.all(8.0),
            searchCursorColor: Colors.pinkAccent,
            searchInputDecoration: const InputDecoration(hintText: 'Search...'),
            isSearchable: true,
            title: const Text('Select your phone code'),
            onValuePicked: (Country country) =>
                setState(() => _selectedFilteredDialogCountry = country),
            itemFilter: (c) => ['AR', 'DE', 'GB', 'CN','IN','PK','BD'].contains(c.isoCode),
            itemBuilder: _buildDialogItem)),
  );

  Widget _buildDialogItem(Country country) {
    return Row(
      children: [
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(width: 8.0),
        Text("+${country.phoneCode}"),
      ],
    );
  }
}
