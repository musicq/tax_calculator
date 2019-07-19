import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:tax_calculator/src/bizViews/IncomeOverview/IncomeOverview.dart';
import 'package:tax_calculator/src/shared/decimal.dart';
import 'package:tax_calculator/src/store/store.dart';
import 'package:tax_calculator/src/styles/theme.dart';
import 'package:tax_calculator/src/widgets/ChipButton/ChipButton.dart';
import 'package:tax_calculator/src/widgets/InputField/InputField.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

import 'MonthlyCalculation.style.dart' as MonthlyCalculationStyle;
import 'MoreOptions.dart';

final defaultMoney = D('3000');

class MonthlyCalculation extends StatefulWidget {
  final Decimal initMoney;

  MonthlyCalculation({initMoney}) : initMoney = initMoney ?? defaultMoney;

  @override
  _MonthlyCalculationState createState() => _MonthlyCalculationState();
}

class _MonthlyCalculationState extends State<MonthlyCalculation> {
  final income = Income();

  PageController pageCtrl = PageController(initialPage: 0, keepPage: false);
  TextEditingController inputCtrl = TextEditingController();
  double excludeMoney = 4500;

  @override
  void initState() {
    super.initState();

    income.setVal(widget.initMoney);
    // give the default money
    inputCtrl.text = toMoney(widget.initMoney);
  }

  _onSwitchPage() {
    pageCtrl.nextPage(
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  _onPageChange(int pageNum) {
    // 让输入框失去焦点
    FocusScope.of(context).requestFocus(FocusNode());

    // 回到第一页时刷新数据
    if (pageNum == 0) {
      income.setVal(D(inputCtrl.text));
    }
  }

  _onIncomeChange(String v) {
    income.setVal(D(v));
  }

  Widget specialBar(BuildContext context) {
    return Container(
      padding: MonthlyCalculationStyle.itemPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('专项附加扣除', style: GlobalStyle.tipText),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/special-attachment');
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      body: PageView(
        controller: pageCtrl,
        onPageChanged: _onPageChange,
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
                      onTap: _onSwitchPage,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      // 税前薪资框
                      Container(
                        padding: MonthlyCalculationStyle.itemPadding,
                        child: InputField(
                          showTip: false,
                          label: '输入税前薪资收入',
                          controller: inputCtrl,
                          onChanged: _onIncomeChange,
                        ),
                      ),
                      // 专项附加扣除 bar
                      specialBar(context),
                      // 收入概览
                      IncomeOverview(income$: income.val$),
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
