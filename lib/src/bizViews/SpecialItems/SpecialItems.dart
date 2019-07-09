import 'package:flutter/material.dart';
import 'package:tax_calculator/src/widgets/CardPiece/CardPiece.dart';

class SpecialItems extends StatelessWidget {
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
          onTap: () {},
        ),
        CardPiece(
          img: 'assets/laoren.png',
          title: '赡养老人',
          subTitle: '2000元/月',
          smallSize: true,
          onTap: () {},
        ),
        CardPiece(
          img: 'assets/zhufang.png',
          title: '首套住房',
          subTitle: '1000元/月',
          smallSize: true,
          onTap: () {},
        ),
        CardPiece(
          img: 'assets/zufang.png',
          title: '租房住房',
          subTitle: '1500元/月',
          smallSize: true,
          onTap: () {},
        ),
        CardPiece(
          img: 'assets/jiaoyu.png',
          title: '继续教育',
          subTitle: '400元/月',
          smallSize: true,
          onTap: () {},
        ),
      ],
    );
  }
}
