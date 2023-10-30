import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';
import 'package:my_gate_app/firebase_services/firebase_auth_services.dart';
import 'package:my_gate_app/firebase_services/firebase_database_service.dart';
import 'package:my_gate_app/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSignUpPage extends StatefulWidget {
  final String userType;
  const LoginSignUpPage({super.key, required this.userType});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState(this.userType);
}

class _LoginSignUpPageState extends State<LoginSignUpPage> {
  final String userType;
  _LoginSignUpPageState(this.userType);
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool obscureText = true;
  bool isLoginPage = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    yourUserType();
    log(userType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: SizedBox(
          width: width(context),
          child: Text(
            yourUserType() == 'Admin'
                ? isLoginPage
                    ? 'Admin Login'
                    : 'Admin Sign Up'
                : 'Login',
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
                      if (!isLoginPage && yourUserType() == 'Admin')
                        TextFormField(
                          keyboardType: TextInputType.name,
                          controller: _nameController,
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Name is Required'),
                          ]),
                          decoration: InputDecoration(
                              label: Text("Name"),
                              hintText: "Enter your name",
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: colorChoise(0), width: 2))),
                        ),
                      if (!isLoginPage)
                        SizedBox(
                          height: 20,
                        ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Email is Required'),
                          // EmailValidator(errorText: 'Email is not Valid'),
                        ]),
                        decoration: InputDecoration(
                            label: Text("Email"),
                            hintText: "Enter your email",
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: colorChoise(0), width: 2))),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
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
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: height(context) / 40,
                      ),
                      MyCustomButton(
                          width: width(context),
                          name: yourUserType() == 'Admin'
                              ? isLoginPage
                                  ? 'Login'
                                  : 'Sign Up'
                              : 'Login',
                          callback: () async {
                            if (_formKey.currentState!.validate()) {
                              if (yourUserType() == 'Admin') {
                                if (!isLoginPage) {
                                  MyFirebaseAuth.createUser(
                                          _emailController.text,
                                          _passwordController.text)
                                      .then((value) async {
                                    MyFirebaseAuth.setName(
                                        _nameController.text);
                                    SharedPreferences sharedPreferences =
                                        await SharedPreferences.getInstance();
                                    sharedPreferences.setString(
                                        USERTYPEKEY, userType);
                                    setUserType(userType.toString());
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MyHomePage()));
                                  });
                                } else {
                                  try {
                                    await MyFirebaseAuth.firebaseAuth
                                        .signInWithEmailAndPassword(
                                            email: _emailController.text,
                                            password: _passwordController.text)
                                        .then((value) {
                                      MyFirebaseAuth.userName ??= MyFirebaseAuth
                                          .firebaseAuth.currentUser!.email!
                                          .split('@')[0];
                                      log(MyFirebaseAuth.userName.toString());
                                      MyFirebaseAuth.uid ??= MyFirebaseAuth
                                          .firebaseAuth.currentUser!.uid;

                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  MyHomePage()));
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    log(e.code);
                                  }

                                  SharedPreferences sharedPreferences =
                                      await SharedPreferences.getInstance();
                                  sharedPreferences.setString(
                                      USERTYPEKEY, userType);
                                  setUserType(userType.toString());
                                }
                              } else if (yourUserType() == 'Resident') {
                                Map? userCredial = await MyFirebaseDatabase.setData(
                                        'jaydev/${yourUserType()}/${_emailController.text}');
                                log(userCredial.toString());
                                if (_passwordController.text ==
                                    userCredial['Password']) {
                                  log('login');
                                }
                              }
                              log(yourUserType());
                            }
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                      if (isLoginPage)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: SizedBox(
                            width: width(context),
                            child: Text(
                              'Forget password?',
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                  color: colorChoise(6),
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                    ]),
              ),
              Center(
                child: SizedBox(
                  width: width(context),
                  child: Text(
                    '“Managing Society Never Easy Before”',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: colorChoise(0), fontSize: 20),
                  ),
                ),
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
            ],
          ),
        ),
      )),
      bottomSheet: yourUserType() == 'Admin'
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isLoginPage
                    ? "Don't have account ?"
                    : "Already have an Account?"),
                TextButton(
                    onPressed: () {
                      isLoginPage = !isLoginPage;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        isLoginPage ? "Sign Up" : "Login",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: colorChoise(0)),
                      ),
                    ))
              ],
            )
          : null,
    );
  }

  String yourUserType() {
    return userType;
  }
}
