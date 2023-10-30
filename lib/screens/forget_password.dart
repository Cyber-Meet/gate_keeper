import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';
import 'package:my_gate_app/screens/home.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final _passwordController = TextEditingController();
  
  bool obscureText = true;
  bool obscureText1 = true;
  bool isLoginPage = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: SizedBox(
          width: width(context),
          child: Text(
          "Forget Password",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              color: colorChoise(0),
            ),
          ),
        ),
      ),
      body: Center(
          child: Container(
height: height(context),
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          TextFormField(
                            onChanged: (value)=>password=value.toString(),
                            obscureText: obscureText,
                            keyboardType: TextInputType.emailAddress,
                            controller: _passwordController,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Password is Required'),
                              if (!isLoginPage)
                                MinLengthValidator(8,
                                    errorText:
                                    'password must be at least 8 digits long'),
                              if (!isLoginPage)
                                PatternValidator(r'(?=.*?[#?!@$%^&*-])',
                                    errorText:
                                    'passwords must have at least one special character')
                            ]),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: obscureText
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  onPressed: () {
                                    obscureText = !obscureText;
                                    setState(() {});
                                  },
                                ),
                                label: Text("Password"),
                                hintText: "Enter your password",
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colorChoise(0), width: 2))),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            obscureText: obscureText1,
                            keyboardType: TextInputType.emailAddress,


                            validator: (val)=>MatchValidator(errorText: 'Both must be queal').validateMatch(val!, password),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: obscureText1
                                      ? Icon(Icons.visibility)
                                      : Icon(Icons.visibility_off),
                                  onPressed: () {
                                    obscureText1 = !obscureText1;
                                    setState(() {});
                                  },
                                ),
                                label: Text("Confirm Password"),
                                hintText: "Enter your confirm password",
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: colorChoise(0), width: 2))),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: height(context) / 40,
                          ),
                          MyCustomButton(
                              width: width(context),
                              name: 'Change your password',
                              callback: () {

                              }),
                          SizedBox(
                            height: 15,
                          ),

                        ]),
                  ),

                  Container(
                    margin: EdgeInsets.only(bottom: 20, top: height(context) / 60),
                    height: height(context) / 2.9,
                    width: width(context),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/Login_building.png',
                        height: height(context) / 3,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: width(context),
                    child: Text(
                      '“Managing Society Never Easy Before”',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: colorChoise(0), fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          )),

    );
  }

  yourUserType() {
    return getUserType().toString();
  }
}
