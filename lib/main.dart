import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtop/Authentication/auth.dart';
import 'package:vtop/UI/HomeScreen.dart';
import 'package:vtop/UI/SplashScreen.dart';
import 'Authentication/user.dart';
void main() => runApp(MyApp());
final backgroundColor = Color(0xFF2c2c2c);
// final drawerColor = Color(0xFF363636);
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        theme: new ThemeData(
          canvasColor: backgroundColor,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {'/': (context) => ExtendedHome(),},
      ),
    );
  }
}