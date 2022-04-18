import 'package:cz3003_infinity_towers/models/tower.dart';
import 'package:cz3003_infinity_towers/screens/Duel_Mode.dart';
import 'package:cz3003_infinity_towers/screens/manage_towers.dart';
import 'package:cz3003_infinity_towers/screens/tower_information.dart';
import 'package:cz3003_infinity_towers/screens/view_checkpoint.dart';
import 'package:cz3003_infinity_towers/screens/view_performance_chart.dart';
import 'package:cz3003_infinity_towers/screens/view_tower_individual_detail.dart';
import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/screens/appbar.dart';
import 'package:cz3003_infinity_towers/screens/view_tower_information.dart';
import 'package:cz3003_infinity_towers/screens/view_performance_chart_trial.dart';

/// This class is used to edit the information of a particular tower.
class EditTowerDetails extends StatefulWidget {
  final Tower tower;
  final String towerID;
  EditTowerDetails({@required this.tower, @required this.towerID});

  @override
  _EditTowerDetailsState createState() => _EditTowerDetailsState();
}

class _EditTowerDetailsState extends State<EditTowerDetails> {
  var appBarText = 'Edit Tower';
  var appBarStyle = const TextStyle(fontFamily: 'Fredoka', fontSize: 32);
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black,
    primary: Colors.red,
    onSurface: Colors.lightBlue,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
              title: Text('View Tower Detail'),
              leading: IconButton(
                  icon:Icon(Icons.arrow_back,size:30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageTowers(),
                      ),
                    );
                  }
          )),
          body: ListView(children: <Widget>[
            ViewTowerIndividualDetail(field: "Name", value: widget.tower.name),
            ViewTowerIndividualDetail(
                field: "Unique Joining ID",
                value: widget.tower.uniqueJoiningId),
            ViewTowerIndividualDetail(
                field: "Password", value: widget.tower.passcode),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.lightBlue,
              elevation: 10,
              child: new InkWell(
                child:
                    Center(
                      child: Text("View Sections", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
                    ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewCheckpoints(tower: widget.tower, towerID: widget.towerID)),
                  );
                },
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.lightBlue,
              elevation: 10,
              child: new InkWell(
                child:
                Center(
                    child: Text("View Statistics Report", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),)
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ViewPerformanceChart(title: 'THIS IS THE CHART')),
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.black,
                ),
                label: Text("Delete this tower!"),
                style: raisedButtonStyle,
                onPressed: () {
                  // write the delete function
                },
              ),
            ),
          ])),
    ));
  }
}
