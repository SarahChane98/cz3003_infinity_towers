import 'package:cz3003_infinity_towers/screens/Main_Student.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cz3003_infinity_towers/constants/constants.dart';
import 'package:cz3003_infinity_towers/screens/Home_Screen.dart';
import 'package:cz3003_infinity_towers/screens/Main_Teacher.dart';
import 'package:cz3003_infinity_towers/screens/Main_Student.dart';
import 'tile_map.dart';
import 'manage_towers.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen(this.logintype);
  String logintype;
  @override
  _LoginScreenState createState() => _LoginScreenState(logintype);
}

class _LoginScreenState extends State<LoginScreen> {
  _LoginScreenState(this.logintype);
  String logintype;
  String titlemessage = '';
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  String email = '';
  String password = '';
  bool isloading = false;
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    if (logintype =='teacher'){
      titlemessage='Log in to your Teacher Account';
    }
    else {
      titlemessage = 'Log in to your Student Account';
    }
    return Scaffold(
      appBar: AppBar(
        title:Text(
          titlemessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w900,),
        ),
        backgroundColor: Colors.lightBlueAccent[100],
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,size: 30,),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                            Container(
                              height: 80,
                              width: 80,
                              child: Image.asset('assets/tower.png'),
                            ),
                            SizedBox(height: 50),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) {
                                email = value;
                              },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter Email";
                                }
                              },
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                hintText: 'Email',
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),
                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "Please enter Password";
                                }
                              },
                              onChanged: (value) {
                                password = value;
                              },
                              textAlign: TextAlign.center,
                              decoration: kTextFieldDecoration.copyWith(
                                  hintText: 'Password',
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  )),
                            ),
                            SizedBox(height: 30),
                        Container(
                          height: 64,
                          width: 300,
                          child:ElevatedButton(
                              child: Text('Login',
                                  style:TextStyle(
                                      color:Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25,
                                      )),
                              onPressed: () async {
                                if (formkey.currentState.validate()) {
                                  setState(() {
                                    isloading = true;
                                  });
                                  try {
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);
                                    var snap = await users.where("email",isEqualTo: email).get();
                                    var type = snap.docs[0]['type'];
                                    print(type);
                                    print(logintype);
                                    if (logintype=='teacher') {
                                      if (type == logintype) {
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return EntTScreen();
                                            },
                                          ),
                                        );
                                      }
                                      else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red[300],
                                            content: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'You do not have Teacher Authorisation',
                                                textAlign: TextAlign.center,),
                                            ),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return HomeScreen();
                                            },
                                          ),
                                        );
                                      }
                                    }
                                    if (logintype=='student') {
                                      if (type == logintype) {
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return EntSScreen();
                                            },
                                          ),
                                        );
                                      }
                                      else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red[300],
                                            content: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'You do not have Student Authorisation',
                                                textAlign: TextAlign.center,),
                                            ),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                        await Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return HomeScreen();
                                            },
                                          ),
                                        );
                                      }
                                    }

                                    setState(() {
                                      isloading = false;
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                        title: Text("Ops! Login Failed"),
                                        content: Text('${e.message}'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(ctx).pop();
                                            },
                                            child: Text('Okay'),
                                          )
                                        ],
                                      ),
                                    );
                                    print(e);
                                  }
                                  setState(() {
                                    isloading = false;
                                  });
                                }
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green[300]),
                                  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.black54)
                                      )
                                  )
                              ),
                            ),
                        ),
                            SizedBox(height: 30),

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
