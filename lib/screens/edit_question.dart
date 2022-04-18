import 'package:cz3003_infinity_towers/screens/individual_question_information.dart';
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
/// This class is used to edit the information of a particular question.
class EditQuestion extends StatefulWidget {
  final MultipleChoiceQuestion question;
  final String questionID;
  const EditQuestion({Key key, @required this.question, @required this.questionID}) : super(key: key);

  @override
  State<EditQuestion> createState() => _EditQuestionState();
}

class _EditQuestionState extends State<EditQuestion> {

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Manage Towers',
                textAlign: TextAlign.center,
              ),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  }
              ),
                  ),
            body: ListView(children: <Widget>[
              IndividualQuestionInformation(
                  field: "Question", value: widget.question.questionText, questionID: widget.questionID),
              IndividualQuestionInformation(
                  field: "Choice A", value: widget.question.choiceA, questionID: widget.questionID),
              IndividualQuestionInformation(
                  field: "Choice B", value: widget.question.choiceB, questionID: widget.questionID),
              IndividualQuestionInformation(
                  field: "Choice C", value: widget.question.choiceC, questionID: widget.questionID),
              IndividualQuestionInformation(
                  field: "Choice D", value: widget.question.choiceD, questionID: widget.questionID),
              IndividualQuestionInformation(
                  field: "Correct Answer", value: widget.question.correctAnswer, questionID: widget.questionID),
              IndividualQuestionInformation(
                  field: "Difficulty", value: widget.question.difficulty, questionID: widget.questionID),
            ]))));
  }
}
