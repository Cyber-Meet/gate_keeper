import 'package:direct_caller_sim_choice/direct_caller_sim_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/emergency_model.dart';

class EmergencyPage extends StatelessWidget {
 EmergencyPage({super.key});
final List<Emergency> serviceList=[
  Emergency("assets/icons/ambulance.svg", "Ambulance",'108'),
  Emergency("assets/icons/police.svg", "Police",'100'),
  Emergency("assets/icons/fire.svg", "Fire",'108'),
  Emergency("assets/icons/lady.svg", "Women",'1091'),
  Emergency("assets/icons/boy.svg", "Child",'1098'),
  Emergency("assets/icons/hacker.svg", "Cyber",'1930'),
  Emergency("assets/icons/siren.svg", "112",'112'),
  Emergency("assets/icons/jacket.svg", "NDRF",'1096'),
  Emergency("assets/icons/lpg.svg", "LPG leak",'1906'),
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      body: ListView(
        children: [
          basicComponents('Emergency', 'assets/icons/siren.svg'),
          MyCustomContainer(
            height: height(context)/1.85,
            radius: 20,
            background: 1,
            child: MyCustomContainer(
              padding: 0,
              alignment: Alignment.center,
              radius: 20,
              background: 2,
              height: height(context)/1.9,
              child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3), itemBuilder: (context,index){
                return emergencyNumbers(serviceList[index].path, serviceList[index].serviceName, 40, serviceList[index].contact);
              },itemCount: serviceList.length,shrinkWrap: true,)
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

emergencyNumbers(String path, String name,double height,String contact) {
  return InkWell(
    onTap: () async {
      final Uri url = Uri(scheme: 'tel', path: contact);
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        print("Problem launching URL");
      }
    },
    child: Column(
      children: [
        MyCustomContainer(
          margin: 0,
          padding: 7,
          background: 0,
          radius: 10,
          width: 80,
          height: 80,
          
          child: SvgPicture.asset(
            path,
            height: height,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          name,
          style: TextStyle(color: colorChoise(0), fontSize: 17),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
