import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/screens/edit_password.dart';
import 'package:cz3003_infinity_towers/screens/edit_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/display_image_widget.dart';

// This class handles the Page to dispaly the user's info on the "Edit Profile" Screen
class ProfilePage extends StatefulWidget {
  ProfilePage(this.imagePath,this.email);
  var imagePath;
  var email;
  @override
  _ProfilePageState createState() => _ProfilePageState(imagePath,email);
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState(this.imagePath,this.email);
  var imagePath;
  var email;
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(
        title:const Text(
          'Settings',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w900,),
        ),
        backgroundColor: Colors.lightBlueAccent[200],
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,size: 30,),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(vertical:10),
              decoration:BoxDecoration(color:Colors.lightGreen[400]),
              child:InkWell(
                  onTap: () {
                    navigateSecondPage(EditImagePage(imagePath));
                  },
                  child: DisplayImage(
                    imagePath: imagePath,
                    onPressed: () {},
                  )
              )
          ),
          SizedBox(height: 10,),
          Container(
              decoration:BoxDecoration(color:Colors.lightGreen[100]),
              child:Row(
                  children:[
                    SizedBox(width:20),
                    Text('PROFILE',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),)
                  ]
              )
          ),
          SizedBox(height: 10,),
          Container(
              decoration:BoxDecoration(color:Colors.lightGreen[100]),
              child:Row(
                children: [
                  SizedBox(width: 20,),
                  Text('School',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                  SizedBox(width: 220,),
                  Text('SCSE',style: TextStyle(fontSize: 24),)
                ],
              )),
          SizedBox(height: 10,),
          Container(
              decoration:BoxDecoration(color:Colors.lightGreen[100]),
              child:Row(
                children: [
                  SizedBox(width: 20,),
                  Text('Email',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                  Container(width:290,child:Text(email,style: TextStyle(fontSize: 18),textAlign: TextAlign.right,))
                ],
              )),
          SizedBox(height: 10,),
          Container(
              decoration:BoxDecoration(color:Colors.lightGreen[100]),
              padding: EdgeInsets.symmetric(vertical:5),
              child:Row(
                  children:[
                    SizedBox(width:20),
                    Text('ACCOUNT',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),)
                  ]
              )
          ),
          SizedBox(height: 10,),
          Container(
              decoration:BoxDecoration(color:Colors.lightGreen[100]),
              child:Row(
                children: [
                  SizedBox(width: 20,),
                  Text('Username',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),textAlign: TextAlign.left,),
                  Container(width:230,child:Text(email,style: TextStyle(fontSize: 18),textAlign: TextAlign.right,))
                ],
              )),
          SizedBox(height: 10,),
          Container(
              decoration:BoxDecoration(color:Colors.lightGreen[100]),
              child:Row(
                children: [
                  SizedBox(width: 20,),
                  Text('Password',style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),),
                  Container(width:200,child:Text('******',style: TextStyle(fontSize: 18),textAlign: TextAlign.right,)),
                  IconButton(onPressed: () {
                    navigateSecondPage(EditPasswordPage());
                  },
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                        color: Colors.grey,
                        size: 40.0,
                      ))
                ],
              )),
          // buildUserInfoDisplay(user.name, 'Name', EditNameFormPage()),
          // buildUserInfoDisplay(user.phone, 'Phone', EditPhoneFormPage()),
          // buildUserInfoDisplay(user.email, 'Email', EditEmailFormPage()),
          // Expanded(
          //   child: buildAbout(user),
          //   flex: 4,
          // )
        ],
      ),
    );
  }

  // Widget builds the display item with the proper formatting to display the user's info
  Widget buildUserInfoDisplay(String getValue, String title, Widget editPage) =>
      Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                            color: Colors.grey,
                            width: 1,
                          ))),
                  child: Row(children: [
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              navigateSecondPage(editPage);
                            },
                            child: Text(
                              getValue,
                              style: TextStyle(fontSize: 16, height: 1.4),
                            ))),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                      size: 40.0,
                    )
                  ]))
            ],
          ));

  // Widget builds the About Me Section

  // Refrshes the Page after updating user info.
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  // Handles navigation and prompts refresh.
  void navigateSecondPage(Widget editForm) {
    Route route = MaterialPageRoute(builder: (context) => editForm);
    Navigator.push(context, route).then(onGoBack);
  }
}
