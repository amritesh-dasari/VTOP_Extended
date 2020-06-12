import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Authentication/user.dart';



class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on FIrebaseUser
  User _userFormFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFormFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFormFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFormFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFormFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}


// FirebaseUser user;
// final FirebaseAuth _auth = FirebaseAuth.instance;
// final _formKey = GlobalKey<FormState>();


// Future<bool> isUserLoggedIn() async {
//   var user = await _auth.currentUser();
//   return user != null;
// }
// LoginUser(String username, String password) async {
//   String email;
//   String pwd;
//   if(validateAndSave()){
//     isUserLoggedIn();
//     try{
//       user = (await _auth.signInWithEmailAndPassword(email: email, password: pwd)).user;
//       print("Login successful");

//     }catch(error){
//       switch(error.code){
//         case "ERROR_USER_NOT_FOUND": {
//           print("No user found");
//         }
//         break;
//         case "ERROR_WRONG_PASSWORD":
//           {
//             print("Wong password");
//           }
//           break;
//         default:
//           {
//             print("no internet");
//           }
//       }
//     }
//   }
// }

// bool validateAndSave()
//   {
//     if(_formKey.currentState.validate()){
//       _formKey.currentState.save();
//       return true;
//     }
//     return false;
//   }


