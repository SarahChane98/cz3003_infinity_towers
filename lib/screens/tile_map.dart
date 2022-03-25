import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cz3003_infinity_towers/screens/Home_Screen.dart';
import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/constants/strings.dart';
import 'package:cz3003_infinity_towers/constants/sizes.dart';
import 'package:cz3003_infinity_towers/models/tower.dart';
import 'package:cz3003_infinity_towers/models/tower_participation.dart';
import 'package:cz3003_infinity_towers/screens/tower_information.dart';

class TileMapPage extends StatelessWidget {
  final towerParticipationsRef = FirebaseFirestore.instance.collection('tower_participations').withConverter<TowerParticipation>(
    fromFirestore: (snapshot, _) => TowerParticipation.fromJson(snapshot.data()),
    toFirestore: (participation, _) => participation.toJson(),
  );

  final towerRef = FirebaseFirestore.instance.collection('towers').withConverter<Tower>(
    fromFirestore: (snapshot, _) => Tower.fromJson(snapshot.data()),
    toFirestore: (tower, _) => tower.toJson(),
  );

  Future<List<QueryDocumentSnapshot<TowerParticipation>>> getParticipations() async {
     var participatedTowers = await towerParticipationsRef
        .where('studentId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((snapshot) => snapshot.docs);
     return participatedTowers;
  }

  Future<List<Tower>> getTowers() async {
    List<Tower> towers = [];
    await getParticipations().then((participations) async {
      for (var querySnapshot in participations) {
        String towerId = querySnapshot.data().towerId;
        await towerRef.doc(towerId).get().then((snapshot) => snapshot.data())
            .then((tower) => towers.add(tower));
      }
    });
    return towers;
  }

  Future<List<String>> getTowerIds() async {
    List<String> towerIds = [];
    await getParticipations().then((participations) async {
      for (var querySnapshot in participations) {
        String towerId = querySnapshot.data().towerId;
        towerIds.add(towerId);
      }
    });
    return towerIds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.tileMapTitle, textAlign: TextAlign.center,),
        leading: IconButton(icon:Icon(Icons.power_settings_new,size:30), onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        },),
      ),
      body: FutureBuilder(
        future: Future.wait([getTowers(), getTowerIds()]),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (!snapshot.hasData) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<Tower> towers = snapshot.data[0];
            List<String> towerIds = snapshot.data[1];
            return ListView.separated(
              padding: const EdgeInsets.all(Sizes.smallPadding),
              itemCount: towers.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: Sizes.towerTileHeight,
                  child: ListTile(
                    title: Text('Tower: ${towers[index].name}'),
                    trailing: Icon(Icons.navigate_next),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TowerInformationPage(tower: towers[index], towerId: towerIds[index]),
                        ),
                      );
                    },
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
