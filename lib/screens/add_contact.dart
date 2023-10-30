import 'package:flutter/material.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';

class AddContact extends StatelessWidget {
  const AddContact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: myCustomAppBar(context),
      body: Column(
        children: [
          basicComponents('Add Contact', 'assets/icons/add_contact.svg'),
          MyCustomContainer(
            height: 450,
            radius: 20,
            background: 1,
            width: 350,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                ),
                child: Row(
                  children: [
                    const Text('Name  '),
                    MyCustomContainer(
                      height: 40,
                      radius: 10,
                      background: 3,
                      width: 230,
                      child: const Text('Electrician'),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                ),
                child: Row(
                  children: [
                    const Text('Service'),
                    MyCustomContainer(
                      height: 40,
                      radius: 10,
                      background: 3,
                      width: 230,
                      child: const Text('Electrician'),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  top: 20,
                ),
                child: Row(
                  children: [
                    const Text('Contact'),
                    MyCustomContainer(
                      height: 40,
                      radius: 10,
                      background: 3,
                      width: 230,
                      child: const Text('451236987'),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 130,
              ),
              SizedBox(
                  width: 300,
                  child: MyCustomButton(
                    name: 'Add to Service',
                    callback: () {},
                    radius: 10,
                  ))
            ]),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
