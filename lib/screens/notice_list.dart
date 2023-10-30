import 'package:flutter/material.dart';

import 'package:my_gate_app/customwidgets/mywidgets.dart';

import 'add_notice.dart';

class NoticeList extends StatefulWidget {
  const NoticeList({super.key});

  @override
  State<NoticeList> createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  List notices = [
    'There will be Electricity outage for an hour between 3:00 PM to 4:00 PM.',
    'There will be Electricity outage for an hour between 3:00 PM to 4:00 PM.',
    'There will be Electricity outage for an hour between 3:00 PM to 4:00 PM.'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myCustomAppBar(context),
        bottomNavigationBar: BottomNavigation(),
        body: ListView(
          children: [
            basicComponents('Notice :', 'assets/icons/notice.svg'),
            MyCustomContainer(
              height: 450,
              radius: 20,
              background: 1,
              child: MyCustomContainer(
                height: 350,
                radius: 20,
                background: 2,
                child: Column(
                  children: [
                    listViewWithDelete(notices, true),
                    const SizedBox(
                      height: 10,
                    ),
                    MyCustomButton(
                        name: 'Add New Notice',
                        callback: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddNoticePage(),
                          ));
                        })
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
