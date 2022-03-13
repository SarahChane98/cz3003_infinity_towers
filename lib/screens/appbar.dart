import 'package:flutter/material.dart';

class ReusableWidgets {
  static getAppBar(
      String title,
      Color border,
      Color bgColor,
      ) {
    return AppBar(
        title: Text(title,
            style: TextStyle(
                color: border, fontSize: 35, fontWeight: FontWeight.bold)),
        backgroundColor: bgColor,
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(
          color: border,
        ),
        bottom: PreferredSize(
            child: Container(
              color: border,
              height: 4.0,
            ),
            preferredSize: Size.fromHeight(4.0)));
  }

  static getBox1() {
    return Container(
      padding: EdgeInsets.only(left: 40, right: 40),
      child: SizedBox(
          width: 300.0,
          child: RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.white)),
            padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
            textColor: Colors.white,
            color: Colors.grey[300],
            onPressed: () {},
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 60),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text("Question to be asked",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))
                  ]),
            ),
          )),
    );
  }
}
