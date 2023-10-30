import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';
import 'package:my_gate_app/screens/login_signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseUserType extends StatefulWidget {
  const ChooseUserType({super.key});

  @override
  State<ChooseUserType> createState() => _ChooseUserTypeState();
}

class _ChooseUserTypeState extends State<ChooseUserType> {
  var sharedPreferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initlization();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('WELCOME \nTO \nGATEKEEPER',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,color: colorChoise(0)),),
            MyCustomContainer(radius: 20, background: 2,height: height(context)/2.5,child: Image.asset('assets/icons/Login_building.png',height: height(context)/2.6,),),
            usersSelecation('Admin', context),
            SizedBox(
              height: 20,
            ),
            usersSelecation('Guard', context),
            SizedBox(
              height: 20,
            ),
            usersSelecation('Resident', context)
          ],
        ),
      )),
    );
  }

  initlization() async{

         sharedPreferences = await SharedPreferences.getInstance();
  }
  usersSelecation(String userType, BuildContext context) {
    return MyCustomButton(
      elevation: 0,
      textColor: 4,
      name: userType,
      callback: () async {



        Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginSignUpPage(userType: userType,)));
      },
      color: 1,
    );
  }
}
