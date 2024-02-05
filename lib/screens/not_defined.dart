import 'package:flutter/material.dart';
import 'package:pandapostdev/constants/fonts.dart';

class NotDefined extends StatefulWidget {
  final int notDefinedIndex;
  const NotDefined(this.notDefinedIndex, {Key? key}) : super(key: key);

  @override
  State<NotDefined> createState() => _NotDefinedState();
}

class _NotDefinedState extends State<NotDefined> {
  final List<String> scrollAxisRowList = [
    "Work",
    "Important",
    "Flag",
    "To do",
    "All Notes"
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Image.asset(
              'assets/images/panda_three.png',
              width: 300,
            ),
          ),
          Container(
            child: Text(
              "${scrollAxisRowList[widget.notDefinedIndex]} is not defined :(",
              textAlign: TextAlign.center,
              style: googleFonts(
                  50, Colors.lightGreen.shade900, FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }
}
