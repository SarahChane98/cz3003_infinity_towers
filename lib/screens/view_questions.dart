import 'package:cz3003_infinity_towers/screens/add_question.dart';
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
import 'package:cz3003_infinity_towers/screens/edit_question.dart';
/// This class is used to display all the questions present in a particular checkpoint.
class ViewQuestions extends StatefulWidget {
  final Checkpoint rcheckpoint;
  final String checkpointID;
  final Tower tower;
  const ViewQuestions({Key key, @required this.rcheckpoint, @required this.checkpointID, @required this.tower}) : super(key: key);

  @override
  State<ViewQuestions> createState() => _ViewQuestionsState();
}

class _ViewQuestionsState extends State<ViewQuestions> {
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black,
    primary: Colors.lightBlue,
    onSurface: Colors.lightBlue,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );

  Future<List<MultipleChoiceQuestion>> getQuestions() async {
    final questionsRef = FirebaseFirestore.instance
        .collection('questions')
        .withConverter<MultipleChoiceQuestion>(
          fromFirestore: (snapshot, _) =>
              MultipleChoiceQuestion.fromJson(snapshot.data()),
          toFirestore: (checkpoint, _) => checkpoint.toJson(),
        );

    List<MultipleChoiceQuestion> multipleChoiceQuestions = [];
    for (var quesId in widget.rcheckpoint.questionIds) {
      await questionsRef
          .doc(quesId)
          .get()
          .then((snapshot) => snapshot.data())
          .then((checkpoint) => multipleChoiceQuestions.add(checkpoint));
    }
    return(multipleChoiceQuestions);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.towerInformationTitle),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(Sizes.smallPadding),
            child: Text(widget.rcheckpoint.name,
                style: TextStyle(fontSize: Sizes.mediumFont)),
          ),
          Expanded(
              child: FutureBuilder(
            future: Future.wait([getQuestions()]),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (!snapshot.hasData) {
                return Text("Waiting for Data...");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                List<MultipleChoiceQuestion> questions = snapshot.data[0];
                return ListView.builder(
                    padding: const EdgeInsets.all(Sizes.smallPadding),
                    itemCount: questions.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == questions.length) {
                        return (Center(
                            child: ElevatedButton.icon(
                                icon: Icon(
                                  Icons.add_box_rounded,
                                  color: Colors.black,
                                ),
                                label: Text("Add New Question!"),
                                style: raisedButtonStyle,
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddQuestion(checkpointID: widget.checkpointID, tower: widget.tower, origin: 'question',),
                                    ),
                                  );
                                })));
                      } else {
                        var c;
                        if (questions[index].difficulty == 'easy') {
                          c = Colors.green[300];
                        }
                        else if(questions[index].difficulty == 'medium')
                          {
                            c = Colors.amber[300];
                          }
                        else if(questions[index].difficulty == 'hard')
                          {
                            c = Colors.orange[300];
                          }
                        else
                          {
                            c = Colors.red[300];
                          }
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          color: c,
                          elevation: 10,
                          child: new InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '\t\tQuestion ${index + 1}:\t\t\t',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(questions[index].questionText,
                                    style: TextStyle(fontSize: 10))
                              ],
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => EditQuestion(question: questions[index], questionID: widget.rcheckpoint.questionIds[index]))
                              );
                            },
                          ),
                        );
                      }
                    });
              }
              return Text("Loading");
            },
          )),
        ],
      ),
    );
  }
}
