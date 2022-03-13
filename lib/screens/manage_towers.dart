import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/screens/appbar.dart';

class ManageTowers extends StatefulWidget {
  @override
  _ManageTowersState createState() => _ManageTowersState();
}

class _ManageTowersState extends State<ManageTowers> {
  var appBarText = 'Manage Towers';
  var appBarStyle = const TextStyle(fontFamily: 'Fredoka', fontSize: 32);
  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      home: Scaffold(
        appBar: headerNav(title: 'Manage Towers'),
        body: Text('Raju'),
      ),
    ));
  }
}

