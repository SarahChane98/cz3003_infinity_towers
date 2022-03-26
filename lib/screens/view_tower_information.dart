import 'package:cz3003_infinity_towers/models/tower.dart';
import 'package:cz3003_infinity_towers/screens/edit_tower_details.dart';
import 'package:cz3003_infinity_towers/screens/tower_information.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewTowerInformation extends StatelessWidget {
  const ViewTowerInformation({Key key}) : super(key: key);
  final towerName = 'Tower 1';
  final dateCreated = "15/03/2022";
  final totalParticipants="10";
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.lightBlue,
      elevation: 10,
      child: new InkWell(
        onTap: () {
          // Navigator.of(context).push(
          //     MaterialPageRoute(
          //     builder: (context) => EditTowerDetails(towerName))
          //     );
        },
        //splashColor: Colors.lightBlueAccent,
        child: Column(children: <Widget>[
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.copy,
                  color: Colors.black),
              onPressed: () {
                print("Copy Tower Access Details");
                // NEED TO CODE THE LOGIC
              },
            ),
            title:
                Text(towerName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            subtitle: Text("Date of Creation: "+dateCreated+"\nTotal Participants: "+totalParticipants),
            isThreeLine: true,

            // trailing: new IconButton(
            //   icon: new Icon(Icons.delete, color: Colors.black),
            //   onPressed: () {
            //     print("DELETE");
            //   },
            // ),
          ),
        ]),
      ),
    );
  }
}
