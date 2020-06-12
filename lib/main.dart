import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtop/Authentication/auth.dart';
import 'package:vtop/Authentication/wrapper.dart';
import 'Authentication/Login.dart';
import 'Authentication/user.dart';
import 'UI/forgotPass.dart';

// import './UI/SplashScreen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Wrapper(),
        },
      ),
    );
  }
}
