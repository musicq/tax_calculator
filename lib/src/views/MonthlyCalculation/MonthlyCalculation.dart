import 'package:flutter/material.dart';
import 'package:tax_calculator/src/bizViews/IncomeOverview/IncomeOverview.dart';
import 'package:tax_calculator/src/styles/theme.dart';
import 'package:tax_calculator/src/widgets/ChipButton/ChipButton.dart';
import 'package:tax_calculator/src/widgets/InputField/InputField.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

import 'MonthlyCalculation.style.dart' as MonthlyCalculationStyle;
import 'MoreOptions.dart';

class MonthlyCalculation extends StatefulWidget {
  @override
  _MonthlyCalculationState createState() => _MonthlyCalculationState();
}

class _MonthlyCalculationState extends State<MonthlyCalculation> {
  PageController pageCtrl = PageController(initialPage: 0);
  TextEditingController inputCtrl = TextEditingController();
  double excludeMoney = 4500;

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      body: PageView(
        controller: pageCtrl,
        onPageChanged: (index) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              padding: MonthlyCalculationStyle.container,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: ChipButton(
                      text: '更多',
                      onTap: () {
                        pageCtrl.nextPage(
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
                          showTip: false,
                          label: '输入税前薪资收入',
                          controller: inputCtrl,
                          onChanged: (String v) {
                            print(v);
                          },
                        ),
                      ),
                      Container(
                        padding: MonthlyCalculationStyle.itemPadding,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('专项附加扣除', style: GlobalStyle.tipText),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed('/special-attachment');
                              },
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 5),
                                    child: Text(
                                      excludeMoney.toString(),
                                      style: MonthlyCalculationStyle.moreText,
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/circle-right.png',
                                    width: 18,
                                    height: 18,
                                    fit: BoxFit.contain,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 收入概览
                      IncomeOverview(income: 1000),
                    ],
                  )
                ],
              ),
            ),
          ),
          MoreOptions(
            pageController: pageCtrl,
          ),
        ],
      ),
    );
  }
}
