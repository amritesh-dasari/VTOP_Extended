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

  int index = 0;
  final List<String> images = [
    'assets/images/universe.jpg',
    'assets/images/accounts.jpg',
    'assets/images/google.png',
    'assets/images/Space.png',
    'assets/images/void.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final firstTabColor = Color(0xFF1e1e44);
    return Scaffold(
      backgroundColor: firstTabColor,
      // body: ListView(
      //   padding: EdgeInsets.only(
      //       top: MediaQuery.of(context).size.height * 0.025,
      //       left: MediaQuery.of(context).size.width * 0.025,
      //       right: MediaQuery.of(context).size.width * 0.025),
      //   children: [
      //     Container(
      //       height: MediaQuery.of(context).size.height * 0.225,
      //       color: firstTabColor,
      //       child: Swiper(
      //         itemBuilder: (BuildContext context, int index) {
      //           return GestureDetector(
      //             child: ClipRRect(
      //               borderRadius: BorderRadius.circular(10),
      //               child: Container(
      //                   // width: 300,
      //                   // height: 200,
      //                   decoration: BoxDecoration(
      //                       image: DecorationImage(
      //                 image: AssetImage(
      //                   images[index],
      //                 ),
      //                 fit: BoxFit.cover,
      //               ))),
      //             ),
      //           );
      //         },
      //         itemCount: 5,
      //         viewportFraction: 0.9,
      //         scale: 0.9,
      //         itemWidth: 300,
      //         itemHeight: 300,
      //         layout: SwiperLayout.STACK,
      //       ),
      //     ),
      //     Container(
      //         child: StreamBuilder<QuerySnapshot>(
      //       stream: Firestore.instance.collection('posts').snapshots(),
      //       builder: (BuildContext context,
      //           AsyncSnapshot<QuerySnapshot> snapshot) {
      //         if (snapshot.hasError)
      //           return new Text(
      //             'Error ${snapshot.error}',
      //             style: TextStyle(color: Colors.white, fontSize: 18),
      //           );
      //         switch (snapshot.connectionState) {
      //           case ConnectionState.waiting:
      //             return new SpinKitChasingDots(
      //               color: Colors.red,
      //               size: 50,
      //             );
      //           default:
      //             return Expanded(
      //               child: ListView.builder(
      //                 padding: EdgeInsets.all(20),
      //                 itemCount: snapshot.data.documents.length,
      //                 itemBuilder: (context, index) {
      //                   DocumentSnapshot docsSnap =
      //                       snapshot.data.documents[index];
      //                   return AnimatedContainer(
      //                     curve: Curves.fastOutSlowIn,
      //                     duration: Duration(seconds: 2),
      //                     child: Container(
      //                         padding: EdgeInsets.all(8.0),
      //                         child: Ink(
      //                           decoration: BoxDecoration(
      //                             border: Border.all(
      //                               width: 1.0,
      //                               color: Colors.grey.shade700,
      //                               style: BorderStyle.solid,
      //                             ),
      //                             borderRadius: BorderRadius.circular(20),
      //                             image: DecorationImage(
      //                               image:
      //                                   NetworkImage('${docsSnap['image']}'),
      //                               fit: BoxFit.cover,
      //                             ),
      //                           ),
      //                           child: ClipRRect(
      //                             borderRadius: BorderRadius.circular(20),
      //                             child: BackdropFilter(
      //                               filter: ImageFilter.blur(
      //                                   sigmaX: 2.5, sigmaY: 2.5),
      //                               child: InkWell(
      //                                 borderRadius: BorderRadius.circular(20),
      //                                 onTap: () => print('Hello World'),
      //                                 child: Stack(
      //                                   children: [
      //                                     Padding(
      //                                       padding: EdgeInsets.only(
      //                                           bottom: 40,
      //                                           top: 150,
      //                                           left: 20),
      //                                       child: Text(
      //                                         '${docsSnap['text']}',
      //                                         textAlign: TextAlign.start,
      //                                         style: TextStyle(
      //                                           fontSize: 20,
      //                                           fontWeight: FontWeight.bold,
      //                                           color: Colors.white,
      //                                         ),
      //                                       ),
      //                                     )
      //                                   ],
      //                                 ),
      //                               ),
      //                             ),
      //                           ),
      //                         )),
      //                   );
      //                 },
      //               ),
      //             );
      //         }
      //       },
      //     ))
      //   ],
      // )
    );
  }
}
