import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class Activities extends StatefulWidget {
  Activities({Key key}) : super(key: key);

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
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
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height*0.05,
                ),
              height: 200,
              color: firstTabColor,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                          // width: 300,
                          // height: 200,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                              images[index],
                            ),
                            fit: BoxFit.cover,
                          ))),
                    ),
                  );
                },
                itemCount: 5,
                viewportFraction: 0.9,
                scale: 0.9,
                itemWidth: 300,
                itemHeight: 300,
                layout: SwiperLayout.STACK,
              ),
            )
          ]),
        ));
  }
}
