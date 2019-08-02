import 'package:flutter/material.dart';

class AmountLabel extends StatelessWidget {
  final Widget amount;
  final Widget label;
  final bool alignLeft;

  AmountLabel({this.amount, this.label, this.alignLeft = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          alignLeft ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: <Widget>[
        DefaultTextStyle(
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          child: amount,
        ),
        Padding(padding: EdgeInsets.only(top: 8), child: label),
      ],
    );
  }
}
