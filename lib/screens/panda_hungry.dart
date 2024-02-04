import 'package:flutter/material.dart';

class PandaHungryScreen extends StatelessWidget {
  const PandaHungryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panda Hungry'),
      ),
      body: Container(
        child: Column(
          children: [
            Text('Pnda hugryyy'),
            Text('31'),
          ],
        ),
      ),
    );
  }
}
