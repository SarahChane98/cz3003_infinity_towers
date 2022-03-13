import 'package:cz3003_infinity_towers/screens/Login_Screen.dart';
import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/constants/strings.dart';
import 'package:cz3003_infinity_towers/constants/sizes.dart';
import 'package:cz3003_infinity_towers/models/mock_data.dart';
import 'package:cz3003_infinity_towers/screens/tower_information.dart';


class TileMapPage extends StatelessWidget {

  final towers = [mockTower1, mockTower2];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.tileMapTitle, textAlign: TextAlign.center,),
        leading: IconButton(icon:Icon(Icons.power_settings_new,size:30), onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => LoginScreen(),
            ),
          );
        },),
      ),
      body: ListView.separated(
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
                      builder: (context) => TowerInformationPage(tower: towers[index]),
                  ),
                );
              },
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }
}
