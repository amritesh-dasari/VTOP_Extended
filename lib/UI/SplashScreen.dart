import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//import 'package:vtop/UI/firechanges.dart';
import 'HomeScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/void.jpg'),
                  fit: BoxFit.cover,
                  ),
                ),
        ),

        Container(
          margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.7, left:MediaQuery.of(context).size.width*0.3, right:MediaQuery.of(context).size.width*0.3 ),
          child: Text("Continue", 
          
          style: TextStyle(color: Colors.white,
          fontSize: 45,
          )),
        ),

        Container(
          margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.8, left:MediaQuery.of(context).size.width*0.4, right:MediaQuery.of(context).size.width*0.3 ),
          child: IconButton(icon: Icon(Icons.arrow_forward, size: 50, color: Colors.white,),
            onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => ExtendedHome()));
            },
          ),
        )
        
        ],       
      ),
    );
  }
}