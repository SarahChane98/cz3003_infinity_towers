import 'package:cz3003_infinity_towers/screens/add_new_checkpoint.dart';
import 'package:cz3003_infinity_towers/screens/view_questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:cz3003_infinity_towers/models/tower.dart';
import 'package:cz3003_infinity_towers/models/checkpoint.dart';
import 'package:cz3003_infinity_towers/constants/strings.dart';
import 'package:cz3003_infinity_towers/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cz3003_infinity_towers/models/multiple_choice_question.dart';
import 'package:cz3003_infinity_towers/models/tower_participation.dart';
class ViewCheckpoints extends StatefulWidget {
  final Tower tower;
  final String towerID;
  const ViewCheckpoints({Key key, @required this.tower, @required this.towerID}) : super(key: key);

  @override
  State<ViewCheckpoints> createState() => _ViewCheckpointsState();
}

class _ViewCheckpointsState extends State<ViewCheckpoints> {
  Future<List<Checkpoint>> getCheckpoints() async {
    final ckptRef = FirebaseFirestore.instance.collection('checkpoints').withConverter<Checkpoint>(
      fromFirestore: (snapshot, _) => Checkpoint.fromJson(snapshot.data()),
      toFirestore: (checkpoint, _) => checkpoint.toJson(),
    );

    List<Checkpoint> checkpoints = [];
    for(var ckptId in widget.tower.checkpointIds){
      await ckptRef.doc(ckptId).get().then((snapshot) => snapshot.data())
          .then((checkpoint) => checkpoints.add(checkpoint));
    }
    return checkpoints;
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black,
    primary: Colors.lightBlue,
    onSurface: Colors.lightBlue,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sections"),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(Sizes.smallPadding),
            child: Text(widget.tower.name, style: TextStyle(fontSize: Sizes.mediumFont)),
          ),
          Expanded(
              child: FutureBuilder(
                future: Future.wait([getCheckpoints()]),
                builder: (BuildContext context, snapshot){
                  if (snapshot.hasError) {
                    return Text("Something went wrong");
                  }

                  if (!snapshot.hasData) {
                    return Text("Document does not exist");
                  }

                  if (snapshot.connectionState == ConnectionState.done) {
                    List<Checkpoint> checkpoints = snapshot.data[0];
                    return ListView.builder(
                        padding: const EdgeInsets.all(Sizes.smallPadding),
                        itemCount: checkpoints.length+1,
                        itemBuilder: (BuildContext context, int index) {
                          if(index==checkpoints.length)
                            {
                              return(Center(
                                  child: ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.add_box_rounded,
                                        color: Colors.black,
                                      ),
                                      label: Text("Add New Checkpoint!"),
                                      style: raisedButtonStyle,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddNewCheckpoint(towerID: widget.towerID, tower: widget.tower),
                                          ),
                                        );
                                      }
                                  )
                              ));
                            }
                          else {
                            return Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              color: Colors.lightBlue,
                              elevation: 10,
                              child: new InkWell(
                                child: Column(

                                  children: [
                                    Text('\t\tCheckpoint ${index+1}:\t\t\t',
                                      style: TextStyle(fontSize: 22,
                                          fontWeight: FontWeight.bold),),
                                    Text(checkpoints[index].name,
                                        style: TextStyle(fontSize: 22))
                                  ],
                                )
                                ,
                                onTap: () {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => ViewQuestions(rcheckpoint: checkpoints[index], checkpointID: widget.tower.checkpointIds[index], tower: widget.tower,))
                                  );
                                },
                              ),
                            );
                          }
                        }
                    );
                  }
                  return Text("Loading");
                },
              )
          ),
        ],
      ),
    );
  }
}
