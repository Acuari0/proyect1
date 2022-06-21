/* Johan Guillen
  Pass: Dedicado a Sylvi y la Potra <3
*/

import 'package:biomagnapro/Database/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class AuthService{
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<String> signIn({String email, String password}) async{


    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return "Entro";
    } on FirebaseAuthException catch (e){
      print(e.message);
      return e.message;
    }
  }

  Future<String> signUp ({UserC user, String password}) async{
    try{
      DatabaseReference itemRef;
      final GlobalKey<FormState> formKey = GlobalKey<FormState>();
      final FirebaseDatabase database = FirebaseDatabase.instance; //Rather then just writing FirebaseDatabase(), get the instance.
      itemRef = database.reference().child('users');
      await _firebaseAuth.createUserWithEmailAndPassword(email: user.email, password: password);
      itemRef.push().set(user.toJson());
      return "Entro";
    } on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  Future<String> ResetPassword({String email}) async{
    try{
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return "Entro";
    } on FirebaseAuthException catch(e){
      return e.message;
    }
  }

  Future<String> signOut ({String email, String password}) async{
    await _firebaseAuth.signOut();
  }
}