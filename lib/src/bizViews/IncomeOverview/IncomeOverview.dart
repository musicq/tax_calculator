import 'package:flutter/material.dart';
import 'package:tax_calculator/src/shared/dateTime.dart';
import 'package:tax_calculator/src/widgets/CardPiece/CardPiece.dart';

class IncomeOverview extends StatefulWidget {
  final double income;

  IncomeOverview({this.income = 0});

  @override
  _IncomeOverviewState createState() => _IncomeOverviewState();
}

class _IncomeOverviewState extends State<IncomeOverview> {
  double incomeAfterTax = 922233333.98;
  double tax = 0;
  double providentFund = 0;
  double insurance = 0;

  String month = '${translateMonth(DateTime.now().month)}';

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: <Widget>[
        CardPiece(
          img: 'assets/income.png',
          title: incomeAfterTax.toString(),
          subTitle: '$month税后收入',
          onTap: () {},
        ),
        CardPiece(
          img: 'assets/tax.png',
          title: tax.toString(),
          subTitle: '$month个税',
          onTap: () {},
        ),
        CardPiece(
          img: 'assets/housing.png',
          title: providentFund.toString(),
          subTitle: '$month公积金缴纳',
          onTap: () {},
        ),
        CardPiece(
          img: 'assets/insurance.png',
          title: insurance.toString(),
          subTitle: '$month社保缴纳',
          onTap: () {},
        ),
      ],
    );
  }
}
