import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vtop/UI/HomeScreen.dart';

class MyAccountsPage extends StatefulWidget {
  @override
  _MyAccountsPageState createState() => _MyAccountsPageState();
}

class _MyAccountsPageState extends State<MyAccountsPage> {
  @override
  Widget build(BuildContext context) {
    final firstTabColor = Color(0xFF1e1e44);
    final avatarColor = Color(0xFFef5c6e);
    return Scaffold(
      backgroundColor: firstTabColor,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              //  image: DecorationImage(
              //    image: AssetImage('assets/images/accounts.jpg',
              //    ),
              //    fit: BoxFit.cover,
              //  ),
            ),
          ),
          Container(
              margin: EdgeInsetsDirectional.only(
                top: MediaQuery.of(context).size.height * 0.10,
                start: MediaQuery.of(context).size.width * 0.23,
              ),
              child: CircleAvatar(
                maxRadius: 120,
                backgroundColor: avatarColor,
                backgroundImage: AssetImage('assets/images/accounts.jpg'),
              )),
          Container(
              margin: EdgeInsetsDirectional.only(
                top: MediaQuery.of(context).size.height * 0.45,
                start: MediaQuery.of(context).size.width * 0.27,
              ),
              child: Container(
                  margin: EdgeInsetsDirectional.only(
                      start: MediaQuery.of(context).size.width / 25),
                  child: Text("Somsubro Banerjee",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)))),
          Container(
              margin: EdgeInsetsDirectional.only(
                top: MediaQuery.of(context).size.height * 0.5,
                start: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Container(
                  margin: EdgeInsetsDirectional.only(
                      start: MediaQuery.of(context).size.width / 25),
                  child: Text("somsubro.18BCE7011@vtiap.ac.in",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)))),
          Container(
              margin: EdgeInsetsDirectional.only(
                top: MediaQuery.of(context).size.height * 0.6,
                start: MediaQuery.of(context).size.width * 0.1,
              ),
              child: Container(
                  margin: EdgeInsetsDirectional.only(
                      start: MediaQuery.of(context).size.width / 25),
                  child: Text("Branch: B Tech CSE",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))))
        ],
      ),
    );
  }
}
