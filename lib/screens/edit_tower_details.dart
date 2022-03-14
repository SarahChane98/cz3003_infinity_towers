import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/screens/appbar.dart';
import 'package:cz3003_infinity_towers/screens/view_tower_information.dart';
class EditTowerDetails extends StatefulWidget {
  @override
  _EditTowerDetailsState createState() => _EditTowerDetailsState();
}

class _EditTowerDetailsState extends State<EditTowerDetails> {
  var appBarText = 'Manage Towers';
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
          appBar: headerNav(title: 'Manage Towers'),
          body: ListView(children: <Widget>[
            ViewTowerInformation(),
            Center(
              child: ElevatedButton.icon(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.black,
                ),
                label: Text("Delete this tower!"),
                style: raisedButtonStyle,
                onPressed: () {},
              ),
            ),

          ])),
    ));
  }
}
