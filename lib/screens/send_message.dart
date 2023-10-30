import 'package:flutter/material.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';

class SendMessagePage extends StatefulWidget {
  const SendMessagePage({super.key});

  @override
  State<SendMessagePage> createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
  var reason = TextEditingController();
  var visitorName = TextEditingController();
  var phoneNumber = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      bottomNavigationBar: BottomNavigation(),
      body: ListView(children: [
        basicComponents('Approve', 'assets/icons/approval.png'),
        Container(
          height: 450,
          width: double.maxFinite,
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
          decoration: containerDecoration(1, 20),
          child: Column(
            children: [
              MyCustomContainer(
                width: 330,
                height: 50,
                radius: 10,
                background: 3,
                child: const Center(
                  child: Text(
                    '1001-Nita Ambani',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              MyCustomTextField1(
                a: visitorName,
                hint: 'Enter Visitor Name',
                maxLines: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              MyCustomTextField1(
                a: reason,
                hint: 'Enter Reason', maxLines: 5),
              const SizedBox(
                height: 10,
              ),
              MyCustomTextField1(
                a: phoneNumber,
                hint: 'Enter Visitor Phone number',
                maxLines: 1,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SelectFeaterus(
                    name: 'Send',
                    path: 'assets/icons/sent.svg',
                    padding: 10,
                  ),
                  SelectFeaterus(
                    name: 'Call',
                    path: 'assets/icons/call.svg',
                    padding: 10,
                  ),
                ],
              )
            ],
          ),
        )
      ]),
    );
  }
}
