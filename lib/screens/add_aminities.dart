import 'package:flutter/material.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';

class AddAminities extends StatefulWidget {
  const AddAminities({super.key});

  @override
  State<AddAminities> createState() => _AddAminitiesState();
}

class _AddAminitiesState extends State<AddAminities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      body: ListView(
        children: [
          basicComponents('  Aminities', 'assets/icons/amenities.svg'),
          Container(
            height: 470,
            width: 400,
            margin: const EdgeInsets.all(10),
            decoration: containerDecoration(1, 20),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 250,
                    height: 250,
                    decoration: containerDecoration(2, 20, 4),
                    child: const Center(
                        child: Text(
                      'Tap to browse Image',
                      style: TextStyle(fontSize: 20, color: Colors.grey),
                    )),
                  ),
                  // MyCustomTextField(
                  //   hint: "Name :",
                  // )
                  const SizedBox(height: 20,),
                  TextField(
                    style: const TextStyle(fontSize: 15),
                    decoration: InputDecoration(
                      hintText: "Name :",
                      hintStyle: const TextStyle(fontSize: 15),
                      filled: true,
                      fillColor: colorChoise(3),
                      border: borderDecoration(3, 3),
                      enabledBorder: borderDecoration(3, 3),
                      focusedBorder: borderDecoration(3, 10)
                    ),
                  ),
                   const SizedBox(height: 20,),
                MyCustomButton(name: 'Add Amenity', callback: (){})
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
