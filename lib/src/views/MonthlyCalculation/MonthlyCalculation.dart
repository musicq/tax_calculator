import 'package:flutter/material.dart';
import 'package:tax_calculator/src/styles/theme.dart';
import 'package:tax_calculator/src/widgets/InputField/InputField.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

class MonthlyCalculation extends StatefulWidget {
  @override
  _MonthlyCalculationState createState() => _MonthlyCalculationState();
}

class _MonthlyCalculationState extends State<MonthlyCalculation> {
  @override
  Widget build(BuildContext context) {
    return MainContainer(
      body: Container(
        color: Style.backgroundColor,
        child: Column(
          children: <Widget>[
            InputField(
              label: '输入税前薪资收入',
            ),
          ],
        ),
      ),
    );
  }
}
