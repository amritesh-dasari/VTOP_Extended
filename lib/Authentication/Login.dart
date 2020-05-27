import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:vtop/Authentication/Signup.dart';
import 'package:vtop/Authentication/forgotPass.dart';
// import 'package:vtop/Authentication/Authentication.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:vtop/UI/firechanges.dart';
import 'package:vtop/UI/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
//
//  @override
// void initState()
//  {
//    super.initState();
//    autoLogin();
//  }
  String _email = "";
  String _pass = "";
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //implementing auto login
  Future<bool> isUserLoggedIn() async {
    var user = await _auth.currentUser();
    return user != null;
  }


  //implementation of google sign in method

  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
    await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;
    String email = user.email;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);
    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
//    user.sendEmailVerification();
    return 'signInWithGoogle succeeded: $user, email $email';
  }


    FirebaseUser user;


  bool validatAndSave()
  {
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      return true;
    }
    return false;
  }

  autoLogin() async
  {
    var user = await _auth.currentUser();
    if(_auth.currentUser() != null)
      {
        ExtendedHome();
      }
    else{
      validateAndLogin();
    }
  }

  validateAndLogin() async
  {
    if(validatAndSave()) {
      isUserLoggedIn();
      try {

        FirebaseUser user;
        user = (await _auth.signInWithEmailAndPassword(
            email: _email, password: _pass)).user;

        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ExtendedHome()));
        print('Login successfull user id is  : ${user.uid}');
      } catch (error) {
        switch(error.code){
          case "ERROR_USER_NOT_FOUND":  {
            setState(() {
              String errorMsg = "User not Registered";
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Container(
                        child: Text(errorMsg),
                      ),
                    );
                  });
            });
          }
          break;
          case "ERROR_WRONG_PASSWORD":
            {
              setState(() {
                String errorMsg = "Password doesn\'t match your email.";


                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(errorMsg),
                        ),
                      );
                    });
              });
            }
            break;
          default:
            {
              setState(() {
                String errorMsg ="";
              });
            }
        }
      }
    }

    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage('assets/images/universe.jpg'),
            colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.37), BlendMode.darken),
            fit: BoxFit.cover
          )
        ),
        child: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15, left: MediaQuery.of(context).size.width*0.1),
                child: Text("LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.33, left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                  child: TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                      RegExp regex = new RegExp(pattern);
                      if (!(regex.hasMatch(value) && value.isNotEmpty))
                       return "Please enter a valid Email-ID";
                      else
                        return null;
                    },
                    onSaved: (value) => _email = value.trim(),
                    obscureText: false,
                    autofocus: false,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.75),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.75),
                        ),
                        border: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.75),
                        ),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                          size: 25,
                        ),
                        hintText: "Enter your VIT-AP Email ID",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.43, left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                  child: TextFormField(                    
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value.length < 6) {
                        return "Enter more than 6 Characters";
                      }
                      return null;
                    },
                    onSaved: (value) => _pass = value.trim(),
                    style: TextStyle(color: Colors.white),
                    obscureText: true,
                    autofocus: false,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white,),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.75),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.75),
                        ),
                        border: const OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.white, width: 1.75),
                        ),
                        prefixIcon: Icon(
                          Icons.security,
                          color: Colors.white,
                          size: 25,
                        ),
                        hintText: "Ssshhh!!! its a secret",
                        hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.52, left: MediaQuery.of(context).size.width*0.7),
                  child: RichText(
                    text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPassword()));
                      },
                      text:"Forgot Password ?",
                      style: TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                            color: Colors.white,
                            blurRadius: 1.5,
                            offset: Offset(0.0, 0.0),
                          )
                        ],
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w900),)
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.9,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.625, left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                  child: RaisedButton(
                    color: Colors.pink,
                    onPressed: validateAndLogin,
                    child: Text(
                      "LOGIN",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                    elevation: 25,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.71, left: MediaQuery.of(context).size.width*0.48),
                  child: RichText(
                    text: TextSpan(
                        text: "OR ",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    )
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.9,
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.75, left: MediaQuery.of(context).size.width*0.05, right: MediaQuery.of(context).size.width*0.05),
                  child: RaisedButton(
                    color: Colors.white,
                    onPressed: (){
                      signInWithGoogle().whenComplete(() => Navigator.pushReplacement(context, MaterialPageRoute(builder:  (context) => ExtendedHome())));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/google.png'),
                            )
                          ),
                        ),
                        Container(
                          child: Text('Login with Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 15
                            ),
                          ),
                        )
                      ],
                    ),
                    elevation: 20,
                  )
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.9,bottom: MediaQuery.of(context).size.height*0.05,left: MediaQuery.of(context).size.width*0.18, right: MediaQuery.of(context).size.width*0.18),
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account ?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            recognizer: TapGestureRecognizer()..onTap = () {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>SignupScreen()));
                            },
                            text:' Sign up',
                            style: TextStyle(
                              shadows: <Shadow>[
                                Shadow(
                                  color: Colors.cyanAccent,
                                  blurRadius:5.0,
                                  offset: Offset(0.0, 0.0),
                                )
                              ],
                              color: Colors.cyanAccent,
                              fontSize: 18,
                              fontWeight: FontWeight.w800
                            )
                          )
                        ]
                      ),
                    )
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}





