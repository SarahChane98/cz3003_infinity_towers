import 'package:flutter/material.dart';

AppBar headerNav({String title, context, returnFunction}) {
  const appBarStyle = TextStyle(fontFamily: 'Fredoka', fontSize: 32);

  return (AppBar(
    leading: IconButton(icon:Icon(Icons.power_settings_new,size:30), onPressed: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => returnFunction,
        ),
      );
    },),
    title: Center(
      child: Text(
        title,
        style: appBarStyle,
      ),
    ),
    toolbarOpacity: 1,
    backgroundColor: Colors.lightBlue,
    foregroundColor: Colors.black,
  ));
}