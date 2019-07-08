import 'package:flutter/material.dart';
import 'package:tax_calculator/src/bizViews/IncomeOverview/IncomeOverview.dart';
import 'package:tax_calculator/src/widgets/ChipButton/ChipButton.dart';
import 'package:tax_calculator/src/widgets/InputField/InputField.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

class MonthlyCalculation extends StatefulWidget {
  @override
  _MonthlyCalculationState createState() => _MonthlyCalculationState();
}

class _MonthlyCalculationState extends State<MonthlyCalculation> {
  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      body: PageView(
        controller: controller,
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                ChipButton(
                  text: '更多',
                  onTap: () {
                    controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear,
                    );
                  },
                ),
                InputField(
                  label: '输入税前薪资收入',
                ),
                IncomeOverview(income: 1000),
              ],
            ),
          ),
          Text('Placeholder'),
        ],
      ),
    );
  }
}
