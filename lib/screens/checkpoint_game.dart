import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/models/checkpoint.dart';
import 'package:cz3003_infinity_towers/models/multiple_choice_question.dart';
import 'dart:math';
import 'package:cz3003_infinity_towers/widgets/mcq_dialog.dart';
import 'package:cz3003_infinity_towers/constants/sizes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheckpointGamePage extends StatefulWidget {
  CheckpointGamePage({Key key, @required this.checkpoint, @required this.towerId}) : super(key: key);

  final Checkpoint checkpoint;
  final String towerId;

  @override
  _CheckpointGamePageState createState() => _CheckpointGamePageState();
}

class _CheckpointGamePageState extends State<CheckpointGamePage> {

  // Display user avatar on _floor. If _floor > max level (10?), display congrats message and a go back to tower info page button.

  var _floor = 0;
  var _userAnswer = "";
  var _numWrongAnswers = 0;
  var _totalNumFloors = 10; // There are 10 levels in total right?
  Widget _userImage = Image.asset('assets/user.png', width: 50, height: 50);
  Widget _monsterImage = Image.asset('assets/monster.png', width: 50, height: 50);
  List<MultipleChoiceQuestion> selectedQuestions = [];
  List<MultipleChoiceQuestion> allEasyQuestions = [];
  List<MultipleChoiceQuestion> allMediumQuestions = [];
  List<MultipleChoiceQuestion> allHardQuestions = [];
  List<MultipleChoiceQuestion> allBossQuestions = [];

  int _calcPreviousDifficultyLevelFloor() => max(((_floor ~/ 3) - 1) * 3, 0);

  Future<void> getAllQuestions() async {
    final questionsRef = FirebaseFirestore.instance.collection('questions').withConverter<MultipleChoiceQuestion>(
      fromFirestore: (snapshot, _) => MultipleChoiceQuestion.fromJson(snapshot.data()),
      toFirestore: (question, _) => question.toJson(),
    );

    for(var qnId in widget.checkpoint.questionIds){
      await questionsRef.doc(qnId).get().then((snapshot) => snapshot.data())
        .then((qn) {
          if (qn.difficulty == 'easy') {
            allEasyQuestions.add(qn);
          } else if (qn.difficulty == 'medium') {
            allMediumQuestions.add(qn);
          } else if (qn.difficulty == 'hard') {
            allHardQuestions.add(qn);
          } else {
            allBossQuestions.add(qn);
          }
        });
    }
  }

  void reselectQuestions() {
    if (allEasyQuestions.length >=3 && allMediumQuestions.length >=3 && allHardQuestions.length >=3 && allBossQuestions.length >=1){
      final _random = Random();
      selectedQuestions.clear();
      for(var i = 0; i < 3; i++) {
        selectedQuestions.add(allEasyQuestions[_random.nextInt(allEasyQuestions.length)]);
      }
      for(var i = 0; i < 3; i++) {
        selectedQuestions.add(allMediumQuestions[_random.nextInt(allMediumQuestions.length)]);
      }
      for(var i = 0; i < 3; i++) {
        selectedQuestions.add(allHardQuestions[_random.nextInt(allHardQuestions.length)]);
      }
      selectedQuestions.add(allBossQuestions[_random.nextInt(allBossQuestions.length)]);
    }
  }

  void selectQuestions() async {
    await getAllQuestions();
    reselectQuestions();
  }

  @override
  void initState() {
    super.initState();
    selectQuestions();
  }

  void _updateFloorNumber() {
    setState(() {
      // Compare answer with correct answer only when _userAnswer is not null.
      if (_userAnswer != "") {
        var isAnswerCorrect = selectedQuestions[_floor].isAnswerCorrect(_userAnswer);
        _userAnswer = "";
        if (isAnswerCorrect) {
          _numWrongAnswers = 0;
          _floor++;
        } else {
          _numWrongAnswers++;
          reselectQuestions();
          if (_numWrongAnswers == 3) {
            _floor = _calcPreviousDifficultyLevelFloor();
          }
        }
      }
    });
  }

  void _displayQuestionDialog() async {
    _userAnswer = await showDialog(
        context: context,
        builder: (context) =>
            MultipleChoiceQuestionDialog(selectedQuestions[_floor]),
    );
    _updateFloorNumber();
  }

  void _displayUserFloorTooLowAlertDialog() {
    AlertDialog alert = AlertDialog(
      title: Text("Oops!"),
      content: Text("You have not reached this floor yet!"),
    );

    showDialog(context: context, builder: (context) => alert);
  }

  void _displayAlreadyAttemptedAlertDialog() {
    AlertDialog alert = AlertDialog(
      title: Text("Oops!"),
      content: Text("You have already attempted this question!"),
    );

    showDialog(context: context, builder: (context) => alert);
  }

  void _onClickMonster(int monsterFloor) {
    if (_floor == monsterFloor) {
      // Click on monster image to show question dialog.
     _displayQuestionDialog();
    } else if (_floor < monsterFloor) {
    // Clicking on monster image will show error dialog: floor not unlocked!
      _displayUserFloorTooLowAlertDialog();
    } else {
    // Clicking on monster image will show error dialog: already attempted!
      _displayAlreadyAttemptedAlertDialog();
    }
  }

  Widget buildSingleFloor(int monsterFloor) {
    return Container(
      height: 50,
      child: ListTile(
        leading: monsterFloor == _floor? _userImage :null,
        trailing: _monsterImage,
        onTap: () => _onClickMonster(monsterFloor),
      ),
    );
  }

  Widget buildAllFloors() {
    return ListView.separated(
        padding: const EdgeInsets.all(Sizes.smallPadding),
        itemCount: _totalNumFloors,
        itemBuilder: (BuildContext context, int index) {
          var monsterFloor = _totalNumFloors - index - 1;
          return buildSingleFloor(monsterFloor);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget buildCongratsMessage() {
    return Center(
      child: Container(
          padding: const EdgeInsets.all(Sizes.mediumPadding),
          child: Text('You have successfully completed this checkpoint! '
              'Please return to tower information page.',)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.checkpoint.name),
      ),
      body: _floor < _totalNumFloors? buildAllFloors(): buildCongratsMessage(),
    );
  }
}