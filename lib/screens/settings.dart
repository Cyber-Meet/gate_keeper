import 'package:flutter/material.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';
import 'package:my_gate_app/firebase_services/firebase_auth_services.dart';
import 'package:my_gate_app/screens/choose_your_type.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      body: ListView(
        children: [
          basicComponents('Setting', 'assets/icons/s.svg'),
          MyCustomContainer(
            height: 450,
            radius: 20,
            background: 1,
            child: Column(children: [
              const SizedBox(
                height: 40,
              ),
              MyCustomButton(
                textColor: 4,
                name: 'Edit Profile',
                callback: () {},
                color: 3,
                width: width(context) / 2,
                elevation: 0,
              ),
              const SizedBox(
                height: 20,
              ),
              MyCustomButton(
                textColor: 4,
                width: width(context) / 2,
                name: 'Delete Account',
                callback: () {},
                color: 3,
                elevation: 0,
              ),
              const SizedBox(
                height: 20,
              ),
              MyCustomButton(
                textColor: 4,
                name: 'Notification',
                width: width(context) / 2,
                callback: () {},
                color: 3,
                elevation: 0,
              ),
              const SizedBox(
                height: 20,
              ),
              MyCustomButton(
                textColor: 4,
                width: width(context) / 2,
                name: 'Dark Mode',
                callback: () {},
                color: 3,
                elevation: 0,
              ),
              const SizedBox(
                height: 20,
              ),
              MyCustomButton(
                textColor: 4,
                width: width(context) / 2,
                name: 'App Info',
                callback: () {},
                color: 3,
                elevation: 0,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: width(context) / 2,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      MyFirebaseAuth.signOutUser();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseUserType(),
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 5,
                        backgroundColor: colorChoise(0),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'LOG OUT',
                          style: TextStyle(color: colorChoise(3), fontSize: 20),
                        ),
                        Icon(Icons.logout)
                      ],
                    )),
              )
            ]),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigation(name: 'Settings'),
    );
  }
}
