import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';
import 'package:my_gate_app/firebase_services/firebase_auth_services.dart';
import 'package:my_gate_app/firebase_services/firebase_database_service.dart';

class AddBuilding extends StatefulWidget {
  const AddBuilding({super.key});

  @override
  State<AddBuilding> createState() => _AddBuildingState();
}

class _AddBuildingState extends State<AddBuilding> {
  final _buildingNameController = TextEditingController();
  final _wingController = TextEditingController();
  final _floorsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      body: SizedBox(
        height: height(context),
        child: ListView(children: [
          basicComponents('Building', 'assets/icons/building.svg'),
          MyCustomContainer(
            radius: 20,
            background: 1,
            height: height(context) / 2,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  fields('Building Name', _buildingNameController),
                  fields('Wing', _wingController),
                  fields('Floors', _floorsController, TextInputType.number),
                  SizedBox(
                    height: height(context) / 6.5,
                  ),
                  MyCustomButton(
                      name: 'Save',
                      callback: () {
                        if (_formKey.currentState!.validate()) {
                          MyFirebaseDatabase.addData(
                              {
                                'Name': _buildingNameController.text + '-' +
                                    _wingController.text,
                                'Floors': int.parse(_floorsController.text)
                              },
                              "${MyFirebaseAuth.userName}/Buildings/" +
                                  _buildingNameController.text +'-'+
                                  _wingController.text);
                        }
                      })
                ],
              ),
            ),
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }

  Widget fields(String name, TextEditingController controller,
      [keyboardType = TextInputType.name]) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(
            width: 250,
            child: TextFormField(
              keyboardType: keyboardType,
              validator: RequiredValidator(errorText: name + 'is required'),
              controller: controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: colorChoise(3),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: colorChoise(3))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
