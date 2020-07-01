import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vtop/UI/HomeScreen.dart';
import 'dart:io';

class MyAccountsPage extends StatefulWidget {
  @override
  _MyAccountsPageState createState() => _MyAccountsPageState();
}

class _MyAccountsPageState extends State<MyAccountsPage> {
  File _image;
  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      updateProfilePicture();
    });
  }
  Timer timer;
  String name;
  String email;
  String userEmail;
  String displayName;
  String photoUrl;
  String phoneNumber;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _fireStore = Firestore.instance;

  updateProfileName(name) async {
    FirebaseUser user = await _auth.currentUser();
    user.reload();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
    if(user != null)
    {
      user.updateProfile(
        userUpdateInfo
      );
    }
    print(user.displayName);
    Firestore.instance.collection("users").document(user.uid).updateData({"Name" : name}).catchError((e){
      print(e.toString());
    });
  }

  updateProfilePicture() async {
    FirebaseUser user = await _auth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.photoUrl = _image.toString();
    Firestore.instance.collection("users").document(user.uid).updateData({"profilePicture" : _image}).catchError((e) {
      print(e.toString());
    });
  }

  getName() async {
    FirebaseUser user = await _auth.currentUser();
    displayName = user.displayName;  
  }

  getEmail() async{
    FirebaseUser user = await _auth.currentUser();
    email = user.email;
  }

  @override
  void initState() {
    super.initState();
    getName();
    getEmail();
    timer = Timer.periodic(Duration(seconds : 1), (timer) async{
      this.setState(() {
        getEmail();
        getName();
      });
     });
  }
  @override
  void dispose(){
    super.dispose();
    timer.cancel();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final firstTabColor = Color(0xFF1e1e44);
    final avatarColor = Color(0xFFef5c6e);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: CircleAvatar(
                      backgroundImage: _image == null
                          ? AssetImage("assets/images/user.png")
                          : FileImage(_image),
                      maxRadius: 80,
                    )),
                Container(
                  child: FlatButton(
                    onPressed: () => debugPrint("hello world"),
                    child: Text(
                      displayName == null ? "" : displayName,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () => debugPrint("hello world"),
                    child: Text(
                      email == null ? "" : email,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: Colors.blue,
                                primaryColorDark: Colors.grey,
                              ),
                              child: TextFormField(
                                
                                // onFieldSubmitted: ,
                                onSaved: (value) => name = value.trim(),
                                onChanged: (val) {
                                  setState(() => name = val);
                                },
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                obscureText: false,
                                autocorrect: true,
                                autofocus: false,
                                controller: _nameController,
                                cursorColor: Colors.blue,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Dont't you have a Name!!??";
                                  } else
                                    return null;
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green)),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  fillColor: Colors.blue,
                                  icon: Icon(
                                    Feather.user,
                                    color: Colors.white,
                                  ),
                                  helperText: "Enter your name",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  helperStyle: TextStyle(color: Colors.grey),
                                  labelText: "Name",
                                  labelStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 30.0, right: 30.0),
                            child: Theme(
                              data: ThemeData(
                                primaryColor: Colors.blue,
                                primaryColorDark: Colors.grey,
                              ),
                              child: TextFormField(
                                onSaved: (value) => phoneNumber = value.trim(),
                                onChanged: (val) {
                                  setState(() => phoneNumber = val);
                                },
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.phone,
                                obscureText: false,
                                autocorrect: true,
                                autofocus: false,
                                controller: _phoneController,
                                cursorColor: Colors.blue,
                                decoration: InputDecoration(
                                  disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:Colors.grey,
                                    )
                                  ),
                                  // prefix: Text("+91 "),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.white,
                                  )),
                                  // hintText: 'Name',
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  icon:
                                      Icon(Entypo.email, color: Colors.white),
                                  enabled:false,
                                  hoverColor: Colors.white,
                                  helperText: "* you cannot change this",
                                  hintStyle: TextStyle(color: Colors.white),
                                  helperStyle: TextStyle(color: Colors.red),
                                  labelText: email,
                                  labelStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Container(
                              child: FlatButton(
                                onPressed: () {
                                  getImage();
                                  // updateProfilePicture();
                                },
                                child: Text("Change your profile photo",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Container(
                              color: Colors.blue,
                              child: FlatButton(
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    try {
                                      setState(() {
                                        updateProfileName(name); 
                                        _formKey.currentState.reset();
                                        _nameController.clear();
                                      });
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  }
                                },
                                child: Text("Save",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
