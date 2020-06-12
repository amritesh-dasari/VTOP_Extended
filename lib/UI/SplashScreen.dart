import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:vtop/UI/firechanges.dart';
import '../Authentication/Login.dart';

class SplashScr extends StatefulWidget {
  @override
  _SplashScr createState() => _SplashScr();
}

class _SplashScr extends State<SplashScr> {

  @override
  Widget build(BuildContext context) {
    String asset = "assets/SplashScreen.flr";
    var _size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        height: _size.height,
        width: _size.width,
        child: SplashScreen.callback(
            name: asset,
            fit:BoxFit.fitWidth,
            onSuccess: (_){
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen()));
            },
            onError: null,
            loopAnimation: 'Bounce',
            until: () => Future.delayed(Duration(milliseconds: 0)),
        ),
      ),
    );
  }
}