import 'package:cz3003_infinity_towers/screens/individual_question_information.dart';
import 'package:cz3003_infinity_towers/screens/view_checkpoint.dart';
import 'package:cz3003_infinity_towers/screens/view_questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:cz3003_infinity_towers/models/tower.dart';
import 'package:cz3003_infinity_towers/models/checkpoint.dart';
import 'package:cz3003_infinity_towers/constants/strings.dart';
import 'package:cz3003_infinity_towers/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cz3003_infinity_towers/models/multiple_choice_question.dart';
import 'package:cz3003_infinity_towers/models/tower_participation.dart';
import 'package:cz3003_infinity_towers/screens/appbar.dart';
import 'package:cz3003_infinity_towers/screens/view_tower_individual_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cz3003_infinity_towers/screens/manage_towers.dart';

/// This class is used to add a new question to a checkpoint.
class AddQuestion extends StatefulWidget {
  final String checkpointID;
  final Tower tower;
  final String origin;
  const AddQuestion(
      {Key key, @required this.checkpointID, @required this.tower, @required this.origin})
      : super(key: key);

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final textControllerQuestion = TextEditingController();
  final textControllerChoiceA = TextEditingController();
  final textControllerChoiceB = TextEditingController();
  final textControllerChoiceC = TextEditingController();
  final textControllerChoiceD = TextEditingController();
  final textControllerCorrectAnswer = TextEditingController();
  final textControllerDifficulty = TextEditingController();

  String questionID;
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
                  if(widget.origin == 'question')
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ViewCheckpoints(tower: widget.tower)));
                    }
                  if(widget.origin == 'checkpoint') {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ManageTowers()));
                  }
                  //Navigator.pop(context);
                })
          ]);
        });
  }

  CollectionReference questions =
      FirebaseFirestore.instance.collection('questions');
  Future<void> addQuestion() async {
    questions
        .add({
          'questionText': textControllerQuestion.text,
          'choiceA': textControllerChoiceA.text,
          'choiceB': textControllerChoiceB.text,
          'choiceC': textControllerChoiceC.text,
          'choiceD': textControllerChoiceD.text,
          'correctAnswer': textControllerCorrectAnswer.text,
          'difficulty': textControllerDifficulty.text
        })
        .then((value) => print("Question Added!"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> addRest() async {
    final questionsRef = FirebaseFirestore.instance
        .collection('questions')
        .withConverter<MultipleChoiceQuestion>(
          fromFirestore: (snapshot, _) =>
              MultipleChoiceQuestion.fromJson(snapshot.data()),
          toFirestore: (participation, _) => participation.toJson(),
        );

    Future<List<QueryDocumentSnapshot<MultipleChoiceQuestion>>>
        getQuestions() async {
      var questions = await questionsRef
          .where('questionText', isEqualTo: textControllerQuestion.text)
          .where('difficulty', isEqualTo: textControllerDifficulty.text)
          .get()
          .then((snapshot) => snapshot.docs);
      return questions;
    }

    // Future<void> getQuestionID() async {
    //
    //     } );
    // }
    await getQuestions().then((questions) async {
      questionID = questions[0].id;
    });
    print(questionID);
    //getQuestionID();
    var collection = FirebaseFirestore.instance.collection('checkpoints');
    collection
        .doc(widget.checkpointID) // <-- Document ID
        .update({
          'questionIds': FieldValue.arrayUnion([questionID])
        }) // <-- Add data
        .then((_) => print('Added $questionID ${widget.checkpointID}'))
        .catchError((error) => print('Add failed: $error'));
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      appBar: AppBar(title: const Text("Add new question!")),
      body: ListView(children: <Widget> [
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textControllerQuestion,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter the question',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textControllerChoiceA,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Option A',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textControllerChoiceB,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Option B',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textControllerChoiceC,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Option C',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textControllerChoiceD,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter Option D',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textControllerCorrectAnswer,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter the correct option',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              controller: textControllerDifficulty,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter the difficulty',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: TextFormField(
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Multi Select?',
              ),
            ),
          ),
          ElevatedButton(
            style: style,
            onPressed: () {
              addQuestion();
              addRest();
              popDialog("Question Added!");
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
