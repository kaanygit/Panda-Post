import 'package:flutter/material.dart';

class PandaHungryScreen extends StatelessWidget {
  const PandaHungryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Panda Hungry'),
        leading: Container(
          color: Colors.white70,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_rounded),
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text('Panda Hungry Page'),
            ],
          ),
        ),
      ),
    );
  }
}
