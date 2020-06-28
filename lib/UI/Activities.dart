import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Activities extends StatefulWidget {
  Activities({Key key}) : super(key: key);

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  @override
  Widget build(BuildContext context) {
    final firstTabColor = Color(0xFF1e1e44);
    return Scaffold(
        backgroundColor: firstTabColor,
        body: Center(
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              height: MediaQuery.of(context).size.height / 6,
              width: MediaQuery.of(context).size.width / 3,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Card(
                child: Center(child: Text("put you stuff here")),
              ),
            ),
          ]),
        ));
  }
}
