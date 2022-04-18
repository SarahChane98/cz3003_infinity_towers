import 'package:cz3003_infinity_towers/screens/Duel_Mode.dart';
import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/screens/edit_tower_details.dart';
/// This function is used to send the challenge to another user.
class SendChallenge extends StatefulWidget {
  const SendChallenge({Key key}) : super(key: key);

  @override
  State<SendChallenge> createState() => _SendChallengeState();
}

class _SendChallengeState extends State<SendChallenge> {

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
                                DuelMode()
                        )
                    );
                  }
          )
                  //Navigator.pop(context)
          ]
          );
        }
        );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Send Challenge',
                textAlign: TextAlign.center,
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: Column(
              children: [
                Row(
                  children: [
                    Text('\tSelect the opponent\t\t'),
                    Expanded(child: AutocompleteOpponent())
                  ],
                ),
                Row(
                  children: [
                    Text('\tSelect the topic\t\t'),
                    Expanded(child: AutocompleteTopic())
                  ],
                ),
                Center(
                  child: ElevatedButton(

                    child: Text("Send Challenge!"),
                    style: ButtonStyle(),
                    onPressed: () {
                      popDialog('Challenge Sent!');
                    },
                  ),
                ),
              ],
            )
        )
    );
  }
}

class AutocompleteOpponent extends StatelessWidget {
  const AutocompleteOpponent({Key key}) : super(key: key);

  static const List<String> _kOptions = <String>['iyer0004@gmail.com',
    'xinyi@gmail.com',
    'snehaa@gmail.com',
    'jackson@gmail.com',
    'lionel@gmail.com',
    'yuhaan@gmail.com',
    'alloysius@gmail.com',
    'jiawei@gmail.com'];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        print('You just selected $selection');
      },
    );
  }
}

class AutocompleteTopic extends StatelessWidget {
  const AutocompleteTopic({Key key}) : super(key: key);

  static const List<String> _kOptions = <String>[
    'Requirement Engineering',
    'Requirement Analysis',
    'Requirement Specification',
    'Software Design',
    'Software Quality attributes',
    'Software Architecture',
    'Architectural Styles',
    'Software Architectural Design',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _kOptions.where((String option) {
          return option.contains(textEditingValue.text.toLowerCase());
        });
      },
      onSelected: (String selection) {
        print('You just selected $selection');
      },
    );
  }
}



