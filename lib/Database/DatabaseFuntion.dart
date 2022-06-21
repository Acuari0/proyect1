import 'dart:async';

import 'package:biomagnapro/Database/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
class DatabaseService {
  UserC userC = UserC("", " ",  0,0,  0,0,  0,0,  0,0,  0,0,  0,0,  0,0,  0,0,  0,0);
  bool data = false;

  static Future<UserC> getUser() async {
    Completer<UserC> completer = new Completer<UserC>();
    UserC userC;
    FirebaseDatabase.instance
        .reference()
        .child("users")
        .once()
        .then((DataSnapshot snapshot) {
//here i iterate and create the list of objects
      Map<dynamic, dynamic> yearMap = snapshot.value;
      yearMap.forEach((key, value) {
        if (value["Email"] == FirebaseAuth.instance.currentUser.email) {
          print(value["Nombre"]);
          userC = UserC(key, value["Email"], value["Creditos"],value["Treat"],
          value["N1"],value["N2"],value["N3"],value["N4"],value["N5"],value["N6"],value["N7"],value["N8"],
            value["S1"],value["S2"],value["S3"],value["S4"],value["S5"],value["S6"],value["S7"],value["S8"],);
        }
      });
      completer.complete(userC);
    });
    return completer.future;
  }
}