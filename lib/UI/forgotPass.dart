import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vtop/Authentication/Login.dart';
import 'package:vtop/Authentication/Signup.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email = "";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool validatAndSave()
  {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      return true;
    }
    return false;
  }
  @override
  Future<void> resetPassword(String email) async {
    if(validatAndSave())
      {
        try{
          await _auth.sendPasswordResetEmail(email: _email);
        }
        catch (e){
          print(e);
        }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/void.jpg'),
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.37), BlendMode.darken),
            fit: BoxFit.cover,
          )
        ),
        child: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.05, left: MediaQuery.of(context).size.width*0.03),
                child: IconButton(
                  icon: Icon(Icons.arrow_back,
                    color: Colors.white, 
                    size: 30,
                  ),
                  onPressed: (){
                     Navigator.pop(context);
                   }
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15, left: MediaQuery.of(context).size.width*0.1),
                child: Text("FORGOT PASSWORD",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.4, left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (!(regex.hasMatch(value) && value.contains("vitap.ac.in")))
                      return "Please enter a valid Email-ID";
                    else
                      return null;
                  },
                  onSaved: (value) => _email = value.trim(),
                  obscureText: false,
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.red),
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                        const BorderSide(color: Colors.white, width: 1.75),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide:
                        const BorderSide(color: Colors.white, width: 1.75),
                    ),
                    border: const OutlineInputBorder(
                      borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 25,
                    ),
                    hintText: "Enter your VIT-AP Email ID",
                    hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white, fontSize: 18)
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.07,
                width: MediaQuery.of(context).size.width*0.9,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.5725, left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                child: RaisedButton(        
                  color: Colors.blue,
                  onPressed: () {
                    resetPassword(_email).whenComplete(() =>  setState(() {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                      String errorMsg = "Password reset link sent to email id please check";
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              child: Text(errorMsg),
                            ),
                          );
                        }
                      );
                    }));
                  },
                  child: Text(
                    "CONTINUE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  elevation: 25,
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.8,bottom: MediaQuery.of(context).size.height*0.15,left: MediaQuery.of(context).size.width*0.18, right: MediaQuery.of(context).size.width*0.18),
                  child: RichText(
                  text: TextSpan(
                    text: "Go back ? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w800
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                        text: 'Login',
                        style: TextStyle(
                          shadows: <Shadow>[
                            Shadow(
                              color: Colors.cyan,
                              blurRadius: 5.0,
                              offset: Offset(0.0, 0.0),
                            )
                          ],
                          color: Colors.cyan,
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                        )
                      )
                    ]
                  ))
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}