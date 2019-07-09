import 'package:flutter/material.dart';
import 'package:tax_calculator/src/shared/documents.dart';
import 'package:tax_calculator/src/widgets/ChipButton/ChipButton.dart';
import 'package:tax_calculator/src/widgets/InputField/InputField.dart';

import 'MonthlyCalculation.style.dart' as MonthlyCalculationStyle;

class SpecialAttachment extends StatelessWidget {
  final PageController pageController;

  SpecialAttachment({this.pageController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: MonthlyCalculationStyle.container,
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: ChipButton(
                text: '返回',
                onTap: () {
                  pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: MonthlyCalculationStyle.itemPadding,
                  child: InputField(
                    label: '输入劳务报酬',
                    tipMsg: kServiceRemuneration,
                  ),
                ),
                Container(
                  padding: MonthlyCalculationStyle.itemPadding,
                  child: InputField(
                    label: '输入稿酬',
                    tipMsg: kManuscriptRemuneration,
                  ),
                ),
                Container(
                  padding: MonthlyCalculationStyle.itemPadding,
                  child: InputField(
                    label: '输入特许权使用费所得',
                    tipMsg: kRoyalties,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
