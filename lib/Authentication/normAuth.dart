import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


FirebaseUser user;
final FirebaseAuth _auth = FirebaseAuth.instance;
final _formKey = GlobalKey<FormState>();


Future<bool> isUserLoggedIn() async {
  var user = await _auth.currentUser();
  return user != null;
}
LoginUser(String username, String password) async {
  String email;
  String pwd;
  if(validateAndSave()){
    isUserLoggedIn();
    try{
      user = (await _auth.signInWithEmailAndPassword(email: email, password: pwd)).user;
      print("Login successful");

    }catch(error){
      switch(error.code){
        case "ERROR_USER_NOT_FOUND": {
          print("No user found");
        }
        break;
        case "ERROR_WRONG_PASSWORD":
          {
            print("Wong password");
          }
          break;
        default:
          {
            print("no internet");
          }
      }
    }
  }
}

bool validateAndSave()
  {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      return true;
    }
    return false;
  }


