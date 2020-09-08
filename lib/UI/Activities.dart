import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Activities extends StatefulWidget {
  Activities({Key key}) : super(key: key);

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  AsyncSnapshot<QuerySnapshot> snapshot;
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color(0xFF2c2c2c);
    final firstTabColor = Color(0xFF1d1d1d);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: TabBar(
            indicatorColor: Colors.purpleAccent,
            labelColor: Colors.purpleAccent.shade100,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                child: Container(
                    child: Text(
                  "EVENTS",
                  style: TextStyle(letterSpacing: 1.5, fontSize: 16),
                )),
              ),
              Tab(
                child: Container(
                    child: Text(
                  "CLUBS",
                  style: TextStyle(letterSpacing: 1.5, fontSize: 16),
                )),
              ),
            ],
          ),
          body: TabBarView(
            children: [
              FirstScreen(),
              SecondScreen(),
            ],
          ),
        ));
  }
}

class FirstScreen extends StatelessWidget {
  final firstTabColor = Color(0xFF1d1d1d);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: firstTabColor,
        body: Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('events').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                return StaggeredGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  padding: EdgeInsets.fromLTRB(15, 18, 15, 5),
                  children: snapshot.data.documents
                      .map((doc) => buildItem(doc))
                      .toList(),
                  staggeredTiles:
                      generateRandomTiles(snapshot.data.documents.length),
                );
              },
            )));
  }
}

class SecondScreen extends StatelessWidget {
  final seconfTabColor = Color(0xFF1d1d1d);
  final List Clubs = [
    "Android Club",
    "Open Source Community",
    "Developer Student's Club",
    "Null Chapter"
  ];
  final List clubtype = ["Technical", "Technical", "Technical", "Technical"];
  @override
  Firestore firestore;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: Clubs.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 5,
                color: Colors.white, //Color(0xFF2c2c2c),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Container(
                      child: Text("VIT"),
                    ),
                  ),
                  title: Text(
                    Clubs[index],
                    style: TextStyle(color: Colors.black //Colors.white
                        ),
                  ),
                  subtitle: Text(clubtype[index]),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ClubDetails()));
                  },
                  //onTap: () =>
                  //debugPrint("Club Name: ${Clubs.elementAt(index)}"),
                ),
              );
            }),
      ),
    );
  }
}

class ClubDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CLUBS"),
        backgroundColor: Color(0xFF2c2c2c),
      ),
      body: Center(
        child: Container(
          child: RaisedButton(
            child: Text("Go Back"),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

generateRandomTiles(int count) {
  Random rnd = new Random();
  List<StaggeredTile> _staggeredTiles = [];
  for (int i = 0; i < count; i++) {
    num mainAxisCellCount = 0;
    double temp = rnd.nextDouble();

    if (temp > 0.6) {
      mainAxisCellCount = temp + 0.5;
    } else if (temp < 0.3) {
      mainAxisCellCount = temp + 0.9;
    } else {
      mainAxisCellCount = temp + 0.7;
    }
    _staggeredTiles.add(new StaggeredTile.count(1, mainAxisCellCount));
  }
  return _staggeredTiles;
}

Card buildItem(DocumentSnapshot doc) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    color: Colors.white,
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                width: 1.0,
                color: Colors.grey.shade700,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    "https://images.pexels.com/photos/3667816/pexels-photo-3667816.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500"))),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    '${doc.data['name']}',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Container buildStuff(DocumentSnapshot doc) {
  return Container(
    child: Ink(
        decoration: BoxDecoration(
            border: Border.all(
                width: 1.0,
                color: Colors.grey.shade700,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: NetworkImage(
                    'https://images.pexels.com/photos/3667816/pexels-photo-3667816.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
                fit: BoxFit.cover)),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
              child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {},
                  child: Stack(children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 120, left: 15),
                      child: Text(
                        "${doc.data['name']}",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    )
                  ])),
            ))),
  );
}
