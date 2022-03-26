import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cz3003_infinity_towers/screens/edit_tower_name.dart';
import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/screens/edit_tower_parameter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dart:async';
class ViewTowerIndividualDetail extends StatefulWidget {
  String field;
  String value;
  ViewTowerIndividualDetail({Key key, @required this.field, @required this.value}) : super(key: key);

  @override
  State<ViewTowerIndividualDetail> createState() => _ViewTowerIndividualDetailState();

}

class _ViewTowerIndividualDetailState extends State<ViewTowerIndividualDetail> {

  String val = '';
  refresh(String text) {
    setState(() {
      val = text;
    });
  }

  @override
  Card build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.lightBlue,
      elevation: 10,
      child: new InkWell(
        child: Row(

          children: [
            Text('\t\t'+widget.field+':\t\t\t', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            val == '' ? Text(widget.value, style:TextStyle(fontSize: 15)):Text(val, style: TextStyle(fontSize: 22))
          ],
        )
        ,
        onTap: () {
          _displayTextInputDialog(context);
          refresh(_textFieldController.text);
        },
        ),
      );
  }

  final _textFieldController = TextEditingController();

  Future<void> _displayTextInputDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit '+widget.field),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: widget.value),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('SAVE'),
              onPressed: () {
               refresh(_textFieldController.text);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}


