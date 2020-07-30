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

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(8, 4),
  const StaggeredTile.count(4, 4),
  const StaggeredTile.count(4, 6),
  const StaggeredTile.count(4, 6),
  const StaggeredTile.count(4, 4),
];

class FirstScreen extends StatelessWidget {
  final firstTabColor = Color(0xFF1d1d1d);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: firstTabColor,
        body: Padding(
          padding: EdgeInsets.only(top: 12.0),
          child: StaggeredGridView.count(
            crossAxisCount: 8,
            staggeredTiles: _staggeredTiles,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            padding: EdgeInsets.all(20.0),
            children: <Widget>[
              Container(
                child: Ink(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0,
                            color: Colors.grey.shade700,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://images.pexels.com/photos/3792581/pexels-photo-3792581.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
                            fit: BoxFit.cover)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(22),
                              onTap: () {},
                              child: Stack(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 120, left: 15),
                                  child: Text(
                                    "Event 1",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ])),
                        ))),
              ),
              Container(
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
                              borderRadius: BorderRadius.circular(22),
                              onTap: () {},
                              child: Stack(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 120, left: 15),
                                  child: Text(
                                    "Event 2",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ])),
                        ))),
              ),
              Container(
                child: Ink(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0,
                            color: Colors.grey.shade700,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://images.pexels.com/photos/3617496/pexels-photo-3617496.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
                            fit: BoxFit.cover)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(22),
                              onTap: () {},
                              child: Stack(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 210, left: 15),
                                  child: Text(
                                    "Event 3",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ])),
                        ))),
              ),
              Container(
                child: Ink(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0,
                            color: Colors.grey.shade700,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://images.pexels.com/photos/3736816/pexels-photo-3736816.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
                            fit: BoxFit.cover)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(22),
                              onTap: () {},
                              child: Stack(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 210, left: 15),
                                  child: Text(
                                    "Event 4",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ])),
                        ))),
              ),
              Container(
                child: Ink(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 1.0,
                            color: Colors.grey.shade700,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://images.pexels.com/photos/2792157/pexels-photo-2792157.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
                            fit: BoxFit.cover)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(22),
                              onTap: () {},
                              child: Stack(children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 120, left: 15),
                                  child: Text(
                                    "Event 5",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ])),
                        ))),
              ),
            ],
          ),
        ));
  }
}

class SecondScreen extends StatelessWidget {
  final seconfTabColor = Color(0xFF1d1d1d);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: seconfTabColor,
      body: Center(
        child: Text('Tab 2 Layout'),
      ),
    );
  }
}
