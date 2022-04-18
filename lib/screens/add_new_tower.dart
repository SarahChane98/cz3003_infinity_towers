import 'package:cz3003_infinity_towers/screens/add_new_checkpoint.dart';
import 'package:cz3003_infinity_towers/models/tower.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

/// This class is used to create a new Tower.
class AddNewTower extends StatefulWidget {
  const AddNewTower({Key key}) : super(key: key);

  @override
  State<AddNewTower> createState() => _AddNewTowerState();
}

class _AddNewTowerState extends State<AddNewTower> {
  final textControllerName = TextEditingController();
  final textControllerUniqueJoiningCode = TextEditingController();
  final textControllerPassword = TextEditingController();
  Random random = new Random();
  Tower tower;
  String towerID;
  // final towerParticipationsRef = FirebaseFirestore.instance.collection('questions').withConverter<TowerParticipation>(
  //   fromFirestore: (snapshot, _) => TowerParticipation.fromJson(snapshot.data()),
  //   toFirestore: (participation, _) => participation.toJson(),
  // );
  //
  void popDialog(String message) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(content: Text(message), actions: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddNewCheckpoint(towerID: towerID, tower: tower)
                      ));
                })
          ]);
        });
  }
  CollectionReference questions = FirebaseFirestore.instance.collection('towers');
  Future<void> addCheckpoint() async
  {
    questions.add({'name':textControllerName.text,
      'CheckpointIds':[],
      'ownerId': FirebaseAuth.instance.currentUser.uid,
      'passcode': textControllerPassword.text,
      'uniqueJoiningId': textControllerUniqueJoiningCode.text
    }).then((value) => print("Tower Added!"))
        .catchError((error) => print("Failed to add tower: $error"));
  }

  Future<void> addRest() async
  {
    final towerRef = FirebaseFirestore.instance.collection('towers').withConverter<Tower>(
      fromFirestore: (snapshot, _) => Tower.fromJson(snapshot.data()),
      toFirestore: (participation, _) => participation.toJson(),
    );

    Future<List<QueryDocumentSnapshot<Tower>>> getTowerList() async {
      var TowersList = await towerRef
          .where('name', isEqualTo: textControllerName.text)
          .where('ownerId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
          .where('uniqueJoiningId', isEqualTo: textControllerUniqueJoiningCode.text)
          .where('passcode', isEqualTo: textControllerPassword.text)
          .get()
          .then((snapshot) => snapshot.docs);
      return TowersList;
    }

    await getTowerList().then((TowersList) async {
      towerID = TowersList[0].id;
      tower = TowersList[0].data();
    });
    print(towerID);
    print('this is the tower!!!!');
    print(tower);
    //getQuestionID();
    var collection = FirebaseFirestore.instance.collection('users');
    collection
        .doc(FirebaseAuth.instance.currentUser.uid) // <-- Document ID
        .update({'towers': FieldValue.arrayUnion([towerID])}) // <-- Add data
        .then((_) => print('Added $towerID'))
        .catchError((error) => print('Add failed: $error'));
  }
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      appBar: AppBar(title: const Text("Add new tower!")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textControllerName,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter the name of the tower',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textControllerUniqueJoiningCode,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter the unique joining code',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textControllerPassword,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter the password',
              ),
            ),
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              addCheckpoint();
              addRest();
              popDialog("Tower Added!");
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

