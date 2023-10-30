import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:my_gate_app/customwidgets/mywidgets.dart';
import 'package:my_gate_app/models/guard.dart';
import 'package:my_gate_app/models/resident.dart';

class ResidentsAndGuardsData extends StatefulWidget {
  final String guardOrMember;
  const ResidentsAndGuardsData({super.key, required this.guardOrMember});

  @override
  State<ResidentsAndGuardsData> createState() =>
      _ResidentsAndGuardDataState(guardOrMember: guardOrMember);
}

class _ResidentsAndGuardDataState extends State<ResidentsAndGuardsData> {
  String guardOrMember;
  var _searchFieldController = TextEditingController();
  _ResidentsAndGuardDataState({required this.guardOrMember});
  bool isGuard = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isGuard = (guardOrMember == 'Guard') ? true : false;
    log(getResedentsData().toString());
    assignData();
  }

  assignData() async {
    Map dataOfMembers = await getResedentsData();

    keysMembers = List.of(dataOfMembers.keys);

    residents.clear();
    for (int i = 0; i < keysMembers.length; i++) {
      residents.add(Resident(
          dataOfMembers[keysMembers[i]]["name"].toString(),
          dataOfMembers[keysMembers[i]]['building'],
          dataOfMembers[keysMembers[i]]['contact'],
          int.parse(dataOfMembers[keysMembers[i]]['flatNo']),
          dataOfMembers[keysMembers[i]]['uniqueid']));
    }
    setState(() {
      
    });
  }

  List<Guard> guards = [
    Guard(DateTime(2023, 4, 5), '7859641236', 'Ramesh', '458926351456'),
    Guard(DateTime(2023, 4, 5), '4125361011', 'Meet', '458926351456'),
    Guard(DateTime(2023, 4, 5), '8459632171', 'Abhishek', '452361787894'),
    Guard(DateTime(2023, 4, 5), '8459632171', 'Kandarp', '458926351456'),
    Guard(DateTime(2023, 4, 5), '7458963214', 'Bandan', '458926351456'),
    Guard(DateTime(2023, 4, 5), '1234526981', 'Harsh', '458926351456'),
    Guard(DateTime(2023, 4, 5), '785964131', 'Vikash', '458926351456'),
    Guard(DateTime(2023, 4, 5), '1236985470', 'Meera', '458926351456'),
    Guard(DateTime(2023, 4, 5), '4125369870', 'Viraj', '458926351456'),
  ];
  List keysMembers = [];
  List<Resident> residents = [];
  List<dynamic> _result = [];
  Widget? noResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myCustomAppBar(context),
        bottomNavigationBar: BottomNavigation(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              basicComponents(
                  "  " + guardOrMember, 'assets/icons/register.svg'),
              MyCustomContainer(
                radius: 20,
                background: 1,
                height: height(context) / 1.8,
                width: width(context) / 1.1,
                padding: 10,
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        List<dynamic> temp = [];
                        _result.clear();
                        if (isGuard) {
                          for (Guard str in guards) {
                            if (str.name
                                .toLowerCase()
                                .contains(value.toString().toLowerCase())) {
                              temp.add(str);
                            }
                          }
                        } else {
                          for (Resident str in residents) {
                            if (str.name
                                .toLowerCase()
                                .contains(value.toString().toLowerCase())) {
                              temp.add(str);
                            }
                          }
                        }
                        if (temp.isNotEmpty) {
                          _result.addAll(temp);
                          noResult = null;
                          setState(() {});
                        } else {
                          noResult = Text(
                            "No $guardOrMember Found",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          );
                          setState(() {});
                        }
                      },
                      controller: _searchFieldController,
                      decoration: InputDecoration(
                        hintText: 'Search ' + guardOrMember,
                        filled: true,
                        fillColor: colorChoise(3),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(200))),
                      ),
                    ),
                    (noResult != null)
                        ? SizedBox(
                            height: height(context) / 2.3,
                            child: Center(child: noResult!),
                          )
                        : SizedBox(
                            height: height(context) / 2.3,
                            child: (_result.isEmpty && noResult == null)
                                ? ListView.builder(
                                    itemCount: isGuard
                                        ? guards.length
                                        : residents.length,
                                    itemBuilder: (context, index) {
                                      var data = isGuard
                                          ? guards[index].name
                                          : residents[index].name;
                                      return InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return isGuard
                                                    ? guardAlertDialog(
                                                        guards[index])
                                                    : residentAlertDialog(
                                                        residents[index]);
                                              });
                                        },
                                        child: MyCustomContainer(
                                          radius: 10,
                                          background: 3,
                                          child: Text(data.toString()),
                                        ),
                                      );
                                    })
                                : ListView.builder(
                                    itemBuilder: (context, index) {
                                      var data = _result[index].name;
                                      return InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return isGuard
                                                    ? guardAlertDialog(
                                                        _result[index])
                                                    : residentAlertDialog(
                                                        _result[index]);
                                              });
                                        },
                                        child: MyCustomContainer(
                                          radius: 10,
                                          background: 3,
                                          child: Text(data.toString()),
                                        ),
                                      );
                                    },
                                    itemCount: _result.length,
                                  ),
                          ),
                  ],
                ),
              )
            ],
          ),
        ));
  }

  guardAlertDialog(Guard guard) {
    return AlertDialog(
      content: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        height: 300,
        width: 300,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/myphoto.jpeg'),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3, color: colorChoise(0))),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          MyCustomContainer(
                            height: 50,
                            width: 50,
                            padding: 5,
                            radius: 10,
                            background: 2,
                            child: SvgPicture.asset(
                              'assets/icons/edit.svg',
                              height: 30,
                            ),
                          ),
                          Text('Edit')
                        ],
                      )),
                  InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          MyCustomContainer(
                            height: 50,
                            width: 50,
                            padding: 5,
                            radius: 10,
                            background: 2,
                            child: SvgPicture.asset(
                              'assets/icons/delete.svg',
                              height: 30,
                            ),
                          ),
                          Text('Delete')
                        ],
                      )),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Joining   :'),
              Text(
                "${guard.dateOfJoining.day}/${guard.dateOfJoining.month}/${guard.dateOfJoining.year}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('name   :'),
              Text(
                "${guard.name}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Contact   :'),
              Text(
                "${guard.contact}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Unique Id   :'),
              Text(
                "${guard.uniqueId}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ]),
      ),
    );
  }

  residentAlertDialog(Resident resident) {
    return AlertDialog(
      content: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
        height: 300,
        width: 300,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 130,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/myphoto.jpeg'),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 3, color: colorChoise(0))),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          MyCustomContainer(
                            height: 50,
                            width: 50,
                            padding: 5,
                            radius: 10,
                            background: 2,
                            child: SvgPicture.asset(
                              'assets/icons/edit.svg',
                              height: 30,
                            ),
                          ),
                          Text('Edit')
                        ],
                      )),
                  InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          MyCustomContainer(
                            height: 50,
                            width: 50,
                            padding: 5,
                            radius: 10,
                            background: 2,
                            child: SvgPicture.asset(
                              'assets/icons/delete.svg',
                              height: 30,
                            ),
                          ),
                          Text('Delete')
                        ],
                      )),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Building   :'),
              Text(
                resident.buildingName,
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Flat No   :'),
              Text(
                "${resident.flatNo}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('name   :'),
              Text(
                "${resident.name}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Contact   :'),
              Text(
                "${resident.contact}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Unique Id   :'),
              Text(
                "${resident.uniqueId}",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
