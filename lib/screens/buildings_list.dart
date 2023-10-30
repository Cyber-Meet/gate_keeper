import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';
import 'package:my_gate_app/firebase_services/firebase_auth_services.dart';
import 'package:my_gate_app/firebase_services/firebase_database_service.dart';
import 'package:my_gate_app/screens/list_of_building_members.dart';

class ListOfBuildings extends StatefulWidget {
  const ListOfBuildings({super.key});

  @override
  State<ListOfBuildings> createState() => _ListOfBuildingsState();
}

class _ListOfBuildingsState extends State<ListOfBuildings> {
  List<String> buildings=[];
  var a = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getBuilding();
  }

  getBuilding() async {
    Map temp = await getBuildingList();

    buildings = List.from(temp.keys);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      bottomNavigationBar: BottomNavigation(),
      body: ListView(children: [
        basicComponents('Approve', 'assets/icons/approval.png'),
        MyCustomContainer(
          height: height(context) / 2,
          radius: 20,
          background: 1,
          child: Column(
            children: [
              MyCustomTextField1(
                a: a,
                hint: 'Search Buildings..',
                iconPath: 'assets/icons/search.svg',
              ),
              MyCustomContainer(
                  height: height(context) / 2.7,
                  radius: 20,
                  background: 2,
                  width: 350,
                  child: ListView.builder(
                      itemCount: buildings.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ListOfMembers(
                                                buildingName:
                                                    buildings[index])));
                                  },
                                  child: Container(
                                      height: 30,
                                      decoration: BoxDecoration(
                                          color: colorChoise(3),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Center(
                                          child: Text(buildings[index]))),
                                ),
                              ),
                            ],
                          ),
                        );
                      }))
            ],
          ),
        )
      ]),
    );
  }
}
