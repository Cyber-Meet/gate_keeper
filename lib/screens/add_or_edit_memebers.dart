import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';
import 'package:my_gate_app/firebase_services/firebase_auth_services.dart';
import 'package:my_gate_app/firebase_services/firebase_database_service.dart';

class AddOrEditMembers extends StatefulWidget {
  final bool isEditPage;
  const AddOrEditMembers({super.key, required this.isEditPage});

  @override
  State<AddOrEditMembers> createState() =>
      _AddOrEditMembersState(this.isEditPage);
}

class _AddOrEditMembersState extends State<AddOrEditMembers> {
  bool isEditPage;
  _AddOrEditMembersState(this.isEditPage);
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   List<String> building=[];

  List<int> floors =[];
  String valueSelectedBuilding="";
  Map? buildingData;
  int valueSelectedFloor=1;
  String maleOrFemale = 'Male';
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _uniqueIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _flatController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBuildingData();
   

   
  }

  getBuildingData() async {
    buildingData = await getBuildingList();
    building = List.from(buildingData!.keys);
     valueSelectedBuilding = building[0];
    floors = List<int>.generate(buildingData![valueSelectedBuilding]['Floors'],
        (int index) => index + 1,
        growable: true);
    valueSelectedFloor = floors[0];
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigation(),
      appBar: myCustomAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            basicComponents('  Building', 'assets/icons/building.svg'),
            MyCustomContainer(
              radius: 20,
              width: width(context) / 1.1,
              height: height(context) / 1.7,
              background: 1,
              child: Column(
                children: [
                  SizedBox(
                    height: height(context) / 2.05,
                    child: ListView(
                      children: [
                        MyCustomContainer(
                          radius: 10,
                          background: 3,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Building Name :',
                                style: TextStyle(
                                    fontSize: 20, color: colorChoise(5)),
                              ),
                              DropdownButton<String>(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 35,
                                    color: colorChoise(0),
                                  ),
                                  value: valueSelectedBuilding,
                                  items: building.map((e) {
                                    return DropdownMenuItem<String>(
                                      child: Text(
                                        e.toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      value: e.toString(),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    valueSelectedBuilding = value.toString();
                                    floors = List<int>.generate(
                                        buildingData![valueSelectedBuilding]
                                            ['Floors'],
                                        (int index) => index + 1,
                                        growable: true);
                                    setState(() {});
                                  })
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Floor',
                              style: TextStyle(fontSize: 20),
                            ),
                            MyCustomContainer(
                              alignment: Alignment.center,
                              radius: 10,
                              background: 3,
                              height: 50,
                              width: 100,
                              child: DropdownButton(
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    size: 35,
                                    color: colorChoise(0),
                                  ),
                                  value: valueSelectedFloor,
                                  items: floors
                                      .map((e) => DropdownMenuItem(
                                            child: Text(
                                              e.toString(),
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            value: e,
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    valueSelectedFloor =
                                        int.parse(value.toString());
                                    setState(() {});
                                  }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                'Gender',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                padding: EdgeInsets.only(left: 4),
                                decoration: BoxDecoration(
                                    color: colorChoise(3),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: DropdownButton(
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 35,
                                      color: colorChoise(0),
                                    ),
                                    value: maleOrFemale,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text(
                                          'Male',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        value: 'Male',
                                      ),
                                      DropdownMenuItem(
                                        enabled: true,
                                        child: Text(
                                          'Female',
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        value: 'Female',
                                      ),
                                    ],
                                    isExpanded: true,
                                    onChanged: (value) {
                                      maleOrFemale = value.toString();
                                      setState(() {});
                                    }),
                              ),
                            )
                          ],
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                userDetail(
                                  'Flat No'.padRight(15),
                                  _flatController,
                                  context,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                userDetail(
                                  'Member Name'.padRight(15),
                                  _nameController,
                                  context,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                userDetail(
                                  'Contact'.padRight(15),
                                  _contactController,
                                  context,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                userDetail(
                                  'Unique Id'.padRight(15),
                                  _uniqueIdController,
                                  context,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                userDetail(
                                  'Photo'.padRight(15),
                                  _nameController,
                                  context,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                userDetail(
                                  'Password'.padRight(15),
                                  _passwordController,
                                  context,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  MyCustomButton(
                    name: 'Add',
                    callback: () {
                      if (_formKey.currentState!.validate()) {
                        String contact = _contactController.text.toString();
                        String uniqueId = _uniqueIdController.text.toString();
                        String name = _nameController.text.toString();
                        String password = _passwordController.text.toString();
                        String flatNo = _flatController.text.toString();
                        log(name + password + uniqueId + flatNo + contact);
                        MyFirebaseDatabase.addData({
                          'building': valueSelectedBuilding,
                          'floor': valueSelectedFloor,
                          'gender': maleOrFemale,
                          'flatNo': flatNo,
                          'name': name,
                          'contact': contact,
                          'uniqueid': uniqueId,
                          'Password': password
                        }, "${MyFirebaseAuth.userName}/Residents/${_contactController.text.toString()}/");
                        log(MyFirebaseDatabase.setData(
                                "${MyFirebaseAuth.userName}/Residents/${_contactController.text.toString()}/")
                            .toString());
                        log(MyFirebaseDatabase.data.toString());
                      }
                    },
                    color: 0,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
