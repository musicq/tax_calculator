import 'package:flutter/material.dart';
import 'package:tax_calculator/src/styles/theme.dart';
import 'package:tax_calculator/src/widgets/CardPiece/CardPiece.dart';
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
            color: Style.backgroundColor,
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
                CardPiece(
                  img: 'assets/income.png',
                  title: '123.33',
                  subTitle: '7月份收入',
                  onTap: () {},
                )
              ],
            ),
          ),
          Text('Placeholder'),
        ],
      ),
    );
  }
}
