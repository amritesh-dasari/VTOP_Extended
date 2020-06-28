import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vtop/Authentication/auth.dart';
import 'package:vtop/Authentication/normAuth.dart';
import 'package:vtop/Authentication/Signup.dart';
import 'package:vtop/UI/forgotPass.dart';
// import 'package:vtop/Authentication/Authentication.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:vtop/UI/firechanges.dart';
import 'package:vtop/UI/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  LoginScreen({this.toggleView});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

String _email = "";
String _pass = "";
String error = "";

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      content: new Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  "Loading",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage('assets/images/universe.jpg'),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.66), BlendMode.darken),
                fit: BoxFit.cover)),
        child: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15,
                    left: MediaQuery.of(context).size.width * 0.1),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.33,
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: TextFormField(
                  autocorrect: true,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    Pattern pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = new RegExp(pattern);
                    if (!(regex.hasMatch(value) && value.isNotEmpty))
                      return "Please enter a valid Email-ID";
                    else
                      return null;
                  },
                  onSaved: (value) => _email = value.trim(),
                  obscureText: false,
                  onChanged: (val) {
                    setState(() => _email = val);
                  },
                  autofocus: false,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
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
                            const BorderSide(color: Colors.white, width: 1.75),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.white,
                        size: 25,
                      ),
                      hintText: "Enter your VIT-AP Email ID",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                      labelText: "Email",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.455,
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value.length < 6) {
                      return "Enter more than 6 Characters";
                    }
                    return null;
                  },
                  onSaved: (value) => _pass = value.trim(),
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  onChanged: (val) {
                    setState(() => _pass = val);
                  },
                  autofocus: false,
                  decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.white,
                      ),
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
                            const BorderSide(color: Colors.white, width: 1.75),
                      ),
                      prefixIcon: Icon(
                        Icons.security,
                        color: Colors.white,
                        size: 25,
                      ),
                      // errorText: error,
                      hintText: "Ssshhh!!! its a secret",
                      hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                      labelText: "Password",
                      labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.57,
                    left: MediaQuery.of(context).size.width * 0.7),
                child: RichText(
                    text: TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgotPassword()));
                    },
                  text: "Forgot Password ?",
                  style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          color: Colors.white,
                          blurRadius: 1.5,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w900),
                )),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.625,
                    left: MediaQuery.of(context).size.width * 0.05,
                    right: MediaQuery.of(context).size.width * 0.05),
                child: RaisedButton(
                  color: Colors.pink,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      try {
                        showAlertDialog(context);
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            _email, _pass);
                        Navigator.pop(context);
                        if (result == null) {
                          setState(() {
                            Flushbar(
                              borderRadius: 8.0,
                              title: "Invalid Password/Email",
                              message:
                                  "Please enter correct Email and Password",
                              flushbarPosition: FlushbarPosition.BOTTOM,
                              flushbarStyle: FlushbarStyle.FLOATING,
                              reverseAnimationCurve: Curves.decelerate,
                              forwardAnimationCurve: Curves.bounceIn,
                              backgroundColor: Colors.black,
                              mainButton: FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              boxShadows: [
                                BoxShadow(
                                    color: Colors.blue[800],
                                    offset: Offset(0.0, 5.0),
                                    blurRadius: 8.0)
                              ],
                              margin:
                                  EdgeInsets.only(bottom: 8, left: 8, right: 8),
                              isDismissible: true,
                              duration: Duration(seconds: 10),
                              icon: Icon(
                                Icons.error_outline,
                                color: Colors.white,
                              ),
                            )..show(context);
                          });
                        }
                      } catch (e) {
                        var errorr = e.toString();
                        print(errorr);
                      }
                    }
                  },
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                  elevation: 25,
                ),
              ),
              Center(
                child: Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.9,
                        bottom: MediaQuery.of(context).size.height * 0.05,
                        left: MediaQuery.of(context).size.width * 0.18,
                        right: MediaQuery.of(context).size.width * 0.18),
                    child: RichText(
                      text: TextSpan(
                          text: "Don't have an account ?",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800),
                          children: <TextSpan>[
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (c, a1, a2) =>
                                                SignupScreen(),
                                            transitionsBuilder: (c, anim, a2,
                                                    child) =>
                                                SlideTransition(
                                                  child: child,
                                                  position: Tween<Offset>(
                                                    begin: const Offset(1, 0),
                                                    end: Offset.zero,
                                                  ).animate(anim),
                                                ),
                                            transitionDuration:
                                                Duration(milliseconds: 300)));
                                  },
                                text: ' Sign up',
                                style: TextStyle(
                                    shadows: <Shadow>[
                                      Shadow(
                                        color: Colors.cyanAccent,
                                        blurRadius: 5.0,
                                        offset: Offset(0.0, 0.0),
                                      )
                                    ],
                                    color: Colors.cyanAccent,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800))
                          ]),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
