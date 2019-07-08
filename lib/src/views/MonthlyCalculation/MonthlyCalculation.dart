import 'package:flutter/material.dart';
import 'package:tax_calculator/src/bizViews/IncomeOverview/IncomeOverview.dart';
import 'package:tax_calculator/src/widgets/ChipButton/ChipButton.dart';
import 'package:tax_calculator/src/widgets/InputField/InputField.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

import 'MonthlyCalculation.style.dart' as MonthlyCalculationStyle;

class MonthlyCalculation extends StatefulWidget {
  @override
  _MonthlyCalculationState createState() => _MonthlyCalculationState();
}

class _MonthlyCalculationState extends State<MonthlyCalculation> {
  PageController controller = PageController(initialPage: 0);

  Widget itemWrap({Widget child}) {
    return Container(
      padding: MonthlyCalculationStyle.itemPadding,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      body: PageView(
        controller: controller,
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              padding: MonthlyCalculationStyle.container,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: ChipButton(
                          text: '更多',
                          onTap: () {
                            controller.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ),
                      itemWrap(
                        child: InputField(
                          label: '输入税前薪资收入',
                        ),
                      ),
                    ],
                  ),
                  // 收入概览
                  IncomeOverview(income: 1000),
                ],
              ),
            ),
          ),
          Text('Placeholder'),
        ],
      ),
    );
  }
}
