import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:my_gate_app/customwidgets/mywidgets.dart';

import 'package:my_gate_app/screens/add_building.dart';

class Buildings extends StatefulWidget {
  const Buildings({super.key});

  @override
  State<Buildings> createState() => _BuildingsState();
}

class _BuildingsState extends State<Buildings> {
  List<String> buildingName=[];
  var a = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    Map temp = await getBuildingList();
    buildingName = List.from(temp.keys);
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      body: ListView(children: [
        basicComponents('  Buildings', 'assets/icons/building.svg'),
        MyCustomContainer(
          height: 450,
          radius: 20,
          background: 1,
          width: double.maxFinite,
          child: Column(
            children: [
              MyCustomTextField1(
                a: a,
                iconPath: 'assets/icons/search.svg',
                hint: 'Search Buildings',
              ),
              Column(
                children: [
                  MyCustomContainer(
                    height: 350,
                    radius: 20,
                    background: 2,
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 270,
                          child: MyNewListView(
                            stringList: buildingName,
                            icon2: SvgPicture.asset(
                              'assets/icons/delete.svg',
                              height: 30,
                            ),
                            icon: Image.asset(
                              'assets/icons/service.png',
                              height: 30,
                            ),
                          ),
                        ),
                        MyCustomButton(
                            name: 'Add Buildings',
                            callback: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddBuilding()));
                            })
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ]),
      bottomNavigationBar: BottomNavigation(name: 'Building'),
    );
  }
}
