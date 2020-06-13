import 'package:flutter/material.dart';
import 'package:vtop/Authentication/authenticate.dart';
import 'package:vtop/Authentication/user.dart';
import 'package:provider/provider.dart';
import 'package:vtop/UI/HomeScreen.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return ExtendedHome();
    }
  }
}