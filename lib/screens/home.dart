import 'dart:developer';

import 'package:my_gate_app/firebase_services/firebase_auth_services.dart';
import 'package:my_gate_app/screens/add_or_edit_details_of_guard.dart';
import 'package:my_gate_app/screens/add_or_edit_memebers.dart';
import 'package:my_gate_app/screens/residents_and_guards_data.dart';
import 'package:my_gate_app/screens/services.dart';
import 'package:my_gate_app/screens/show_aminities.dart';

import '../customwidgets/mywidgets.dart';
import 'package:flutter/material.dart';

import 'buildings_list.dart';
import 'emergency_page.dart';
import 'history_page.dart';
import 'notice_list.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List notices = [
    'There will be Electricity  outage for an hour between 3:00 PM to 4:00 PM.',
    'There will be Electricity  outage for an hour between 3:00 PM to 4:00 PM.',
    'There will be Electricity  outage for an hour between 3:00 PM to 4:00 PM.'
  ];

  List<String> imagePaths = [
    'amenities.svg',
    'approval.png',
    'service.png',
    'notice.svg',
    'register.svg',
    'siren.svg'
  ];
  List screenList = [
    const AminitiesShowPage(),
    const ListOfBuildings(),
    const ServicesPage(),
    const NoticeList(),
    const HistoryPage(),
    EmergencyPage()
  ];
  List<String> nameOfFetures = [
    'Amenities',
    'Approve',
    'Services',
    'Notice',
    'Register',
    'Emergency'
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    log(MyFirebaseAuth.getName().toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      body: SingleChildScrollView(
        child: Column(children: [
          baseLine(),
          currentDateTime(),
          // Text(height(context).toString()),
          // Text(width(context).toString()),
          (userType == 'Admin')
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResidentsAndGuardsData(
                                  guardOrMember: 'Residents'),
                            ));
                      },
                      child: Text(
                        'Resident',
                        softWrap: true,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorChoise(0),
                          padding: EdgeInsets.all(4)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResidentsAndGuardsData(
                                  guardOrMember: 'Guard'),
                            ));
                      },
                      child: Text(
                        'Gurad',
                        softWrap: true,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorChoise(0),
                          padding: EdgeInsets.all(4)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddOrEditMembers(isEditPage: false)));
                      },
                      child: Text(
                        'Add Resident',
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorChoise(0)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddOrEditGuards(isEditPage: false,)));
                      },
                      child: Text(
                        'Add Guard',
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: colorChoise(0)),
                    ),
                  ],
                )
              : HeadingWidget(
                  path: 'assets/icons/notice.svg', heading: "Notice"),
          Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
              height: height(context) / 4,
              padding: const EdgeInsets.all(10),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: colorChoise(1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        SizedBox(
                          width: 13,
                          child: Text('${index + 1}.'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SizedBox(
                            width: 300,
                            child: Text(
                              '${notices[index]}',
                              softWrap: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: notices.length,
              )),
          Container(
            height: height(context) / 2.1,
            child: Center(
              child: GridViewOfFeatures(
                height: height(context) / 3,
                imagePaths: imagePaths,
                nameOfFetures: nameOfFetures,
                screenList: screenList,
              ),
            ),
          ),
          //     BottomNavigationBar(items: [
          //   bottomIcons('assets/icons/home.svg', 'Home'),
          //   bottomIcons('assets/icons/building.svg', 'Building'),
          //   bottomIcons('assets/icons/s.svg', 'Settings')
          // ]),
          // Padding(
          //   padding: const EdgeInsets.only(left: 10,right: 10),
          //   child: BottomNavigation(),
          // )
        ]),
      ),
      bottomNavigationBar: BottomNavigation(name: 'Home'),
    );
  }
}
