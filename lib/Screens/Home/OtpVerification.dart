import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:new_tazza_tv_flutter/Screens/LoginPage.dart';
import 'package:new_tazza_tv_flutter/Screens/OptionSelection.dart';

class OtpVerification extends StatefulWidget {
  const OtpVerification({Key? key}) : super(key: key);

  @override
  State<OtpVerification> createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginPage(),));
                },
                icon: const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.black,size: 18,),
              ),
              const Gap(20),
              const Text("Verification code",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.black),),
              const Gap(8),
              const Text("We have sent the verification code to",style: TextStyle(fontSize: 10,fontWeight: FontWeight.normal,color: Colors.black),),
              const Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:  [
                  const Text("+91-9044818788",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                  const Gap(8),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const LoginPage(),));
                    },
                      child: const Text("Change phone number?",style: TextStyle(color: Color(0xFF196df9),fontSize: 14,fontWeight: FontWeight.bold),)),
                ],
              ),
              const Gap(20),
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 48,
                      width: 44,
                      child: TextField(
                        onChanged: (value){
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      width: 44,
                      child: TextField(
                        onChanged: (value){
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      width: 44,
                      child: TextField(
                        onChanged: (value){
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      width: 44,
                      child: TextField(
                        onChanged: (value){
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      width: 44,
                      child: TextField(
                        onChanged: (value){
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      width: 44,
                      child: TextField(
                        /*onChanged: (value){
                          if(value.length == 1){
                            FocusScope.of(context).nextFocus();
                          }
                        },*/
                        style: Theme.of(context).textTheme.headline6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Gap(18),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Resend code after ",style: TextStyle(color: Colors.black,fontSize: 12),),
                  Text("1.32",style: TextStyle(color: Color(0xFF196df9),fontSize: 12),),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.width *.60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width/2.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          width: 1,
                          color: const Color(0xFF196df9)
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 15),
                      child: Text("Resend",style: TextStyle(color: Color(0xFF196df9),fontSize: 15),),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  const OptionSelection(),));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width/2.2,
                      decoration: BoxDecoration(
                        color: const Color(0xFF196df9),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            width: 1,
                            color: const Color(0xFF196df9)
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 15),
                        child: Text("Confirm",style: TextStyle(color: Colors.white,fontSize: 15),),
                      ),
                    ),
                  ),

                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
