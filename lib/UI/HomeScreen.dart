import 'package:curved_drawer/curved_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:random_color/random_color.dart';
import 'Activities.dart';
import 'dart:ui';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vtop/Authentication/auth.dart';
import 'package:vtop/UI/MyAccountPage.dart';
import 'package:vtop/UI/VtopPage.dart';
import 'package:flutter_icons/flutter_icons.dart';
class DrawerItem {
  String title;
  IconData icon;
  Color color;
  DrawerItem(this.title, this.icon, this.color);
}

class ExtendedHome extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("My Account", AntDesign.user, Colors.red),
    new DrawerItem("Activities", Entypo.star_outlined, Colors.blue),
    new DrawerItem("VTOP", AntDesign.weibo_circle, Colors.amber),
    new DrawerItem("Teacher Database", Entypo.database, Colors.green),
    new DrawerItem("About", Entypo.notification, Colors.white),
    new DrawerItem("Logout", Entypo.log_out, Colors.purple),
  ];
  @override
  _ExtendedHomeState createState() => _ExtendedHomeState();
}

RandomColor _randomColor = RandomColor();
Color _color = _randomColor.randomColor(colorBrightness: ColorBrightness.dark);

class _ExtendedHomeState extends State<ExtendedHome> {
  int _selectedDrawerIndex = 1;
  final titles = [
    new Text("Account Management"),
    new Text(
      "Extended",
      style: TextStyle(
          letterSpacing: 6,
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold),
    ),
    new Text("VTOP"),
    new Text("Teachers"),
    new Text("About the App"),
    new Text("Logout")
  ];

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new MyAccountsPage();
      case 1:
        return new Activities();
      case 2:
        return new VtopPage();

      default:
        return Center(
            child: new Text(
          "Page under construction!",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ));
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }

  String name;
  String email;
  String imageUrl;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;
  FirebaseAuth auth;

  @override
  void initState() {
    super.initState();
    auth = FirebaseAuth.instance;
    getCurrentUser();
  }
 
  getCurrentUser() async {
    user = await auth.currentUser();
    // user.isEmailVerified;
    // print("Hello " + user.email.toString());
    setState(() {});
  }

  final backgroundColor = Color(0xFF2c2c2c);
  final firstTabColor = Color(0xFF1d1d1d);
  final drawerColor = Color(0xFF545353);
  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
        new ListTile(
        leading: new Icon(
          d.icon,
          color: d.color,
        ),
        title: new Text(
          d.title,
          style: TextStyle(color: Colors.white),
        ),
        selected: i == _selectedDrawerIndex,
        onTap: () => _onSelectItem(i),
      ));
    }

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: backgroundColor,
        centerTitle: true,
        title: titles[_selectedDrawerIndex],
      ),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                  color: firstTabColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
              accountName: Text(
                "Somsubro Banerjee",
              ),
              accountEmail: Text("somsubro.18BCE7011@vitap.ac.in"),
              currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text("S",
                      style: TextStyle(fontSize: 30, color: Colors.black))),
            ),
            new Column(children: drawerOptions)
          ],
        ),
      ),
      backgroundColor: backgroundColor,
      body: _getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
