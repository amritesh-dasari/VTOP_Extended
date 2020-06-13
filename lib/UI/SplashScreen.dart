import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:vtop/Authentication/wrapper.dart';
class SplashScr extends StatefulWidget {
  @override
  _SplashScr createState() => _SplashScr();
}
class _SplashScr extends State<SplashScr> {
  @override
  Widget build(BuildContext context) {
    String asset = "assets/SplashScreen.flr";
    return SplashScreen.callback(
      name: asset,
      fit:BoxFit.fitWidth,
      onSuccess: (_){Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Wrapper()));},
      onError: null,
      loopAnimation: 'Bounce',
      until: () => Future.delayed(Duration(milliseconds: 0)),
    );
  }
}