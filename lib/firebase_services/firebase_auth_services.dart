import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
//Added
class MyFirebaseAuth {
  static String? adminName;
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static String? uid;
  static String? phone;
  static String? userName;
  static Future createUser(String email, String password) async {
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      userName = firebaseAuth.currentUser!.email.toString().split('@')[0];
      log(userName.toString());
      uid ??= firebaseAuth.currentUser!.uid;
    });
  }

  static Future signInUser(String email, String password) async {
    try {
      return await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        uid ??= firebaseAuth.currentUser!.uid;
      });
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
  }

  static signOutUser() async {
    await firebaseAuth.signOut();
  }

  static setName(String name) async {
    await firebaseAuth.currentUser?.updateDisplayName(name);
    adminName = firebaseAuth.currentUser!.displayName.toString();
  }

  static getName() {
    adminName ??= firebaseAuth.currentUser!.displayName;
    return adminName;
  }
}
