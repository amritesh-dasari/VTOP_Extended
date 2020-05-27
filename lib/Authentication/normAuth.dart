import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

FirebaseUser user;
 final _formKey = GlobalKey<FormState>();
 final FirebaseAuth _auth = FirebaseAuth.instance;
 bool validatAndSave()
  {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

   Future<bool> isUserLoggedIn() async {
    var user = await _auth.currentUser();
    return user != null;
  }
  
   validateAndLogin() async
  {
    if(validatAndSave()) {
      isUserLoggedIn();
      try {

        FirebaseUser user;
        String _email;
        String _pass;
                user = (await _auth.signInWithEmailAndPassword(
                    email: _email, password: _pass)).user;

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExtendedHome()));
        print('Login successfull user id is  : ${user.uid}');
      } catch (error) {
        switch(error.code){
          case "ERROR_USER_NOT_FOUND":  {
            setState(() {
              String errorMsg = "User not Registered";
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            });
          }
          break;
          case "ERROR_WRONG_PASSWORD":
            {
              setState(() {
                String errorMsg = "Password doesn\'t match your email.";


                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMsg),
                        ),
                      );
                    });
              });
            }
            break;
          default:
            {
              setState(() {
                String errorMsg ="";
              });
            }
        }
      }
    }

    }
