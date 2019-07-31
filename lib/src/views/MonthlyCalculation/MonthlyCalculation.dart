import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
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

  MonthlyCalculation({this.initMoney});

  @override
  _MonthlyCalculationState createState() => _MonthlyCalculationState();
}

class _MonthlyCalculationState extends State<MonthlyCalculation> {
  final income = Income();
  final specialItemsAmount = SpecialItemsAmount();
  final _sub = CompositeSubscription();

  PageController pageCtrl = PageController(initialPage: 0, keepPage: false);
  TextEditingController inputCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.initMoney != null) {
      income.setVal(widget.initMoney);
      // give the default money
      inputCtrl.text = toMoney(widget.initMoney);
    } else {
      _sub.add(income.val$.take(1).listen((v) => inputCtrl.text = toMoney(v)));
    }
  }

  @override
  void dispose() {
    _sub.dispose();
    super.dispose();
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

  _gotoSpecialAttachmentPage() {
    Navigator.of(context).pushNamed('/special-attachment');
  }

  Widget specialBar(BuildContext context) {
    return Container(
      padding: MonthlyCalculationStyle.itemPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text('专项附加扣除', style: GlobalStyle.tipText),
          GestureDetector(
            onTap: _gotoSpecialAttachmentPage,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: StreamBuilder<Decimal>(
                    stream: specialItemsAmount.val$,
                    builder: (context, snapshot) {
                      return Text(
                        toMoney(snapshot.data ?? D('0')),
                        style: MonthlyCalculationStyle.moreText,
                      );
                    },
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
          ListView(
            padding: MonthlyCalculationStyle.container,
            children: [
              Stack(
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
              )
            ],
          ),
          MoreOptions(
            pageController: pageCtrl,
          ),
        ],
      ),
    );
  }
}
