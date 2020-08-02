import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vtop/Authentication/authen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vtop/Authentication/auth.dart';
import 'package:vtop/Authentication/normAuth.dart';
import 'package:vtop/UI/forgotPass.dart';
// import 'package:vtop/Authentication/Authentication.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:vtop/UI/firechanges.dart';
import 'package:vtop/UI/HomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;
  final Firestore _fireStore = Firestore.instance;

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController cnfPasswordController =
      new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  String _user;
  String _email;
  String _password;
  String _confPass;
  String _errorMessage;
  String name;
  bool _isLoginForm;
  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      backgroundColor: Colors.black,
      content: new Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  "Loading",
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          widget.auth.sendEmailVerification();
          updateDb();
          updateProfileName(nameController.text);
          print(nameController.text);
          _showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    super.initState();
  }

  updateDb() async {
    dynamic result = await widget.auth.getCurrentUser();
    if (result != null) {
      Firestore.instance.collection('users').document(result.uid).setData({
        "Name": nameController.text,
        "uid": result.uid,
        "email": emailController.text,
        "profilePicture": null,
      }).whenComplete(() => print("updated successfully !!"));
    }
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      // key: _globalKey,
      resizeToAvoidBottomInset: false,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
                image: AssetImage('assets/images/universe.jpg'),
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.66), BlendMode.darken),
                fit: BoxFit.cover)),
        child: Form(
          key: _formKey,
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15,
                    left: MediaQuery.of(context).size.width * 0.1),
                child: Text(
                  _isLoginForm ? 'LOGIN' : 'SIGNUP',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                child: _isLoginForm ? null : showUserInput(),
              ),
              showEmailInput(),
              showPasswordInput(),
              Container(
                child: _isLoginForm ? null : showConfirmPassword(),
              ),
              Container(
                child: _isLoginForm ? showForgtPass() : null,
              ),
              showPrimaryButton(),
              showSecondaryButton(),
              showErrorMessage(),
            ],
          ),
        ),
      ),
    );
  }

  updateProfileName(name) async {
    FirebaseAuth _auth;
    FirebaseUser user = await _auth.currentUser();
    user.reload();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    if (user != null) {
      user.updateProfile(userUpdateInfo);
    }
    print(user.displayName);
    Firestore.instance
        .collection("users")
        .document(user.uid)
        .updateData({"Name": name}).catchError((e) {
      print(e.toString());
    });
  }

  void _showVerifyEmailSentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          backgroundColor: Colors.black,
          title: new Text(
            "Verify your account",
            style: TextStyle(color: Colors.white),
          ),
          content: new Text(
              "Link to verify account has been sent to your email",
              style: TextStyle(color: Colors.white)),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Dismiss"),
              onPressed: () {
                toggleFormMode();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Flushbar(
        borderRadius: 8.0,
        title: "Invalid Password/Email",
        message: _errorMessage,
        flushbarPosition: FlushbarPosition.BOTTOM,
        flushbarStyle: FlushbarStyle.FLOATING,
        reverseAnimationCurve: Curves.decelerate,
        forwardAnimationCurve: Curves.bounceIn,
        backgroundColor: Colors.black,
        mainButton: FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white),
            )),
        boxShadows: [
          BoxShadow(
              color: Colors.blue[800],
              offset: Offset(0.0, 5.0),
              blurRadius: 8.0)
        ],
        margin: EdgeInsets.only(bottom: 8, left: 8, right: 8),
        isDismissible: true,
        duration: Duration(seconds: 10),
        icon: Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
      )..show(context);
      // Text(
      //   _errorMessage,
      //   style: TextStyle(
      //       fontSize: 13.0,
      //       color: Colors.red,
      //       height: 1.0,
      //       fontWeight: FontWeight.w300),
      // );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showUserInput() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.25,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      child: TextFormField(
        autocorrect: true,
        controller: nameController,
        keyboardType: TextInputType.text,
        onSaved: (value) => name = value.trim(),
        obscureText: false,
        autofocus: false,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
            errorStyle: TextStyle(color: Colors.white),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.75),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.75),
            ),
            border: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.75),
            ),
            prefixIcon: Icon(
              Icons.person,
              color: Colors.white,
              size: 25,
            ),
            hintText: "Enter your Name",
            hintStyle: TextStyle(color: Colors.white, fontSize: 15),
            labelText: "Full Name",
            labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  Widget showEmailInput() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.36,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      child: TextFormField(
        autocorrect: true,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          Pattern pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
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
              borderSide: const BorderSide(color: Colors.white, width: 1.75),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.75),
            ),
            border: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.75),
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
    );
  }

  Widget showPasswordInput() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.47,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      child: TextFormField(
        controller: passwordController,
        keyboardType: TextInputType.visiblePassword,
        validator: (value) {
          if (value.length < 6) {
            return "Enter more than 6 Characters";
          }
          return null;
        },
        onSaved: (value) => _password = value.trim(),
        style: TextStyle(color: Colors.white),
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
            errorStyle: TextStyle(
              color: Colors.white,
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.75),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.75),
            ),
            border: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.75),
            ),
            prefixIcon: Icon(
              Icons.security,
              color: Colors.white,
              size: 25,
            ),
            // errorText: error,
            hintText: "Ssshhh!!! its a secret",
            hintStyle: TextStyle(color: Colors.white, fontSize: 15),
            labelText: "Password",
            labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  Widget showConfirmPassword() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.58,
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05),
      child: TextFormField(
        controller: cnfPasswordController,
        keyboardType: TextInputType.visiblePassword,
        validator: (value) =>
            value != passwordController.text ? 'Password do not match' : null,
        onSaved: (value) => _confPass = value.trim(),
        style: TextStyle(color: Colors.white),
        obscureText: true,
        autofocus: false,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.75),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.75),
            ),
            border: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 1.75),
            ),
            prefixIcon: Icon(
              Icons.security,
              color: Colors.white,
              size: 25,
            ),
            errorStyle: TextStyle(color: Colors.white),
            hintText: "Mind Writing it again?",
            hintStyle: TextStyle(color: Colors.white, fontSize: 15),
            labelText: "Confirm Password",
            labelStyle: TextStyle(color: Colors.white, fontSize: 18)),
      ),
    );
  }

  Widget showForgtPass() {
    return Container(
      margin: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.57,
          left: MediaQuery.of(context).size.width * 0.7),
      child: RichText(
          text: TextSpan(
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ForgotPassword()));
          },
        text: "Forgot Password ?",
        style: TextStyle(shadows: <Shadow>[
          Shadow(
            color: Colors.white,
            blurRadius: 1.5,
            offset: Offset(0.0, 0.0),
          )
        ], color: Colors.white, fontSize: 13, fontWeight: FontWeight.w900),
      )),
    );
  }

  Widget showSecondaryButton() {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.9,
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.18,
            right: MediaQuery.of(context).size.width * 0.18),
        child: RichText(
          text: TextSpan(
            text: _isLoginForm ? 'Create an account ' : 'Have an account? ',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
            children: <TextSpan>[
              TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = toggleFormMode,
                  text: _isLoginForm ? 'SignUp' : 'Sign in',
                  style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                          color: Colors.cyanAccent,
                          blurRadius: 5.0,
                          offset: Offset(0.0, 0.0),
                        )
                      ],
                      color: Colors.cyanAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.w800))
            ],
          ),
        ),
      ),
    );
  }

  Widget showPrimaryButton() {
    return Container(
      child: _isLoginForm
          ? Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.625,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: RaisedButton(
                color: Colors.pink,
                onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      try {
                        validateAndSubmit();
                        Navigator.pop(context);
                        dynamic result = widget.auth.getCurrentUser();
                        if (result == null) {
                          setState(() {
                            Flushbar(
                              borderRadius: 8.0,
                              title: "Invalid Password/Email",
                              message:
                                  "Please enter correct Email and Password",
                              flushbarPosition: FlushbarPosition.BOTTOM,
                              flushbarStyle: FlushbarStyle.FLOATING,
                              reverseAnimationCurve: Curves.decelerate,
                              forwardAnimationCurve: Curves.bounceIn,
                              backgroundColor: Colors.black,
                              mainButton: FlatButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white),
                                  )),
                              boxShadows: [
                                BoxShadow(
                                    color: Colors.blue[800],
                                    offset: Offset(0.0, 5.0),
                                    blurRadius: 8.0)
                              ],
                              margin:
                              EdgeInsets.only(bottom: 8, left: 8, right: 8),
                              isDismissible: true,
                              duration: Duration(seconds: 5),
                              icon: Icon(
                                Icons.error_outline,
                                color: Colors.white,
                              ),
                            )..show(context);
                          });
                        }
                      } catch (e) {
                        var errorr = e.toString();
                        print(errorr);
                      }
                    }
                  },
                child: new Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
                elevation: 25,
              ),
            )
          : Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.9,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.7,
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05),
              child: RaisedButton(
                color: Colors.pink,
                onPressed: validateAndSubmit,
                child: new Text(
                  'SIGNUP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                ),
                elevation: 25,
              ),
            ),
    );
  }
}
