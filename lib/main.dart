import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_gate_app/firebase_options.dart';
import 'package:my_gate_app/screens/choose_your_type.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android
    );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),

        // useMaterial3: true
      ),

      // ignore: prefer_const_constructors
      home: ChooseUserType(),
    );
  }
}
