

import 'package:cz3003_infinity_towers/screens/manage_towers.dart';
import 'package:cz3003_infinity_towers/screens/tile_map.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/screens/Login_Screen.dart';
import 'package:cz3003_infinity_towers/screens/Register_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

_signOut() async {
  await _firebaseAuth.signOut();
}

class _HomeScreenState extends State<HomeScreen> {
  var user='Student';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              child: Image.asset('assets/tower.png'),
            ),
            Text(
            "Infinity Towers",
            style: TextStyle(
                fontSize: 100,
                color: Colors.black,
                fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
          ),
            SizedBox(height: 30),
            Container(
              height: 64,
              width: 300,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.yellow[300]),
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.black54)
                          )
                      )
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Center(
                    child: Text('Teacher Mode',
                        style:TextStyle(fontSize: 30,color:Colors.black87)),
                  ),
                  onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen('teacher')),
                      );
                  }),
            ),
            SizedBox(height: 20),
            Container(
              height: 64,
              width: 300,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green[200]),
                      padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.black54)
                    )
                )
            ),
                  clipBehavior: Clip.hardEdge,
                  child: Center(
                    child: Text('Student Mode',
                    style:TextStyle(fontSize: 30,color:Colors.black87)),
                  ),
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen('student')),
                    );
                  }),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SignupScreen(),
                  ),
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account ?",
                    style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 22, color: Colors.blue[900]),
                  ),
                  SizedBox(width: 10),
                  Hero(
                    tag: '1',
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
