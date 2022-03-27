import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/models/tower_participation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cz3003_infinity_towers/constants/sizes.dart';
import 'dart:collection';

class TowerLeaderboardPage extends StatelessWidget {
  TowerLeaderboardPage({Key key, @required this.towerId}) : super(key: key);

  final String towerId;
  final towerParticipationsRef = FirebaseFirestore.instance.collection('tower_participations').withConverter<TowerParticipation>(
    fromFirestore: (snapshot, _) => TowerParticipation.fromJson(snapshot.data()),
    toFirestore: (participation, _) => participation.toJson(),
  );

  Future<String> getUserEmail(String uid) async {
    CollectionReference usersRef = FirebaseFirestore.instance.collection('users');
    String userEmail;
    await usersRef.where('uid', isEqualTo: uid).get().then((value) {
      userEmail = (value.docs[0].data() as Map<String, dynamic>)['email'];
    });
    return userEmail;
  }

  Future<Map<String, int>> getAllUserScores() async {
    Map<String, int> allUserScores = {};
    await towerParticipationsRef
      .where('towerId', isEqualTo: towerId)
      .get()
      .then((snapshot) => snapshot.docs)
      .then((participations) async {
        for (var querySnapshot  in participations) {
          var userId = querySnapshot.data().studentId;
          await getUserEmail(userId).then((email) {
            allUserScores[email] = querySnapshot.data().score;
          });
        }
    });
    return allUserScores;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Leaderboard", textAlign: TextAlign.center),
        ),
        body: FutureBuilder(
            future: getAllUserScores(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (!snapshot.hasData) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, int> userScores = snapshot.data;
                final sortedScores = SplayTreeMap.from(
                    userScores, (key2, key1) => userScores[key1].compareTo(userScores[key2]));
                var emails = sortedScores.keys.toList();
                var scores = sortedScores.values.toList();
                return ListView.separated(
                  padding: const EdgeInsets.all(Sizes.smallPadding),
                  itemCount: scores.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(

                      height: Sizes.towerTileHeight,
                      child: ListTile(
                        title: Text(emails[index]),
                        trailing: Text(scores[index].toString()),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                );
              }
              return Text("Loading");
            }
        )
    );
  }
}
