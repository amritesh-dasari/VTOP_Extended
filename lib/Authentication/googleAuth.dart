import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vtop/Authentication/user.dart';

final GoogleSignIn googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
class GoogleAuthService{
   //create user obj based on FIrebaseUser
  User _userFormFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFormFirebaseUser);
  }

}