import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cz3003_infinity_towers/constants/constants.dart';
import 'package:cz3003_infinity_towers/screens/Home_Screen.dart';
import 'package:cz3003_infinity_towers/screens/ProfilePage_Screen.dart';
import 'tile_map.dart';
import 'manage_towers.dart';

class EntSScreen extends StatefulWidget {
  EntSScreen(this.email);
  String email;
  @override
  _EntSScreenState createState() => _EntSScreenState(email);
}

class _EntSScreenState extends State<EntSScreen> {
  _EntSScreenState(this.email);
  String email;
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
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
                child: SingleChildScrollView(
                  padding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        color: Colors.red[200],
                        shape: const CircleBorder(),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TileMapPage()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(75),
                          child: Text(
                            'Tile Map',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        color: Colors.red[200],
                        shape: const CircleBorder(),
                        onPressed: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TileMapPage()),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(80),
                          child: Text(
                            'Leaderboard',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      MaterialButton(
                        color: Colors.red[200],
                        shape: const CircleBorder(),
                        onPressed: () async {
                          QuerySnapshot querySnapshot = await users
                              .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
                              .get();
                          var ImagePath = querySnapshot.docs[0]['imageURL'];
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProfilePage(ImagePath,email)),
                          );
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(63),
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
