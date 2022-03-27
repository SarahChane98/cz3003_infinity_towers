import 'package:cz3003_infinity_towers/models/tower.dart';
import 'package:cz3003_infinity_towers/screens/manage_towers.dart';
import 'package:cz3003_infinity_towers/screens/send_challenge.dart';
import 'package:cz3003_infinity_towers/screens/tower_information.dart';
import 'package:cz3003_infinity_towers/screens/view_checkpoint.dart';
import 'package:cz3003_infinity_towers/screens/view_performance_chart.dart';
import 'package:cz3003_infinity_towers/screens/view_tower_individual_detail.dart';
import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/screens/appbar.dart';
import 'package:cz3003_infinity_towers/screens/view_tower_information.dart';
import 'package:cz3003_infinity_towers/screens/view_performance_chart_trial.dart';
import 'package:cz3003_infinity_towers/screens/Main_Student.dart';
class DuelMode extends StatefulWidget {
  const DuelMode({Key key}) : super(key: key);

  @override
  State<DuelMode> createState() => _DuelModeState();
}

class _DuelModeState extends State<DuelMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Duel Mode',
          textAlign: TextAlign.center,
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black,size: 30,),
            onPressed: () => //Navigator.of(context).pop(),
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        EntSScreen('')
                ))
        ),
      ),
      body: ListView(children: <Widget>[
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.lightBlue,
            elevation: 10,
            child: new InkWell(
                child: Column(
              children: [
                Text(
                  'Challenge History',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ))),
        Center(
            child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            child: Table(
              defaultColumnWidth: FixedColumnWidth(120.0),
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
              children: [
                TableRow(children: [
                  Column(children: [
                    Text('Opponent', style: TextStyle(fontSize: 20.0))
                  ]),
                  Column(children: [
                    Text('Score', style: TextStyle(fontSize: 20.0))
                  ]),
                  Column(children: [
                    Text('Result', style: TextStyle(fontSize: 20.0))
                  ]),
                ]),
                TableRow(children: [
                  Column(children: [Text('iyer0004@gmail.com')]),
                  Column(children: [Text('8-9')]),
                  Column(children: [Text('Loss')]),
                ]),
                TableRow(children: [
                  Column(children: [Text(' iyer0004@gmail.com')]),
                  Column(children: [Text('7-9')]),
                  Column(children: [Text('Loss')]),
                ]),
                TableRow(children: [
                  Column(children: [Text(' snehaa@gmail.com')]),
                  Column(children: [Text('7-6')]),
                  Column(children: [Text('Win')]),
                ]),
              ],
            ),
          ),
        ])),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.lightBlue,
            elevation: 10,
            child: new InkWell(
                child: Column(
              children: [
                Text(
                  'Received Challenges',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ))),
        Row(
          children: [
            Expanded (child: Card(
                color: Colors.lightBlue,
                elevation: 10,
                child: new InkWell(
                    child: Column(
                  children: [
                    Text(
                      'xinyi@gmail.com',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text('Topic: operators')
                  ],
                )))),
            Card(
              color: Colors.green,
              child: new InkWell(
                  child: Icon(Icons.check),
                      onTap: ()
                  {
                  }
              )
            ),
            Card(
                color: Colors.red,
                child: new InkWell(
                    child: Icon(Icons.close),
                    onTap: ()
                    {
                    }
                )
            ),
    // )
          ],
        ),
        Row(
          children: [
            Expanded (child:Card(
                color: Colors.lightBlue,
                elevation: 10,
                child: new InkWell(
                    child: Column(
                      children: [
                        Text(
                          'iyer0004@gmail.com',
                          style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Text('Topic: operators')
                      ],
                    )))),
            Card(
                color: Colors.green,
                child: new InkWell(
                    child: Icon(Icons.check),
                    onTap: ()
                    {
                    }
                )
            ),
            Card(
                color: Colors.red,
                child: new InkWell(
                    child: Icon(Icons.close),
                    onTap: ()
                    {
                    }
                )
            ),
            // )
          ],
        ),
        Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.lightBlue,
            elevation: 10,
            child: new InkWell(
              onTap: ()
                {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SendChallenge()));
                },
                child: Column(
              children: [
                Text(
                  'Send Challenge',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                )
              ],
            ))),

      ]),
    );
  }
}
