import 'package:flutter/material.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';
import 'package:my_gate_app/screens/add_aminities.dart';

class AminitiesShowPage extends StatefulWidget {
  const AminitiesShowPage({super.key});

  @override
  State<AminitiesShowPage> createState() => _AminitiesShowPageState();
}

class _AminitiesShowPageState extends State<AminitiesShowPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      body: ListView(
        children: [
          baseLine(),
          currentDateTime(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HeadingWidget(
                  path: 'assets/icons/amenities.svg', heading: "  Amenities"),
              Padding(
                padding: const EdgeInsets.only(right: 30),
                child: MyCustomButton(
                  name: "Add",
                  callback: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddAminities()));
                  },
                  width: 150,
                  radius: 20,
                ),
              )
            ],
          ),
          MyCustomContainer(
            height: 450,
            radius: 20,
            background: 1,
            child: Column(children: [
              Container(
                margin: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                    border: Border.all(width: 3, color: colorChoise(0))),
                child: Image.asset(
                  'assets/images/myphoto.jpeg',
                  height: 250,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyCustomContainer(
                height: 60,
                radius: 10,
                background: 3,
                child: const Center(
                    child: Text(
                  'Swimming',
                  style: TextStyle(fontSize: 25),
                )),
              )
            ]),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
