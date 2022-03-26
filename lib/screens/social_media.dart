/**
 * This class return the logic of incorporating
 * social media in the application.
 *
 *
 */

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class SocialMedia extends StatefulWidget {
  SocialMedia({this.text, this.image, this.shareText, this.color});
  String text;
  String image;
  String shareText;
  Color color;
  @override
  SocialMediaState createState() => SocialMediaState();
}

class SocialMediaState extends State<SocialMedia> {
  SocialMediaState({this.text, this.image, this.shareText, this.color});
  String text;
  String image;
  String shareText;
  Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Builder(
          builder: (BuildContext context) {
            return ElevatedButton(
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image(image: AssetImage(widget.image), height: 35.0),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            widget.text,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ])),
              onPressed: () async {
                final RenderBox box = context.findRenderObject();
                await Share.share('look');
              },
            );
          },
        ),
      ],
    );
  }
}
