import 'package:flutter/material.dart';
import 'package:my_gate_app/screens/service.dart';

import '../customwidgets/mywidgets.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  List<String> name = [
    'Electrician',
    'Plumber',
    'Sewage',
    'Garbage',
    'Sweeper',
    'Carpenter',
    'Security',
    'Air Service',
    'Gardner'
  ];

  List<String> imagePaths = [
    'electricity.svg',
    'water.svg',
    'sewage.svg',
    'garbage.svg',
    'sweeper.svg',
    'carpenter.svg',
    'security.svg',
    'ac.svg',
    'garden.svg'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      body: Column(children: [
        baseLine(),
        currentDateTime(),
        HeadingWidget(
          path: 'assets/icons/service.png',
          heading: 'Service',
        ),
        MyCustomContainer(
          height: height(context)/2,
          radius: 20,
          background: 1,
          width: double.maxFinite,
          child:   MyCustomContainer(
            height: height(context)/3,
            radius: 20,
            background: 2,
            width: 350,
            child: GridViewOfFeatures(
              height: height(context)/3,
              imagePaths: imagePaths,
              nameOfFetures: name,
              margin: 20,
              screenList: [
                for (int i = 0; i < 9;i++)
                  ServicePage(serviceType:  name[i],)
              ],
            ),
          ),
        ),


      ]),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
