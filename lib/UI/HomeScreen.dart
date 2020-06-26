import 'package:curved_drawer/curved_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:random_color/random_color.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'dart:ui';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:vtop/Authentication/auth.dart';
import 'package:vtop/UI/MyAccountPage.dart';
import 'package:vtop/UI/VtopPage.dart';
// import 'package:vtop/Authentication/googleAuth.dart';
class ExtendedHome extends StatefulWidget {
  @override
  _ExtendedHomeState createState() => _ExtendedHomeState();
}
RandomColor _randomColor = RandomColor();
Color _color = _randomColor.randomColor(
    colorBrightness: ColorBrightness.dark
);
class _ExtendedHomeState extends State<ExtendedHome> {
  String name;
  String email;
  String imageUrl;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser user;
  FirebaseAuth auth;

  @override
  void initState(){
    super.initState();
    auth = FirebaseAuth.instance;
    getCurrentUser();
  }
  getCurrentUser() async {
    user = await auth.currentUser();
    // user.isEmailVerified;
    // print("Hello " + user.email.toString());
    setState(() {
      
    });
  }
  final backgroundColor = Color(0xFF2c2c2c);
  final firstTabColor = Color(0xFF1d1d1d);
  final drawerColor = Color(0xFF545353);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: firstTabColor,
                borderRadius: BorderRadius.circular(15)
                ),
              accountName: Text("Somsubro Banerjee",), 
              accountEmail: Text("somsubro.18BCE7011@vitap.ac.in"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("S", style:TextStyle(fontSize: 30,color: Colors.black))
                ),
              ),
            ListTile(
              title: Text("My account", style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.account_circle, color: Colors.red,),
              onTap: () {
                 Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => MyAccountsPage(),
                  transitionsBuilder: (c, anim, a2, child) => SlideTransition(child: child, position: Tween<Offset>(
                  begin: const Offset(1,0),
                  end: Offset.zero,
                  ).animate(anim),
                  ),
                  transitionDuration: Duration(milliseconds: 300)
                   )
                   );
              },
            ),
            Divider(),
            ListTile(
              title: Text("Activities",style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.local_activity,color: Colors.blue,),
              onTap: () {
                Navigator.of(context).pop();
              }
            ),
            Divider(),
            ListTile(
              title: Text("VTOP",style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.open_in_browser,color: Colors.amber,),
              onTap: (){
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (c, a1, a2) => VtopPage(),
                  transitionsBuilder: (c, anim, a2, child) => SlideTransition(child: child, position: Tween<Offset>(
                  begin: const Offset(1,0),
                  end: Offset.zero,
                  ).animate(anim),
                  ),
                  transitionDuration: Duration(milliseconds: 300)
                   )
                   );
              },
            ),
            Divider(),
            ListTile(
              title: Text("Teacher Databser",style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.dashboard, color: Colors.green,),
            ),
            Divider(height: 250,),
            ListTile(
              title: Text("Logout",style: TextStyle(color: Colors.white),),
              leading: Icon(Icons.supervised_user_circle, color: Colors.purple,),
            ),

          ],
        ),
      ),
      backgroundColor: backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, innerBoxIsSCrolled){
          return <Widget>[
            SliverAppBar(
              backgroundColor: firstTabColor,
              expandedHeight: 90,
              floating: true,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("EXTENDED", style: TextStyle(letterSpacing: 6, color: Colors.white, fontSize: 15),),
                titlePadding: EdgeInsets.all(20)
              ),
            )
          ];
        }, 
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              height: MediaQuery.of(context).size.height/6,
              width: MediaQuery.of(context).size.width/3,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Card(
                child: Center(child: Text("put you stuff here")),
              ),
            )
          ],
        ),
        ),
    );
  }
}
