import 'package:firebase_database/firebase_database.dart';

class MyFirebaseDatabase {
  static Map? data;

  static FirebaseDatabase ref = FirebaseDatabase.instance;
  static addData(Map data, String path) async {
    await ref.ref(path).set(data);
  }

  static Future<Map> setData(String path) async {
    final snapShot = await ref.ref().child(path).get();
    data = snapShot.value as Map;
    Map data2 = snapShot.value as Map;
    return data2;
  }
}
