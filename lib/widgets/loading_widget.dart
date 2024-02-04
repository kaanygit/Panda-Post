import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatefulWidget {
  final int loopAddition;
  final double cardLoadingHeight;

  const LoadingWidget(this.loopAddition, this.cardLoadingHeight, {Key? key})
      : super(key: key);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          for (int i = 0; i < widget.loopAddition; i++)
            CardLoading(
              height: widget.cardLoadingHeight,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              margin: EdgeInsets.all(10),
            ),
        ],
      ),
    );
  }
}
