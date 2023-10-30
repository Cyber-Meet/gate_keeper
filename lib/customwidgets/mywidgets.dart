import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:intl/intl.dart';
import 'package:my_gate_app/firebase_services/firebase_database_service.dart';
import 'package:my_gate_app/screens/buildings.dart';
import 'package:my_gate_app/screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_services/firebase_auth_services.dart';
import '../screens/profile.dart';
import '../screens/settings.dart';

const String USERTYPEKEY = 'userType';

late String userType;
setUserType(String usertType) {
  userType = usertType;
}

getUserType() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  userType = (await sharedPreferences.getString(USERTYPEKEY))!;
  return userType;
}

height(BuildContext context) {
  final height = MediaQuery.of(context).size.height;
  return height;
}

width(BuildContext context) {
  final width = MediaQuery.of(context).size.width;
  return width;
}

colorChoise(int a) {
  List c = [
    const Color.fromARGB(235, 78, 1, 137),
    const Color.fromARGB(255, 247, 216, 242),
    const Color.fromARGB(255, 209, 196, 233),
    Colors.white,
    Colors.black,
    Colors.grey,
    Colors.red,
    Color.fromARGB(235, 99, 6, 175),
  ];
  return c[a];
}

myCustomAppBar(BuildContext context, [bool isProfilePage = false]) {
  return AppBar(
    forceMaterialTransparency: true,
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    leading: Padding(
      padding: EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          if (!isProfilePage) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          }
        },
        child: const CircleAvatar(
          backgroundImage: AssetImage("assets/images/myphoto.jpeg"),
        ),
      ),
    ),
    title: InkWell(
        onTap: () {
          if (!isProfilePage) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ProfilePage()));
          }
        },
        child: Text(
          MyFirebaseAuth.getName().toString(),
          style: TextStyle(color: colorChoise(0)),
        )),
    actions: [
      InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SvgPicture.asset(
              'assets/icons/notification.svg',
              height: 40,
              width: 40,
            ),
          ))
    ],
  );
}

currentDateTime() {
  DateTime d = DateTime.now();
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      height: 40,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: colorChoise(0),
          borderRadius: const BorderRadius.all(Radius.circular(7))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                'Day : ',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(DateFormat('EEEE').format(d),
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
          Row(
            children: [
              const Text(
                'Date : ',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              Text(DateFormat('d/M/y').format(d),
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    ),
  );
}

baseLine() {
  return Padding(
    padding: const EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 5),
    child: Container(
      width: double.maxFinite,
      height: 10,
      decoration: BoxDecoration(
          color: colorChoise(0),
          borderRadius: const BorderRadius.all(Radius.circular(5))),
    ),
  );
}

// ignore: must_be_immutable
class HeadingWidget extends StatelessWidget {
  String path = '';
  bool isSvg = true;
  String heading = '';
  HeadingWidget({super.key, required this.path, required this.heading});

  @override
  Widget build(BuildContext context) {
    if (!path.endsWith('.svg')) {
      isSvg = false;
    }
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      child: Row(
        children: [
          isSvg
              ? SvgPicture.asset(
                  path,
                  height: 50,
                  width: 50,
                )
              : Image.asset(
                  path,
                  height: 50,
                  width: 50,
                ),
          Text(
            '$heading ',
            style: TextStyle(fontSize: 20, color: colorChoise(0)),
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SelectFeaterus extends StatelessWidget {
  String name = '';
  String path = '';
  double padding;
  SelectFeaterus(
      {super.key, required this.name, required this.path, this.padding = 7});
  bool isSvg = true;

  @override
  Widget build(BuildContext context) {
    if (!path.endsWith('.svg')) {
      isSvg = false;
    }
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.all(padding),
          height: 70,
          width: 70,
          decoration: BoxDecoration(
              color: colorChoise(0), borderRadius: BorderRadius.circular(20)),
          child: isSvg
              ? Center(
                  child: SvgPicture.asset(
                  path,
                  height: 60,
                  width: 60,
                ))
              : Center(child: Image.asset(path, height: 60, width: 60)),
        ),
        Center(
          child: Text(name),
        )
      ],
    );
  }
}

List screens = [const MyHomePage(), const Buildings(), const SettingsScreen()];
List label = ['Home', 'Building', 'Settings'];

class BottomNavigation extends StatelessWidget {
  String name;
  BottomNavigation({super.key, this.name = ''});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        onTap: (int s) {
          if (name != label[s]) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => screens[s]));
          }
        },
        backgroundColor: colorChoise(1),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              height: 50,
              width: 50,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/building.svg',
                height: 50,
                width: 50,
              ),
              label: 'Building'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icons/s.svg',
                height: 50,
                width: 50,
              ),
              label: 'Settings'),
        ]);
  }
}

containerDecoration(int b, [double a = 10, int? borderColor]) {
  return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(a)),
      border: Border.all(
          color: borderColor != null
              ? colorChoise(borderColor)
              : Colors.transparent),
      color: colorChoise(b));
}

