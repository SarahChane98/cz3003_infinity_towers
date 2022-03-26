import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// This class handles the Page to edit the Password Section of the User Profile.
class EditPasswordPage extends StatefulWidget {
  const EditPasswordPage();
  @override
  EditPasswordPageState createState() {
    return EditPasswordPageState();
  }
}

class EditPasswordPageState extends State<EditPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final currentpasswordController = TextEditingController();
  final newpasswordController = TextEditingController();

  @override
  void dispose() {
    newpasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightGreen[100],
        appBar: AppBar(
          title:const Text(
            'Password Settings',
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
        body: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height:30),
                SizedBox(
                    width: 320,
                    child: const Text(
                      "Enter your current password",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,)),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your current password';
                            } else if (value.length < 6) {
                              return 'Your password has to have at least 6 characters';
                            }
                            return null;
                          },
                          controller: currentpasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Your current password',
                          ),
                        ))),
                SizedBox(
                    width: 320,
                    child: const Text(
                      "Enter your new password",
                      style:
                      TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,)),
                Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: SizedBox(
                        height: 100,
                        width: 320,
                        child: TextFormField(
                          // Handles Form Validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your new password';
                            } else if (value.length < 6) {
                              return 'Your password has to have at least 6 characters';
                            }
                            return null;
                          },
                          controller: newpasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Your new password',
                          ),
                        ))),
                Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: 320,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState.validate() ) {
                                final user = await FirebaseAuth.instance.currentUser;
                                final cred = EmailAuthProvider.credential(
                                    email: user.email, password: currentpasswordController.text);
                                user.reauthenticateWithCredential(cred).then((value) {
                                  user.updatePassword(newpasswordController.text).then((_) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                        backgroundColor: Colors.green[300],
                                        content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                        'Password Successfully changed',
                                        textAlign: TextAlign.center,),
                                        ),
                                        duration: Duration(seconds: 3),
                                        ),
                                        );
                                        Navigator.of(context).pop();
                                        }).
                                  catchError((error) {
                                    {
                                      {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            backgroundColor: Colors.red[300],
                                            content: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                'Password Change Unsuccessful',
                                                textAlign: TextAlign.center,),
                                            ),
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                        Navigator.of(context).pop();
                                      }
                                    };
                                  });
                                }).catchError((err) {
                                  {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red[300],
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Password Change Unsuccessful',
                                            textAlign: TextAlign.center,),
                                        ),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                    Navigator.of(context).pop();
                                  }
                                }
                                );

                              }
                            },
                            child: const Text(
                              'Update',
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        )))
              ]),
        ));
  }
}
