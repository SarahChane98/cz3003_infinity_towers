import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:cz3003_infinity_towers/models/tower.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
// This class handles the Page to edit the Name Section of the User Profile.
class EditTowerName extends StatefulWidget {
  const EditTowerName({Key key}) : super(key: key);

  @override
  EditTowerNameState createState() {
    return EditTowerNameState();
  }
}

class EditTowerNameState extends State<EditTowerName> {
  final _formKey = GlobalKey<FormState>();
  final NameController = TextEditingController();
  //var user = new Tower();

  @override
  void dispose() {
    NameController.dispose();
    super.dispose();
  }
  CollectionReference users = FirebaseFirestore.instance.collection('towers');
  Future<void> updateUserValue(String name) {


  }
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  width: 330,
                  child: const Text(
                    "What's Your Name?",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
                      child: SizedBox(
                          height: 100,
                          width: 150,
                          child: TextFormField(
                            // Handles Form Validation for First Name
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your first name';
                              } else if (!isAlpha(value)) {
                                return 'Only Letters Please';
                              }
                              return null;
                            },
                            decoration:
                            InputDecoration(labelText: 'Name'),
                            controller: NameController,
                          ))),
                ],
              ),
              Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: 330,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate returns true if the form is valid, or false otherwise.
                            if (isAlpha(NameController.text)) {
                              updateUserValue(NameController.text);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Update',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      )))
            ],
          ),
        ));
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: <Widget>[
//               SizedBox(
//                   width: 330,
//                   child: const Text(
//                     "What's Your Name?",
//                     style: TextStyle(
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   )),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Padding(
//                       padding: EdgeInsets.fromLTRB(0, 40, 16, 0),
//                       child: SizedBox(
//                           height: 100,
//                           width: 150,
//                           child: TextFormField(
//                             // Handles Form Validation for First Name
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter your first name';
//                               } else if (!isAlpha(value)) {
//                                 return 'Only Letters Please';
//                               }
//                               return null;
//                             },
//                             decoration:
//                             InputDecoration(labelText: 'First Name'),
//                             controller: NameController,
//                           ))),
//
//                 ],
//               ),
//               Padding(
//                   padding: EdgeInsets.only(top: 150),
//                   child: Align(
//                       alignment: Alignment.bottomCenter,
//                       child: SizedBox(
//                         width: 330,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Validate returns true if the form is valid, or false otherwise.
//                             if (_formKey.currentState.validate()) {
//                               updateUserValue(NameController.text);
//                               Navigator.pop(context);
//                             }
//                           },
//                           child: const Text(
//                             'Update',
//                             style: TextStyle(fontSize: 15),
//                           ),
//                         ),
//                       )))
//             ],
//           ),
//         ));
//   }
// }