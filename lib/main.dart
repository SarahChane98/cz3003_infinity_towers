import 'package:cz3003_infinity_towers/screens/Home_Screen.dart';
import 'package:cz3003_infinity_towers/screens/Login_Screen.dart';
import 'package:cz3003_infinity_towers/screens/add_tower.dart';
import 'package:cz3003_infinity_towers/screens/edit_tower_details.dart';
import 'package:cz3003_infinity_towers/screens/manage_towers.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cz3003_infinity_towers/screens/view_checkpoint.dart';
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:HomeScreen(),
    );
  }
}