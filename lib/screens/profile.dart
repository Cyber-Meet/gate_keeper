import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _designationController = TextEditingController();

  final _nameController = TextEditingController();

  final _emailController = TextEditingController();

  final _aadharController = TextEditingController();
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context, true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            basicComponents('  Profile', 'assets/icons/profile.svg'),
            MyCustomContainer(
              width: double.maxFinite,
              height: 470,
              radius: 20,
              background: 1,
              child: Column(children: [
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            actions: [
                              ElevatedButton(
                                  onPressed: () async {
                                    XFile? xFile = await ImagePicker()
                                        .pickImage(
                                            source: ImageSource.gallery,
                                            maxHeight: 1800,
                                            maxWidth: 1800);
                                    if (xFile != null) {
                                      imageFile = File(xFile.path);
                                    }
                                  },
                                  child: Text('Image form Gallary')),
                              ElevatedButton(
                                  onPressed: () async {
                                    XFile? xFile = await ImagePicker()
                                        .pickImage(
                                            source: ImageSource.camera,
                                            maxHeight: 1800,
                                            maxWidth: 1800);
                                    if (xFile != null) {
                                      imageFile = File(xFile.path);
                                    }
                                  },
                                  child: Text('Image form Camara')),
                            ],
                          );
                          if(imageFile != null){
                            
                          }
                        });
                  },
                  child: Container(
                    height: 170,
                    width: 170,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/myphoto.jpeg'),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 3, color: colorChoise(0))),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                userDetail('name           ', _nameController, context),
                const SizedBox(
                  height: 20,
                ),
                userDetail('Designation', _designationController, context),
                const SizedBox(
                  height: 15,
                ),
                userDetail('Email           ', _emailController, context),
                const SizedBox(
                  height: 15,
                ),
                userDetail('Aadhar No  ', _aadharController, context),
                const SizedBox(
                  height: 15,
                ),
                MyCustomButton(name: 'Save', callback: () {})
              ]),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

userDetail(String name, var controller, BuildContext context) {
  return Row(
    children: [
      Text(name),
      const SizedBox(
        width: 20,
      ),
      Container(
        height: 30,
        width: width(context) / 1.7,
        child: TextField(
          decoration: InputDecoration(
              labelText: name,
              filled: true,
              fillColor: colorChoise(3),
              border: OutlineInputBorder()),
        ),
      ),
    ],
  );
}
