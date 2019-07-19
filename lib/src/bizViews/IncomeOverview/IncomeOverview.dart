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
  final income = Income();
  final providentFund = ProvidentFund();
  final insurance = Insurance();

  final CompositeSubscription _sub = CompositeSubscription();
  Decimal _incomeAfterTax = D('0');
  Decimal tax = D('0');
  Decimal _providentFund = D('0');
  Decimal _insurance = D('0');

  String month = '${translateMonth(DateTime.now().month)}';

  @override
  void initState() {
    super.initState();

    // 公积金
    _sub.add(
        providentFund.val$.listen((v) => setState(() => _providentFund = v)));
    // 社保
    _sub.add(insurance.val$.listen((v) => setState(() => _insurance = v)));
    // 税后工资
    _sub.add(income.incomeAfterTax$
        .listen((v) => setState(() => _incomeAfterTax = v)));
    // 个税
    _sub.add(income.tax$.listen((v) => setState(() => tax = v)));
  }

  @override
  void dispose() {
    _sub.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: <Widget>[
        CardPiece(
          img: 'assets/income.png',
          title: toMoney(_incomeAfterTax),
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
          title: toMoney(_providentFund),
          subTitle: '$month公积金缴纳',
          onTap: () {},
        ),
        CardPiece(
          img: 'assets/insurance.png',
          title: toMoney(_insurance),
          subTitle: '$month社保缴纳',
          onTap: () {},
        ),
      ],
    );
  }
}
