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

class IndividualQuestionInformation extends StatefulWidget {
  final String field;
  final String value;
  final String questionID;
  const IndividualQuestionInformation(
      {Key key,
      @required this.field,
      @required this.value,
      @required this.questionID})
      : super(key: key);

  @override
  State<IndividualQuestionInformation> createState() =>
      _IndividualQuestionInformationState();
}

class _IndividualQuestionInformationState
    extends State<IndividualQuestionInformation> {
  String val = '';
  refresh(String text) {
    setState(() {
      val = text;
    });
  }

  String cat = '';
  @override
  Card build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.lightBlue,
      elevation: 10,
      child: new InkWell(
        child: Column(
          children: [
            Text(
              '\t\t' + widget.field + ':\t\t\t',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            val == ''
                ? Text(widget.value, style: TextStyle(fontSize: 15))
                : Text(val, style: TextStyle(fontSize: 15))
          ],
        ),
        onTap: () {
          if (widget.field == 'Question') {
            cat = 'questionText';
          } else if (widget.field == 'Choice A') {
            cat = 'choiceA';
          } else if (widget.field == 'Choice B') {
            cat = 'choiceB';
          } else if (widget.field == 'Choice C') {
            cat = 'choiceC';
          } else if (widget.field == 'Choice D') {
            cat = 'choiceD';
          } else if (widget.field == 'Correct Answer') {
            cat = 'correctAnswer';
          } else if (widget.field == 'Difficulty') {
            cat = 'difficulty';
          }
          _displayTextInputDialog(context);
        },
      ),
    );
  }

  final _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit ' + widget.field),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: widget.value),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('SAVE'),
              onPressed: () {
                if (widget.field == 'Question') {
                  cat = 'questionText';
                } else if (widget.field == 'Choice A') {
                  cat = 'choiceA';
                } else if (widget.field == 'Choice B') {
                  cat = 'choiceB';
                } else if (widget.field == 'Choice C') {
                  cat = 'choiceC';
                } else if (widget.field == 'Choice D') {
                  cat = 'choiceD';
                } else if (widget.field == 'Correct Answer') {
                  cat = 'correctAnswer';
                } else if (widget.field == 'Difficulty') {
                  cat = 'difficulty';
                }

                refresh(_textFieldController.text);
                print(widget.questionID);
                print(cat);
                print(_textFieldController.text);
                CollectionReference questions =
                FirebaseFirestore.instance.collection('questions');
                questions
                    .doc(widget.questionID)
                    .update({cat:_textFieldController.text})
                    .then((value) => print("User Updated ${widget.questionID} $cat $_textFieldController.text"))
                    .catchError((error) => print("Failed to update user: $error"));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
