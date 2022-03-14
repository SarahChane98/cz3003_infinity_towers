import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewTowerInformation extends StatelessWidget {
  //const ViewTowerInformation({Key? key}) : super(key: key);
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
          print("Hello");
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
