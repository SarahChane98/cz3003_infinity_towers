import 'package:cz3003_infinity_towers/models/tower.dart';
import 'package:cz3003_infinity_towers/models/checkpoint.dart';
import 'package:cz3003_infinity_towers/models/tower_participation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/constants/strings.dart';
import 'package:cz3003_infinity_towers/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cz3003_infinity_towers/screens/checkpoint_error.dart';
import 'package:cz3003_infinity_towers/screens/checkpoint_game.dart';


class TowerInformationPage extends StatelessWidget {

  final Tower tower;
  final String towerId;

  TowerInformationPage({Key key, @required this.tower, @required this.towerId}): super(key: key);

  // Get a list of checkpoints using checkpointIds
  Future<List<Checkpoint>> getCheckpoints() async {
    final ckptRef = FirebaseFirestore.instance.collection('checkpoints').withConverter<Checkpoint>(
      fromFirestore: (snapshot, _) => Checkpoint.fromJson(snapshot.data()),
      toFirestore: (checkpoint, _) => checkpoint.toJson(),
    );

    List<Checkpoint> checkpoints = [];
    for(var ckptId in tower.checkpointIds){
      await ckptRef.doc(ckptId).get().then((snapshot) => snapshot.data())
          .then((checkpoint) => checkpoints.add(checkpoint));
    }

    return checkpoints;
  }

  // Get checkpointsUnlocked from tower_participation
  Future<int> getCheckpointsUnlocked() async {
    final towerParticipationsRef = FirebaseFirestore.instance.collection('tower_participations').withConverter<TowerParticipation>(
      fromFirestore: (snapshot, _) => TowerParticipation.fromJson(snapshot.data()),
      toFirestore: (participation, _) => participation.toJson(),
    );

    int ckptUnlocked;
    await towerParticipationsRef
      .where('studentId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
      .where('towerId', isEqualTo: towerId)
      .get()
      .then((snapshot) => snapshot.docs)
      .then((results) {
        ckptUnlocked = results[0].data().checkpointsUnlocked;
    });
    return ckptUnlocked;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.towerInformationTitle),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(Sizes.smallPadding),
            child: Text(tower.name, style: TextStyle(fontSize: Sizes.mediumFont)),
          ),
          Expanded(
            child: FutureBuilder(
              future: Future.wait([getCheckpoints(), getCheckpointsUnlocked()]),
              builder: (BuildContext context, snapshot){
                if (snapshot.hasError) {
                return Text("Something went wrong");
                }

                if (!snapshot.hasData) {
                return Text("Document does not exist");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  List<Checkpoint> checkpoints = snapshot.data[0];
                  int checkpointsUnlocked = snapshot.data[1];
                  return ListView.builder(
                      padding: const EdgeInsets.all(Sizes.smallPadding),
                      itemCount: checkpoints.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          height: Sizes.checkpointTileHeight,
                          child: ListTile(
                            title: Text('Checkpoint ${index + 1}'),
                            trailing: index <= checkpointsUnlocked?
                            Text(checkpoints[index].name)
                                : Icon(Icons.lock),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context)
                                  => index <= checkpointsUnlocked?
                                    CheckpointGamePage(checkpoint: checkpoints[index], towerId: towerId)
                                    :CheckpointErrorPage(),
                                ),
                              );
                            },
                          ),
                        );
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
