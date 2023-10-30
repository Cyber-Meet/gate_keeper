import 'package:flutter/material.dart';
import 'package:my_gate_app/customwidgets/mywidgets.dart';

class AddNoticePage extends StatefulWidget {
  const AddNoticePage({super.key});

  @override
  State<AddNoticePage> createState() => _AddNoticePageState();
}

class _AddNoticePageState extends State<AddNoticePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myCustomAppBar(context),
      body: ListView(
        children: [
          basicComponents('Notice', 'assets/icons/notice.svg'),
          MyCustomContainer(
            height: 450,
            radius: 20,
            padding: 25,
            background: 1,
            child: Column(
              children: [
                SizedBox(
                  
                  height: 300,
                  child: TextField(
                    
                    decoration: InputDecoration(
                      hintText:'Enter Notice Here...',
                      filled: true,
                      fillColor: colorChoise(3),
                     focusedBorder: borderDecoration(3, 20),
                     enabledBorder: borderDecoration(3, 20)
                    
                    ),
                   maxLines: 30,
                  ),
                ),
                const SizedBox(height: 30,),
                MyCustomButton(name: 'Add Notice', callback: (){},width: 200,)
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar:  BottomNavigation(),
    );
  }
}
