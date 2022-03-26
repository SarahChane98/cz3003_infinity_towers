import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditImagePage extends StatefulWidget {
  EditImagePage(this.imagePath);
  var imagePath;

  @override
  _EditImagePageState createState() => _EditImagePageState(imagePath);
}

class _EditImagePageState extends State<EditImagePage> {
  _EditImagePageState(this.imagePath);
  var imagePath;
  var uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title:Text(
            'Change Profile Picture',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              color: Colors.black,
              fontWeight: FontWeight.w900,),
          ),
          backgroundColor: Colors.lightBlueAccent[100],
          elevation: 0,
          centerTitle: true,
          leading: IconButton(icon:Icon(Icons.power_settings_new,size:30,color: Colors.black87,), onPressed: () {
            Navigator.of(context).pop();
          },)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: SizedBox(
                  width: 330,
                  child: GestureDetector(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (image == null) return;

                      final location = await getApplicationDocumentsDirectory();
                      final name = basename(image.path);
                      final imageFile = File('${location.path}/$name');
                      final newImage = await File(image.path).copy(imageFile.path);
                      QuerySnapshot querySnapshot = await users
                          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser.uid)
                          .get();
                      await querySnapshot.docs[0].reference.update({'imageURL':newImage.path});
                      setState(
                              () => imagePath = newImage.path);
                    },
                    child: Image.network(imagePath),
                  ))),
          Padding(
              padding: EdgeInsets.only(top: 40),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: 330,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
