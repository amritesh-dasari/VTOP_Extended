import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtop/Authentication/Login.dart';
import 'Authentication/forgotPass.dart';
import 'Authentication/Login.dart';
import 'Authentication/Signup.dart';
// import './UI/SplashScreen.dart';
void main() {
  runApp(
    MaterialApp(
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    ),
  );
}