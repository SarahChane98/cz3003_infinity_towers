import 'package:flutter/material.dart';

AppBar headerNav({String title}) {
  const appBarStyle = TextStyle(fontFamily: 'Fredoka', fontSize: 32);

  return (AppBar(
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