import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/screens/appbar.dart';
import 'package:cz3003_infinity_towers/screens/Home_Screen.dart';
import 'package:cz3003_infinity_towers/screens/view_tower_information.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cz3003_infinity_towers/models/tower.dart';
import 'package:cz3003_infinity_towers/models/tower_participation.dart';
import 'package:cz3003_infinity_towers/constants/sizes.dart';
import 'package:cz3003_infinity_towers/screens/edit_tower_details.dart';
import 'package:cz3003_infinity_towers/screens/add_new_tower.dart';
import 'package:cz3003_infinity_towers/screens/Main_Teacher.dart';
class ManageTowers extends StatefulWidget {
  @override
  _ManageTowersState createState() => _ManageTowersState();
}

class _ManageTowersState extends State<ManageTowers> {
  var appBarText = 'Manage Towers';
  var appBarStyle = const TextStyle(fontFamily: 'Fredoka', fontSize: 32);

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

  Future<List<Tower>> getOwnedTowers() async {
    final towerRef =
        FirebaseFirestore.instance.collection('towers').withConverter<Tower>(
              fromFirestore: (snapshot, _) => Tower.fromJson(snapshot.data()),
              toFirestore: (tower, _) => tower.toJson(),
            );

    List<Tower> towers = [];
    List<String> towerIDs = [];
    await towerRef
        .where('ownerId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((snapshot) => snapshot.docs)
        .then((results) {
      for (var t in results) {
        towerIDs.add(t.id);
        towers.add(t.data());
      }
    });
    return towers;
  }

  Future<List<String>> getOwnedTowersIDs() async {
    final towerRef =
    FirebaseFirestore.instance.collection('towers').withConverter<Tower>(
      fromFirestore: (snapshot, _) => Tower.fromJson(snapshot.data()),
      toFirestore: (tower, _) => tower.toJson(),
    );

    List<String> towerIDs = [];
    await towerRef
        .where('ownerId', isEqualTo: FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((snapshot) => snapshot.docs)
        .then((results) {
      for (var t in results) {
        towerIDs.add(t.id);

      }
    });
    return towerIDs;
  }

  @override
  Widget build(BuildContext context) {
    return (MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Manage Towers',
              textAlign: TextAlign.center,
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black,size: 30,),
              onPressed: () => //Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          EntTScreen('')
                  ))
            ),
          ),
      body: FutureBuilder(
        future: Future.wait([getOwnedTowers(), getOwnedTowersIDs()]),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (!snapshot.hasData) {
            return Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            List<Tower> towers = snapshot.data[0];
            List<String> towerIDs = snapshot.data[1];
            if (towers.length != 0) {
              return ( //ListView(children: [
                      ListView.builder(
                          padding: const EdgeInsets.all(Sizes.smallPadding),
                          itemCount: towers.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == towers.length) {
                              return (Center(
                                  child: ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.add_box_rounded,
                                        color: Colors.black,
                                      ),
                                      label: Text("Add New Tower!"),
                                      style: raisedButtonStyle,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddNewTower()
                                            ));
                                      }
                                  )
                              )
                              );
                            } else {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                color: Colors.lightBlue,
                                elevation: 10,
                                child: new InkWell(
                                  onTap: () {
                                    print("This is the towerID");
                                    print(towerIDs[index]);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                        builder: (context) => EditTowerDetails(tower: towers[index], towerID: towerIDs[index]))
                                        );
                                  },
                                  //splashColor: Colors.lightBlueAccent,
                                  child: Column(children: <Widget>[
                                    ListTile(
                                      leading: new IconButton(
                                        icon: new Icon(Icons.share,
                                            color: Colors.black),
                                        onPressed: () {
                                          print("Copy Tower Access Details");
                                          // NEED TO CODE THE LOGIC
                                        },
                                      ),
                                      title: Text('${towers[index].name}',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      subtitle:
                                          Text("\nDate of Creation: " + '27/03/21'),
                                      isThreeLine: true,

                                      // trailing: new IconButton(
                                      //   icon: new Icon(Icons.delete, color: Colors.black),
                                      //   onPressed: () {
                                      //     print("DELETE");
                                      //   },
                                      // ),
                                    ),
                                  ]),
                                ),
                              );
                            }
                          })
                  // Center(
                  //     child: ElevatedButton.icon(
                  //         icon: Icon(
                  //           Icons.add_box_rounded,
                  //           color: Colors.black,
                  //         ),
                  //         label: Text("Add New Tower!"),
                  //         style: raisedButtonStyle,
                  //         onPressed: () {}))
                  // ]
                  // )
                  );
            }
          }
          return (Text("Yes true"));
        },
      ),
    )));
  }
}
