import 'package:firebase/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
FirebaseUser user;
FirebaseAuth auth;
String email;
String imageUrl;
String name;
getCurrentLoggedInUser() async
{
  user = await auth.currentUser();
  email = user.email;
  name = user.displayName;
  imageUrl = user.photoUrl;
}