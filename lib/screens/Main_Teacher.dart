import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cz3003_infinity_towers/constants/constants.dart';
import 'package:cz3003_infinity_towers/screens/Home_Screen.dart';
import 'tile_map.dart';
import 'manage_towers.dart';

class EntTScreen extends StatefulWidget {
  EntTScreen();
  @override
  _EntTScreenState createState() => _EntTScreenState();
}

class _EntTScreenState extends State<EntTScreen> {
  _EntTScreenState();
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String email = '';
  String password = '';
  bool isloading = false;
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text(
          'Infinity Towers',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            color: Colors.black,
            fontWeight: FontWeight.w900,),
        ),
        backgroundColor: Colors.lightBlueAccent[100],
        elevation: 0,
        centerTitle: true,
        leading: IconButton(icon:Icon(Icons.power_settings_new,size:30,color: Colors.black87,), onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    },)
      ),
      backgroundColor: Colors.lightBlue[100],
      body: isloading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Form(
        key: formkey,
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                constraints: BoxConstraints.expand(),
                child: SingleChildScrollView(
                  padding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: Colors.red[200],
                        shape: const CircleBorder(),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ManageTowers()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(75),
                          child: Text(
                            'Manage Created Towers',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      MaterialButton(
                        color: Colors.red[200],
                        shape: const CircleBorder(),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ManageTowers()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(75),
                          child: Text(
                            'Account Settings',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
