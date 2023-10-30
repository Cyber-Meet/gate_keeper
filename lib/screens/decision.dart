import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';

class DecisionPage extends StatefulWidget {
  const DecisionPage({super.key});

  @override
  State<DecisionPage> createState() => _DecisionPageState();
}

class _DecisionPageState extends State<DecisionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),

      bottomNavigationBar: BottomNavigation(),
      body: ListView(
        children: [
          basicComponents('Approve Waiting', 'assets/icons/approval.png'),
          MyCustomContainer(height: 450, radius: 20, background: 1,child: Column(children: [SvgPicture.asset('assets/icons/approved.svg',height: 300,),
          const SizedBox(height: 20,),
          const Center(child: Text('Approved',style: TextStyle(fontSize: 40),))],),),
          
        ],
      ),
    );
  }
}