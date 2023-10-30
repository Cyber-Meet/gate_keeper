import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  DateTime d = DateTime.now();
  List buildings = ['Building1', 'Building2', 'Building3', 'Building4'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      bottomNavigationBar: BottomNavigation(),
      body: ListView(children: [
        basicComponents('  Register', 'assets/icons/register.svg'),
        MyCustomContainer(
          height: 470,
          radius: 20,
          background: 1,
          child: Column(
            children: [
              Container(
                width: 350,
                height: 50,
                decoration: containerDecoration(3,20),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat('d/M/y').format(d),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2004),
                            lastDate: DateTime(2025));
                        if (dateTime != null) {
                          setState(() {
                            d = dateTime;
                          });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(
                          'assets/icons/calendar.svg',
                          height: 30,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              MyCustomContainer(
                height: 350,
                radius: 20,
                background: 2,
                width: 350,
                child: listViewWithDelete(buildings, false),
              )
            ],
          ),
        )
      ]),
    );
  }
}
