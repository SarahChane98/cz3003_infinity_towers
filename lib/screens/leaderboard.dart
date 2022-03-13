// /**
//  * This class implements the layout for the leaderboard of the application and displays the current points of all the user.
//  *
//  */
//
//
// import 'dart:core';
// import 'package:flutter/material.dart';
// import './appbar.dart';
//
// class LeaderboardPage extends StatefulWidget {
//   @override
//   _LeaderboardPageState createState() => _LeaderboardPageState();
// }
//
// class _LeaderboardPageState extends State<LeaderboardPage> {
//   List<List> sorting(AsyncSnapshot snapshot) {
//     List<List> namesAndPoints = [];
//     for (int i = 0; i < snapshot.data.documents.length; i++) {
//       vsr doc = snapshot.data.documents[i];
//       List temp = doc['points'];
//       namesAndPoints.add([doc['name'], temp[temp.length - 1]]);
//     }
//     namesAndPoints.sort((a, b) => b[1].compareTo(a[1]));
//     return namesAndPoints;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: ReusableWidgets.getAppBar(
//             "Leaderboard", Colors.white, Color(0xff1F3668)),
//         body: Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height * 0.90,
//           decoration: BoxDecoration(
//             image: new DecorationImage(
//               image: AssetImage("assets/images/space.jpg"),
//               fit: BoxFit.cover,
//               colorFilter: new ColorFilter.mode(
//                   Colors.black.withOpacity(0.9), BlendMode.dstATop),
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Column(children: <Widget>[
//               SizedBox(
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height * 0.08,
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(25.0),
//                   ),
//                   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                   elevation: 0,
//                   color: Color(0xff216869),
//                   child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisSize: MainAxisSize.min,
//                       children: <Widget>[
//                         ListTile(
//                           onTap: () {},
//                           leading: Text("Rank",
//                               style: TextStyle(
//                                   fontSize: 25,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.tealAccent[100])),
//                           contentPadding: EdgeInsets.fromLTRB(10, 0, 25, 0),
//                           title: Row(
//                             children: <Widget>[
//                               SizedBox(
//                                 width: 5,
//                               ),
//                               Text("Name",
//                                   style: TextStyle(
//                                       fontSize: 25,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.tealAccent[100])),
//                             ],
//                           ),
//                           trailing: SizedBox(
//                             width: MediaQuery.of(context).size.width * 0.20,
//                             child: Row(
//                               children: <Widget>[
//                                 Text('Point',
//                                     style: TextStyle(
//                                         fontSize: 25,
//                                         fontWeight: FontWeight.bold,
//                                         color: Colors.tealAccent[100]))
//                               ],
//                             ),
//                           ),
//                         ),
//                       ]),
//                 ),
//               ),
//               SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.90,
//                 height: MediaQuery.of(context).size.height * 0.80,
//                 child: StreamBuilder(
//                     stream:
//                     Firestore.instance.collection('Users').snapshots(),
//                     builder: (context, snapshot) {
//                       if (!snapshot.hasData) return const Text('Loading...');
//                       List<List> nameAndPoints = sorting(snapshot);
//                       return ListView.builder(
//                           physics: const AlwaysScrollableScrollPhysics(),
//                           itemCount: nameAndPoints.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               height: 85,
//                               child: Card(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(25.0),
//                                 ),
//                                 margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
//                                 elevation: 0,
//                                 color: Color(0xff49A5B7),
//                                 child: Column(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.center,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: <Widget>[
//                                       ListTile(
//                                         onTap: () {},
//                                         leading: Text((index + 1).toString(),
//                                             style: TextStyle(
//                                               fontSize: 40,
//                                               foreground: Paint()
//                                                 ..style = PaintingStyle.stroke
//                                                 ..strokeWidth = 2
//                                                 ..color = Colors.lightGreen[100],
//                                             )),
//                                         title: Padding(
//                                           padding: const EdgeInsets.fromLTRB(
//                                               5, 0, 0, 0),
//                                           child: Text(nameAndPoints[index][0],
//                                               style: TextStyle(
//                                                   fontSize: 22,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.white)),
//                                         ),
//                                         trailing: SizedBox(
//                                           width: MediaQuery.of(context)
//                                               .size
//                                               .width *
//                                               0.20,
//                                           child: Padding(
//                                             padding:
//                                             const EdgeInsets.fromLTRB(
//                                                 5, 0, 0, 0),
//                                             child: Row(
//                                               children: <Widget>[
//                                                 Text('Point: ',
//                                                     style: TextStyle(
//                                                         fontSize: 19,
//                                                         fontWeight:
//                                                         FontWeight.bold,
//                                                         fontStyle:
//                                                         FontStyle.italic,
//                                                         color:
//                                                         Colors.white70)),
//                                                 Text(
//                                                   nameAndPoints[index][1]
//                                                       .toString(),
//                                                   style: TextStyle(
//                                                       fontSize: 27,
//                                                       fontWeight:
//                                                       FontWeight.bold,
//                                                       fontStyle:
//                                                       FontStyle.italic,
//                                                       color: Colors.white),
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ]),
//                               ),
//                             );
//                           });
//                     }),
//               ),
//             ]),
//           ),
//         ));
//   }
// }
