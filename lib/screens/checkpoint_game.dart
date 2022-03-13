import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/models/mock_data.dart';
import 'dart:math';
import 'package:cz3003_infinity_towers/widgets/mcq_dialog.dart';
import 'package:cz3003_infinity_towers/constants/sizes.dart';


class CheckpointGamePage extends StatefulWidget {
  CheckpointGamePage({Key key, this.checkpoint}) : super(key: key);

  final Checkpoint checkpoint;

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

  void _updateFloorNumber() {
    setState(() {
      // Compare answer with correct answer only when _userAnswer is not null.
      if (_userAnswer != "") {
        var isAnswerCorrect = widget.checkpoint.questions[_floor].isAnswerCorrect(_userAnswer);
        _userAnswer = "";
        if (isAnswerCorrect) {
          _numWrongAnswers = 0;
          _floor++;
        } else {
          _numWrongAnswers++;
          if (_numWrongAnswers == 3) {
            _floor = max(_floor - 1, 0);
          }
        }
      }
    });
  }

  void _displayQuestionDialog() async {
    _userAnswer = await showDialog(
        context: context,
        builder: (context) =>
            MultipleChoiceQuestionDialog(widget.checkpoint.questions[_floor]),
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