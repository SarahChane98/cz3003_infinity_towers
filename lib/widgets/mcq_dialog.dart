import 'package:cz3003_infinity_towers/models/multiple_choice_question.dart';
import 'package:flutter/material.dart';

class MultipleChoiceQuestionDialog extends StatelessWidget {

  MultipleChoiceQuestionDialog(this.question);

  final MultipleChoiceQuestion question;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(question.questionText),
      children: [
        SimpleDialogOption(
          onPressed: () {Navigator.pop(context, "A");},
          child: Text(question.choiceA),
        ),
        SimpleDialogOption(
          onPressed: () {Navigator.pop(context, "B");},
          child: Text(question.choiceB),
        ),
        SimpleDialogOption(
          onPressed: () {Navigator.pop(context, "C");},
          child: Text(question.choiceC),
        ),
        SimpleDialogOption(
          onPressed: () {Navigator.pop(context, "D");},
          child: Text(question.choiceD),
        ),
      ],
    );
  }
}
