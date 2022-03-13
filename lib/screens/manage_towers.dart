import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/screens/appbar.dart';
import 'package:cz3003_infinity_towers/screens/Login_Screen.dart';
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
        appBar: AppBar(title: const Text('Manage Towers',textAlign: TextAlign.center,),
          leading: IconButton(icon:Icon(Icons.power_settings_new,size:30), onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },),
        ),
        body: Text('Raju'),
      ),
    ));
  }
}

