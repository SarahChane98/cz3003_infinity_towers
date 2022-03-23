import 'package:flutter/material.dart';

class LoginSignupButton extends StatelessWidget {
  final String title;
  final dynamic  ontapp;
  final dynamic buttonstyle;

  LoginSignupButton({this.title, this.ontapp, this.buttonstyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: 
            ontapp,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,

              style: TextStyle(fontSize: 20,color:Colors.black,),
            ),
          ),
          style: buttonstyle,
        ),
      ),
    );
  }
}