import 'package:cz3003_infinity_towers/models/mock_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/constants/strings.dart';
import 'package:cz3003_infinity_towers/constants/sizes.dart';
import 'package:cz3003_infinity_towers/screens/checkpoint_error.dart';


class TowerInformationPage extends StatelessWidget {

  final Tower tower;

  TowerInformationPage({Key key, @required this.tower}): super(key: key);


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
            child: ListView.builder(
              padding: const EdgeInsets.all(Sizes.smallPadding),
              itemCount: tower.checkpoints.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: Sizes.checkpointTileHeight,
                  child: ListTile(
                    title: Text('Checkpoint ${index + 1}'),
                    trailing: tower.checkpoints[index].unlocked?
                    Text(tower.checkpoints[index].name)
                        : Icon(Icons.lock),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckpointErrorPage(),
                        ),
                      );
                    },
                  ),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}