bottomIcons(String path, String text) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      path.endsWith('.svg')
          ? SvgPicture.asset(
              path,
              height: 60,
              width: 60,
            )
          : Image.asset(path),
      Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(text),
      )
    ],
  );
}

// ignore: must_be_immutable
class GridViewOfFeatures extends StatelessWidget {
  double height;
  List<String> imagePaths;
  List<String> nameOfFetures;
  double margin;
  List? screenList = [];
  GridViewOfFeatures(
      {super.key,
      required this.height,
      required this.imagePaths,
      required this.nameOfFetures,
      this.margin = 10,
      this.screenList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: ((context, index) {
          return InkWell(
            onTap: screenList!.isNotEmpty
                ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => screenList![index]));
                  }
                : () {},
            child: SelectFeaterus(
                // ignore: prefer_interpolation_to_compose_strings
                name: nameOfFetures[index],
                path: 'assets/icons/' + imagePaths[index]),
          );
        }),
        itemCount: imagePaths.length,
      ),
    );
  }
}

class MyCustomContainer extends StatelessWidget {
  double? height;
  double radius;
  int background;
  double? width;
  Widget? child;
  double padding;
  double margin;
  final alignment;
  MyCustomContainer(
      {super.key,
      this.margin = 10,
      this.alignment,
      this.height,
      required this.radius,
      required this.background,
      this.width = 300,
      this.child,
      this.padding = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: height,
      width: width,
      margin: EdgeInsets.all(margin),
      padding: EdgeInsets.all(padding),
      decoration: containerDecoration(background, radius),
      child: child,
    );
  }
}

basicComponents(
  String title,
  String path,
) {
  return Column(children: [
    baseLine(),
    currentDateTime(),
    Row(
      children: [
        HeadingWidget(
          path: path,
          heading: title,
        ),
      ],
    ),
  ]);
}

class MyCustomButton extends StatelessWidget {
  int color;
  double radius;
  String name;
  int textColor;
  VoidCallback callback;
  double width;
  double elevation;
  MyCustomButton(
      {super.key,
      this.color = 0,
      this.radius = 7,
      required this.name,
      this.textColor = 3,
      required this.callback,
      this.width = 300,
      this.elevation = 10});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
            elevation: elevation,
            backgroundColor: colorChoise(color),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius))),
        child: Text(name,
            style: TextStyle(color: colorChoise(textColor), fontSize: 20)),
      ),
    );
  }
}

class MyCustomTextField extends StatelessWidget {
  String? path;

  MyCustomTextField({super.key, this.path, this.hint});
  String? hint;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        style: const TextStyle(fontSize: 22),
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(fontSize: 20),
            suffixIcon: IconButton(
              onPressed: () {},
              icon: path != null
                  ? SvgPicture.asset(
                      path!,
                      width: 20,
                      height: 20,
                    )
                  : const SizedBox(),
            ),
            filled: true,
            focusedBorder: borderDecoration(1, 20),
            fillColor: colorChoise(3),
            border: borderDecoration(1, 20),
            enabledBorder: borderDecoration(1, 20)),
      ),
    );
  }
}

borderDecoration(int indexColor, double radius) {
  return OutlineInputBorder(
      borderSide: BorderSide(color: colorChoise(indexColor)),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

class MyCustomListView extends StatelessWidget {
  int itemCount;
  List name;
  String path1;
  String path2;
  double width;
  double height;
  MyCustomListView(
      {super.key,
      required this.itemCount,
      required this.name,
      this.path1 = '',
      this.path2 = '',
      this.width = 250,
      this.height = 40});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 15, top: 7),
                  width: width,
                  height: height,
                  decoration: containerDecoration(3, 6),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 6.0, left: 10),
                    child: Text(
                      name[index],
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                (path1 != '')
                    ? Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: IconButton(
                          onPressed: () {},
                          icon: (path1.endsWith('.svg'))
                              ? SvgPicture.asset(
                                  path1,
                                  width: 30,
                                  height: 30,
                                )
                              : Image.asset(
                                  path1,
                                  width: 30,
                                  height: 30,
                                ),
                        ),
                      )
                    : const SizedBox(),
                (path2.endsWith('.svg'))
                    ? IconButton(
                        onPressed: () {},
                        icon: SvgPicture.asset(
                          path2,
                          width: 30,
                          height: 30,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          );
        });
  }
}

class MyListViewBuilder extends StatelessWidget {
  List labels;
  String? path;
  MyListViewBuilder({super.key, required this.labels, this.path});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: labels.length,
        itemBuilder: ((context, index) {
          return Row(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 15, top: 7),
                decoration: containerDecoration(3, 6),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6.0, left: 10),
                  child: Text(
                    labels[index],
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ],
          );
        }));
  }
}

listViewWithDelete(List names, bool a,
    [double height = 320, double width = 200]) {
  return SizedBox(
    height: height,
    child: ListView(
      children: [
        for (int i = 0; i < names.length; i++)
          Row(
            children: [
              Expanded(
                child: Container(
                  width: width,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: containerDecoration(3),
                  child: Text(
                    '${i + 1}.  ' + names[i],
                    softWrap: true,
                  ),
                ),
              ),
              if (a)
                SvgPicture.asset(
                  'assets/icons/delete.svg',
                  height: 40,
                )
            ],
          ),
      ],
    ),
  );
}

