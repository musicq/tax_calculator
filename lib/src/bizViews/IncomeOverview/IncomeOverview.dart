import 'dart:async';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/dateTime.dart';
import 'package:tax_calculator/src/shared/decimal.dart';
import 'package:tax_calculator/src/widgets/CardPiece/CardPiece.dart';

class IncomeOverview extends StatefulWidget {
  final BehaviorSubject<Decimal> income$;

  IncomeOverview({this.income$});

  @override
  _IncomeOverviewState createState() => _IncomeOverviewState();
}

class _IncomeOverviewState extends State<IncomeOverview> {
  StreamSubscription<Decimal> incomeAfterTax$;
  StreamSubscription<Decimal> tax$;
  StreamSubscription<Decimal> providentFund$;
  StreamSubscription<Decimal> insurance$;

  Decimal incomeAfterTax = D('0');
  Decimal tax = D('0');
  Decimal providentFund = D('0');
  Decimal insurance = D('0');

  String month = '${translateMonth(DateTime.now().month)}';

  @override
  void initState() {
    super.initState();

    incomeAfterTax$ = widget.income$
        .map((income) => income * D('0.1'))
        .listen((r) => setState(() => incomeAfterTax = r));
  }

  @override
  void dispose() {
    super.dispose();

    incomeAfterTax$.cancel();
//    tax$.cancel();
//    providentFund$.cancel();
//    insurance$.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: <Widget>[
        CardPiece(
          img: 'assets/income.png',
          title: toMoney(incomeAfterTax),
          subTitle: '$month税后收入',
          onTap: () {},
        ),
        CardPiece(
          img: 'assets/tax.png',
          title: toMoney(tax),
          subTitle: '$month个税',
          onTap: () {},
        ),
        CardPiece(
          img: 'assets/housing.png',
          title: toMoney(providentFund),
          subTitle: '$month公积金缴纳',
          onTap: () {},
        ),
        CardPiece(
          img: 'assets/insurance.png',
          title: toMoney(insurance),
          subTitle: '$month社保缴纳',
          onTap: () {},
        ),
      ],
    );
  }
}
