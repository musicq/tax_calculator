import 'package:flutter/material.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

class ProvidentFund extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainContainer(
      body: Column(
        children: <Widget>[
          Text(
            '公积金缴纳',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
