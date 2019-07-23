import 'package:flutter/material.dart';
import 'package:tax_calculator/src/shared/decimal.dart';
import 'package:tax_calculator/src/store/store.dart';
import 'package:tax_calculator/src/widgets/CardPiece/CardPiece.dart';

class SpecialItems extends StatefulWidget {
  @override
  _SpecialItemsState createState() => _SpecialItemsState();
}

class _SpecialItemsState extends State<SpecialItems> {
  final _specialItemsState = SpecialItemsAmount();

  _onTap(String amount) {
    _specialItemsState.add(D(amount));
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: <Widget>[
        CardPiece(
          img: 'assets/zinv.png',
          title: '子女教育',
          subTitle: '1000元/月',
          smallSize: true,
          onTap: () => _onTap('1000'),
        ),
        CardPiece(
          img: 'assets/laoren.png',
          title: '赡养老人',
          subTitle: '2000元/月',
          smallSize: true,
          onTap: () => _onTap('2000'),
        ),
        CardPiece(
          img: 'assets/zhufang.png',
          title: '首套住房',
          subTitle: '1000元/月',
          smallSize: true,
          onTap: () => _onTap('1000'),
        ),
        CardPiece(
          img: 'assets/zufang.png',
          title: '租房住房',
          subTitle: '1500元/月',
          smallSize: true,
          onTap: () => _onTap('1500'),
        ),
        CardPiece(
          img: 'assets/jiaoyu.png',
          title: '继续教育',
          subTitle: '400元/月',
          smallSize: true,
          onTap: () => _onTap('400'),
        ),
      ],
    );
  }
}
