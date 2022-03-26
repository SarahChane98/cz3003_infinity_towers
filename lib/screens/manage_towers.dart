import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/screens/appbar.dart';
import 'package:cz3003_infinity_towers/screens/Home_Screen.dart';
import 'package:cz3003_infinity_towers/screens/view_tower_information.dart';

class ManageTowers extends StatefulWidget {
  @override
  _ManageTowersState createState() => _ManageTowersState();
}

class _ManageTowersState extends State<ManageTowers> {
  var appBarText = 'Manage Towers';
  var appBarStyle = const TextStyle(fontFamily: 'Fredoka', fontSize: 32);

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black,
    primary: Colors.lightBlue,
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
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Manage Towers',
              textAlign: TextAlign.center,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black,size: 30,),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: ListView(children: <Widget>[
            ViewTowerInformation(),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.add_box_rounded,
                  color: Colors.black,
                ),
                label: Text("Add New Tower!"),
                style: raisedButtonStyle,
                onPressed: () {},
              ),
            ),
          ])),
    ));
  }
}
