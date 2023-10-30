import 'package:flutter/material.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';

class ListOfMembers extends StatefulWidget {
  final buildingName;
  const ListOfMembers({super.key, required this.buildingName});

  @override
  State<ListOfMembers> createState() => _ListOfMembersState(buildingNane: buildingName);
}

class _ListOfMembersState extends State<ListOfMembers> {
  final buildingNane;
  List peapleName = [
    '1001-Nita Ambani',
    '1002-Aaditya Birla',
    '1003-Ratan Tata',
    'Building4'
  ];
  _ListOfMembersState({ required this.buildingNane});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      bottomNavigationBar: BottomNavigation(),
      body: ListView(children: [
        basicComponents('Approve', 'assets/icons/approval.png'),
        MyCustomContainer(
          height: 470,
          radius: 20,
          background: 1,
          child: Column(
            children: [
              MyCustomContainer(
                height: 50,
                radius: 10,
                background: 0,
                child: Center(
                    child: Text(
                  buildingNane,
                  style: TextStyle(
                      fontSize: 20,
                      color: colorChoise(3),
                      fontWeight: FontWeight.bold),
                )),
              ),
              MyCustomContainer(
                height: 350,
                radius: 20,
                background: 2,
                width: 350,
                child: listViewWithDelete(
                  peapleName,
                  false,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
