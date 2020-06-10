import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:random_color/random_color.dart';
import 'package:google_sign_in/google_sign_in.dart';import 'dart:ui';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart';


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
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // Future<String> signInWithGoogle() async {
  //   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //   await googleSignInAccount.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //   final AuthResult authResult = await _auth.signInWithCredential(credential);
  //   final FirebaseUser user = authResult.user;
  //   assert(!user.isAnonymous);
  //   assert(await user.getIdToken() != null);
  //   final FirebaseUser currentUser = await _auth.currentUser();
  //   assert(user.uid == currentUser.uid);
  //   assert(user.email != null);
  //   assert(user.displayName != null);
  //   assert(user.photoUrl != null);
  //   name = user.displayName;
  //   email = user.email;
  //   imageUrl = user.photoUrl;
  //   return email;
  // }
  // Future<String>getPhoto() async{
  //   final FirebaseUser user = await _auth.currentUser();
  //   print(user.photoUrl);
  //   return user.photoUrl;
  // }
  // Future<String>printEmail() async
  // {
  //   signInWithGoogle();
  //  String email = await signInWithGoogle();
  //  print(email);
  //  return email;
  // }

  // Future<String>printInitial() async{
  //   signInWithGoogle();
  //   String email = await signInWithGoogle();
  //   String initial = email[0];
  //   return initial;
  // }

  final backgroundColor = Color(0xFF2c2c2c);
  final firstTabColor = Color(0xFF1d1d1d);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(length: 2,
      
       child: Scaffold(
         drawer: Drawer(
           elevation: 16.0,
           child: ListView(
             children: <Widget>[
               UserAccountsDrawerHeader(
                 accountName: Text(""),
                 currentAccountPicture: CircleAvatar(
                   //backgroundImage: NetworkImage(),
                   radius: 50,
                   backgroundColor: _color,
                  child: FutureBuilder<String>(
                    //future: printInitial(),
                    builder:(context, snapShot ){
                    if(snapShot.hasData){
                    return Text(snapShot.data, style: TextStyle(fontSize: 30, color: Colors.white
                    ),);
                      } else{
                       return Text("loading");
                     }
                   },
                  ),
                 ),
                 arrowColor: Colors.white,
                 accountEmail: FutureBuilder<String>(
                   //future: printEmail(),
                   builder: (context, snapShot ){
                     if(snapShot.hasData){
                       return Text(snapShot.data, style: TextStyle(fontSize: 18),);
                     } else{
                       return Text("loading");
                     }
                   },
                 )
               ),
             ],
           ),

         ),

         appBar: AppBar(
           actions: <Widget>[],
           backgroundColor: backgroundColor,
              bottom: TabBar(indicatorColor: Colors.purpleAccent,labelColor: Colors.purpleAccent.shade100,unselectedLabelColor: Colors.white,
                tabs: [
                  Tab(child: Container(child:Text("ACTIVITIES", style: TextStyle(letterSpacing: 1.5, fontSize: 16),)),),
                  Tab(child: Container(child:Text("DISCOVER", style: TextStyle(letterSpacing: 1.5, fontSize: 16),)),),
                ],
              ),
              centerTitle: true,
              title: Text('EXTENDED',style: TextStyle(fontSize: 22,letterSpacing:7),)
         ),
         body: TabBarView(
            children: [
              FirstScreen(),
              SecondScreen(),
            ],
          ),
       ),
       ),      
    );
  }
}

List<StaggeredTile> _staggeredTiles = const <StaggeredTile>[
  const StaggeredTile.count(8, 4),
  const StaggeredTile.count(4, 4),
  const StaggeredTile.count(4, 6),
  const StaggeredTile.count(4, 6),
  const StaggeredTile.count(4, 4),
];
 
 const String hello='Hello there';
 const String hi='Sexy';

List<Widget> _tiles = const <Widget>[
  const _Example01Tile( Icons.widgets, hello),
  const _Example01Tile( Icons.wifi, hi),
  const _Example01Tile( Icons.panorama_wide_angle, hello),
  const _Example01Tile( Icons.map, hello),
  const _Example01Tile( Icons.send, hello),
];

class _Example01Tile extends StatelessWidget {
  const _Example01Tile( this.iconData, this.text);

  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage('https://images.pexels.com/photos/3667816/pexels-photo-3667816.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'),
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.37), BlendMode.darken),
            )
          ),
          child: new InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              debugPrint(text);
            },
            child: new Center(
              child: new Padding(
                padding: const EdgeInsets.all(4.0),
                child: new Icon(
                  iconData,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
    );
  }
}


class FirstScreen extends StatelessWidget {
  final firstTabColor = Color(0xFF1d1d1d);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: firstTabColor,
      body: new Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: new StaggeredGridView.count(
              crossAxisCount: 8,
              staggeredTiles: _staggeredTiles,
              children: _tiles,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              padding: const EdgeInsets.all(20.0),
            )
      )
    );
  }
}
class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
   final secondTabColor = Color(0xFF1d1d1d);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondTabColor,
      body: StreamBuilder<QuerySnapshot> (
        stream: Firestore.instance.collection('posts').snapshots(),
        builder:  (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError)
            return new Text('Error: ${snapshot.error}', style: TextStyle(color: Colors.white, fontSize: 15),);
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Text('Loading...', style: TextStyle(color: Colors.white, fontSize: 15),);
            default:
              return ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index){
                  DocumentSnapshot docsSnap = snapshot.data.documents[index];
                  return  AnimatedContainer(
                    curve: Curves.fastOutSlowIn,
                    duration:Duration(seconds:2) ,
                    // width:  ? 200.0 : 100,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Ink(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.0,
                                  color: Colors.grey.shade700,
                                  style: BorderStyle.solid
                              ),
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage('${docsSnap['image']}'),
                                  fit: BoxFit.cover
                              )
                          ),
                          child: ClipRRect(borderRadius: BorderRadius.circular(20),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 2.5,sigmaY: 2.5),
                                child: InkWell(
                                    borderRadius: BorderRadius.circular(22),
                                    onTap: (){},
                                    child: Stack(
                                        children: <Widget>[
                                          Padding(padding: EdgeInsets.only(bottom: 40, top: 150, left: 20),
                                            child: Text('${docsSnap['text']}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white
                                              ),
                                            ),
                                          )
                                        ]
                                    )
                                ),
                              )
                          )
                      ),
                    ),
                  );
                },
              );
          }
        }
      ),
      
    );
  }
}