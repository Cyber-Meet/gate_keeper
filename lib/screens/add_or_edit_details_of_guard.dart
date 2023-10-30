import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';

class AddOrEditGuards extends StatefulWidget {
  final bool isEditPage;
  const AddOrEditGuards({super.key, required this.isEditPage});

  @override
  State<AddOrEditGuards> createState() => _AddOrEditGuardsState(isEditPage);
}

class _AddOrEditGuardsState extends State<AddOrEditGuards> {
  final bool isEditPage;
  _AddOrEditGuardsState(this.isEditPage);
  DateTime? postDate;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String maleOrFemale = 'Male';
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _uniqueIdController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              height: height(context) / 1.6,
              background: 1,
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: colorChoise(3)),
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Post Date :',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 20, color: colorChoise(5)),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            (postDate == null)
                                ? 'Select your post date'
                                : DateFormat('d/M/y').format(postDate!),
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            postDate = await showDatePicker(
                                context: context,
                                initialDate: (postDate == null)
                                    ? DateTime.now()
                                    : DateTime(postDate!.year, postDate!.month,
                                        postDate!.day),
                                firstDate: DateTime.parse('20200601'),
                                lastDate: DateTime.parse('20231212'));
                            log(postDate.toString());
                            setState(() {});
                          },
                          icon: SvgPicture.asset(
                            'assets/icons/calendar.svg',
                            height: 60,
                            width: 60,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          'Gender',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 50,
                        width: 120,
                        padding: EdgeInsets.only(left: 6),
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
                            onChanged: (value) {
                              maleOrFemale = value.toString();
                              setState(() {});
                            }),
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
                            'Guard Name'.padRight(15),
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
                  MyCustomButton(
                    name: 'Add',
                    callback: () {},
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
