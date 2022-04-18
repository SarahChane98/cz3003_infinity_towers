import 'package:cz3003_infinity_towers/screens/add_question.dart';
import 'package:cz3003_infinity_towers/models/tower.dart';
import 'package:cz3003_infinity_towers/models/checkpoint.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


/// This class is used to add a new checkpoint to a tower.
class AddNewCheckpoint extends StatefulWidget {
  final String towerID;
  final Tower tower;
  const AddNewCheckpoint({Key key, @required this.towerID, @required this.tower}) : super(key: key);

  @override
  State<AddNewCheckpoint> createState() => _AddNewCheckpointState();
}

class _AddNewCheckpointState extends State<AddNewCheckpoint> {
  final textControllerName = TextEditingController();


  String checkpointID;
  // final towerParticipationsRef = FirebaseFirestore.instance.collection('questions').withConverter<TowerParticipation>(
  //   fromFirestore: (snapshot, _) => TowerParticipation.fromJson(snapshot.data()),
  //   toFirestore: (participation, _) => participation.toJson(),
  // );
  //

  /// After a new checkpoint is created, the instructor is redirected to add a new question to that checkpoint.
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
                              AddQuestion(checkpointID: checkpointID, tower: widget.tower, origin: 'checkpoint')));
                })
          ]);
        });
  }
  CollectionReference questions = FirebaseFirestore.instance.collection('checkpoints');
  Future<void> addCheckpoint() async
  {
    questions.add({'name':textControllerName.text,
      'questionIds':[],
    }).then((value) => print("Checkpoint Added!"))
        .catchError((error) => print("Failed to add checkpoint: $error"));
  }

  Future<void> addRest() async
  {

    final questionsRef = FirebaseFirestore.instance.collection('checkpoints').withConverter<Checkpoint>(
      fromFirestore: (snapshot, _) => Checkpoint.fromJson(snapshot.data()),
      toFirestore: (participation, _) => participation.toJson(),
    );

    Future<List<QueryDocumentSnapshot<Checkpoint>>> getCheckpointList() async {
      var checkpointsList = await questionsRef
          .where('name', isEqualTo: textControllerName.text)
          .get()
          .then((snapshot) => snapshot.docs);
      return checkpointsList;
    }

    await getCheckpointList().then((checkpointList) async {
      checkpointID = checkpointList[0].id;
    });
    print(checkpointID);
    //getQuestionID();
    var collection = FirebaseFirestore.instance.collection('towers');
    collection
        .doc(widget.towerID) // <-- Document ID
        .update({'checkpointIds': FieldValue.arrayUnion([checkpointID])}) // <-- Add data
        .then((_) => print('Added $checkpointID ${widget.towerID}'))
        .catchError((error) => print('Add failed: $error'));
  }
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      appBar: AppBar(title: const Text("Add new section!")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textControllerName,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter the name of the section',
              ),
            ),
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              addCheckpoint();
              addRest();
              popDialog("Section Added!");
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