class MyNewListView extends StatelessWidget {
  final List<String> stringList;
  final Widget? icon;
  final Widget? icon2;
  final VoidCallback? callback;

  const MyNewListView(
      {super.key,
      required this.stringList,
      this.icon,
      this.icon2,
      this.callback});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: stringList.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              Expanded(
                  child: InkWell(
                onTap: callback != null ? callback! : () {},
                child: MyCustomContainer(
                  height: 40,
                  radius: 10,
                  background: 3,
                  child: Text(
                    stringList[index],
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              )),
              if (icon != null) icon!,
              if (icon2 != null) icon2!
            ],
          );
        });
  }
}

class MyCustomTextField1 extends StatelessWidget {
  int? maxLines;
  String? hint;
  String? iconPath;
  double? height;
  String? intialText;
  TextEditingController a;
  MyCustomTextField1(
      {super.key,
      required this.a,
      this.maxLines,
      this.hint,
      this.height,
      this.iconPath,
      this.intialText});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: a,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 3, horizontal: 7),
          suffixIcon: iconPath != null
              ? IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    iconPath!,
                    height: 30,
                  ),
                )
              : null,
          hintText: hint,
          filled: true,
          fillColor: colorChoise(3),
          focusedBorder: borderDecoration(3, 10),
          enabledBorder: borderDecoration(3, 10),
        ),
        maxLines: maxLines,
      ),
    );
  }
}

class MyTextFormField extends StatelessWidget {
  final controller;
  final String lable;
  final String hint;
  final Color color;
  final double borderWidth;
  final double radius;
  final Icon? icon;
  final bool obscureText;
  final List<MultiValidator> validatorList;
  const MyTextFormField(
      {super.key,
      this.icon,
      this.obscureText = false,
      required this.radius,
      required this.borderWidth,
      required this.color,
      required this.controller,
      required this.validatorList,
      required this.lable,
      required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      obscureText: obscureText,
      controller: controller,
      validator: MultiValidator(validatorList),
      decoration: InputDecoration(
          label: Text(lable),
          hintText: hint,
          border: OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              borderSide: BorderSide(width: borderWidth)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(radius)),
              borderSide: BorderSide(color: color, width: borderWidth))),
    );
  }
}

// class MyDropDownButton extends StatefulWidget {
//   final List items;
//   var selectedItem;
//   MyDropDownButton(
//       {super.key, required this.items, required this.selectedItem});

//   @override
//   State<MyDropDownButton> createState() =>
//       _MyDropDownButtonState(valueSelected: selectedItem);
//  getSelectedItem() {
//     return selectedItem;
//   }
// }

// class _MyDropDownButtonState extends State<MyDropDownButton> {
//   var valueSelected;
//   _MyDropDownButtonState({this.valueSelected});
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//         icon: Container(
//             padding: EdgeInsets.only(bottom: 20),
//             child: Icon(
//               Icons.keyboard_arrow_down_rounded,
//               size: 40,
//               color: colorChoise(0),
//             )),
//         value: valueSelected,
//         items: widget.items.map((e) {
//           return DropdownMenuItem<String>(
//             child: Text(
//               e.toString(),
//               style: TextStyle(fontSize: 20),
//             ),
//             value: e.toString(),
//           );
//         }).toList(),
//         onChanged: (value) {
//           valueSelected = value;
//           setState(() {});
//         });
//   }
// }
// TextFormFiels with heading
userDetail(String name, TextEditingController controller, BuildContext context,
    [bool obscureText = false]) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        name,
        style: TextStyle(fontSize: 18),
      ),
      Container(
        width: 200,
        alignment: Alignment.centerRight,
        child: TextFormField(
          controller: controller,
          validator: RequiredValidator(errorText: name + 'is required'),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
              labelText: name,
              filled: true,
              fillColor: colorChoise(3),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
        ),
      ),
    ],
  );
}

late List<String> buildingList;
setBuildingList(String path) {}
Future<Map> getBuildingList() async {
  // List<String> buildingsList =
  //     buildings.getData() != null ? List<String>.from(buildings.data!.keys) : [];
  // log(buildings.data.toString());

  Map? data =
      await MyFirebaseDatabase.setData('${MyFirebaseAuth.userName}/Buildings/');
  // log(MyFirebaseDatabase.data.toString());
  // log(MyFirebaseDatabase.getData().toString());

  // Map? buildingMap = MyFirebaseDatabase.data;
  log(data.toString());
  if (data != null) {
    return data;
  } else {
    return {};
  }
}

getResedentsData() async {
  Map? data =
      await MyFirebaseDatabase.setData('${MyFirebaseAuth.userName}/Residents/');
  log(data.toString());
  if (data != null) {
    log(data.toString());
    return data;
  } else {
    return {};
  }
}
