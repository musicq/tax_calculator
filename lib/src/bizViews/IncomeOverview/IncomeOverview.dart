import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/dateTime.dart';
import 'package:tax_calculator/src/shared/decimal.dart';
import 'package:tax_calculator/src/store/store.dart';
import 'package:tax_calculator/src/widgets/CardPiece/CardPiece.dart';

class IncomeOverview extends StatefulWidget {
  final BehaviorSubject<Decimal> income$;

  IncomeOverview({this.income$});

  @override
  _IncomeOverviewState createState() => _IncomeOverviewState();
}

class _IncomeOverviewState extends State<IncomeOverview> {
  final CompositeSubscription _sub = CompositeSubscription();
  Decimal incomeAfterTax = D('0');
  Decimal tax = D('0');
  Decimal providentFund = D('0');
  Decimal insurance = D('0');

  String month = '${translateMonth(DateTime.now().month)}';

  @override
  void initState() {
    super.initState();

    // 公积金
    _sub.add(providentFund$.listen((v) => setState(() => providentFund = v)));
    // 社保
    _sub.add(insurance$.listen((v) => setState(() => insurance = v)));
    // 税后工资
    _sub.add(incomeAfterTax$.listen((v) => setState(() => incomeAfterTax = v)));
    // 个税
    _sub.add(tax$.listen((v) => setState(() => tax = v)));
  }

  @override
  void dispose() {
    super.dispose();

    _sub.dispose();
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
