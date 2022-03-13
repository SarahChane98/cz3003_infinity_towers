import 'package:flutter/material.dart';
import 'package:cz3003_infinity_towers/constants/strings.dart';

class CheckpointErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.errorMessageTitle),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red),
              Flexible(child: const Text(Strings.checkpointErrorMessage)),
            ],
          ),
        ),
    );
  }
}
