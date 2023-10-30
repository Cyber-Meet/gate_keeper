import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../customwidgets/mywidgets.dart';
import 'add_contact.dart';

class ServicePage extends StatefulWidget {
 final String serviceType;
  const ServicePage({super.key,required this.serviceType});

  @override
  State<ServicePage> createState() => _ServicePageState(serviceType);
}

class _ServicePageState extends State<ServicePage> {
  final String serviceType;
  _ServicePageState(this.serviceType);
  List<String> name = [
    'Abhishek',
    'Jay',
    'Meet'

  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      body: Column(
        children: [
          basicComponents('Service', 'assets/icons/service.png'),
          Container(
            height: height(context)/2,
            width: double.maxFinite,
            margin: const EdgeInsets.all(15),
            
            decoration: containerDecoration(1, 20),
            child: Column(
              children: [
                MyCustomContainer(
                  padding: 4,
                  radius: 10,background: 3,child: Text(serviceType.toString(),textAlign: TextAlign.center,style: TextStyle(fontSize: 20),),),

                Container(
                  
                  height: height(context)/3.44,

                  margin: const EdgeInsets.only(bottom: 5,top: 10),
                  child: ListView.builder(
                      itemCount: name.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only( left: 15,top: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 15),
                                  
                                  height: 35,
                                  decoration: containerDecoration(3, 6),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0, left: 10),
                                    child: Text(name[index],style: const TextStyle(fontSize: 20),),
                                  ),
                                ),
                              ),
                              IconButton(
                                onPressed: () {},
                                
                                icon: SvgPicture.asset('assets/icons/call.svg',height: 30,),
                              ),
                              IconButton(
                                onPressed: () {},
                                
                                icon: SvgPicture.asset('assets/icons/edit.svg',height: 30,),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                    Padding(
                      padding: const EdgeInsets.all(13.0),
                      child: MyCustomButton(name: 'Add Service Contact', callback: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context) => AddContact(),));
                      },),
                    ),
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar:  BottomNavigation(),
    );
  }
}
