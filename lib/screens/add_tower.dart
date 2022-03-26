import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cz3003_infinity_towers/models/tower.dart';
import 'package:cz3003_infinity_towers/models/tower_participation.dart';

class AddTowerPage extends StatefulWidget {
  const AddTowerPage({Key key}) : super(key: key);

  @override
  State<AddTowerPage> createState() => _AddTowerPageState();
}

class _AddTowerPageState extends State<AddTowerPage> {

  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  final towerParticipationsRef = FirebaseFirestore.instance.collection('tower_participations').withConverter<TowerParticipation>(
    fromFirestore: (snapshot, _) => TowerParticipation.fromJson(snapshot.data()),
    toFirestore: (participation, _) => participation.toJson(),
  );

  void popDialog(String message) async {
    await showDialog(context: context, builder: (context) {
      return AlertDialog(content: Text(message));
    });
  }

  Future<bool> hasJoinedTower(String towerId) async {
    bool hasJoined;
    await towerParticipationsRef
        .where('studentId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .where('towerId', isEqualTo: towerId)
        .get()
        .then((snapshot) => snapshot.docs)
        .then((results) {
      if (results.length > 0) {
        hasJoined = true;
      } else {
        hasJoined = false;
      }
    });
    return hasJoined;
  }

  Future<void> addTowerParticipation(String towerId) async {
    await towerParticipationsRef.add(TowerParticipation(
      studentId: FirebaseAuth.instance.currentUser.uid,
      towerId: towerId,
    ));
  }

  Future<void> validateJoiningCodes() async {
    final towerRef = FirebaseFirestore.instance.collection('towers').withConverter<Tower>(
      fromFirestore: (snapshot, _) => Tower.fromJson(snapshot.data()),
      toFirestore: (tower, _) => tower.toJson(),
    );
    var joiningCode = textController1.text;
    var passcode = textController2.text;
    print(joiningCode);
    print(passcode);
    await towerRef
        .where('uniqueJoiningId', isEqualTo: textController1.text)
        .where('passcode', isEqualTo: textController2.text)
        .get()
        .then((snapshot) => snapshot.docs)
        .then((results) async {
      if (results.length > 0) {
        hasJoinedTower(results[0].id).then((hasJoined){
          if (hasJoined) {
            popDialog("You have already joined this tower. Please try again!");
          } else {
            addTowerParticipation(results[0].id);
            popDialog("You've successfully added a tower!");
          }
        });
      } else {
        popDialog("There is no matching tower. Please try again!");
      }
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      appBar: AppBar(title: const Text("Add a tower")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textController1,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter tower\'s unique joining code',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textController2,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter passcode',
              ),
            ),
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              validateJoiningCodes();
            },
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }
}
