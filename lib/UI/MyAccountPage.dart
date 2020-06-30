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
    });
  }

  String name;
  String userEmail;
  String displayName;
  String photoUrl;
  String phoneNumber;
  TextEditingController _nameController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  updateProfileName() async {
    FirebaseUser user = await _auth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.displayName = name;
  }

  updateProfilePicture() async {
    FirebaseUser user = await _auth.currentUser();
    UserUpdateInfo userUpdateInfo = UserUpdateInfo();
    userUpdateInfo.photoUrl = _image.toString();
  }

  getUserinfo() async {
    FirebaseUser user = await _auth.currentUser();
    setState(() {
      displayName = user.displayName;
      photoUrl = user.photoUrl;
      userEmail = user.email;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserinfo();
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
                      displayName == null ? "Set you name" : displayName,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () => debugPrint("hello world"),
                    child: Text(
                      userEmail == null ? "Email" : userEmail,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  child: FlatButton(
                    onPressed: () => debugPrint("hello world"),
                    child: Text(
                      "+91 1234567890",
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
                                  prefix: Text("+91 "),
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
                                      Icon(Feather.phone, color: Colors.white),
                                  helperText: "* Optional",
                                  hintStyle: TextStyle(color: Colors.white),
                                  helperStyle: TextStyle(color: Colors.red),
                                  labelText: "Phone Number",
                                  labelStyle: TextStyle(color: Colors.white),
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
                                  updateProfilePicture();
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
                                        updateProfileName();
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
