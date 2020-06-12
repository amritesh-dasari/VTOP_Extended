import 'package:flutter/material.dart';
import 'package:vtop/Authentication/Login.dart';
import 'package:vtop/Authentication/Signup.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool initialSignIN = true;
  void toggleView() {
    setState(() => initialSignIN = !initialSignIN);
  }

  @override
  Widget build(BuildContext context) {
    if (initialSignIN) {
      return LoginScreen(toggleView: toggleView);
    } else {
      return SignupScreen(toggleView: toggleView);
    }
  }
}
