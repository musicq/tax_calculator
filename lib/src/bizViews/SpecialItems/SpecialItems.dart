import 'package:flutter/material.dart';
import 'package:tax_calculator/src/shared/decimal.dart';
import 'package:tax_calculator/src/store/store.dart';
import 'package:tax_calculator/src/widgets/CardPiece/CardPiece.dart';

enum _Items {
  Child,
  Parent,
  Department,
  Rent,
  Education,
}

class _CardItem {
  final String img;
  final String title;
  final int price;
  final _Items key;

  const _CardItem({this.img, this.title, this.price, this.key});
}

const _list = [
  _CardItem(
    img: 'assets/zinv.png',
    title: '子女教育',
    price: 1000,
    key: _Items.Child,
  ),
  _CardItem(
    img: 'assets/laoren.png',
    title: '赡养老人',
    price: 2000,
    key: _Items.Parent,
  ),
  _CardItem(
    img: 'assets/zhufang.png',
    title: '首套住房',
    price: 1000,
    key: _Items.Department,
  ),
  _CardItem(
    img: 'assets/zufang.png',
    title: '租房住房',
    price: 1500,
    key: _Items.Rent,
  ),
  _CardItem(
    img: 'assets/jiaoyu.png',
    title: '继续教育',
    price: 400,
    key: _Items.Education,
  ),
];

class SpecialItems extends StatefulWidget {
  @override
  _SpecialItemsState createState() => _SpecialItemsState();
}

class _SpecialItemsState extends State<SpecialItems> {
  final _specialItemsState = SpecialItemsAmount();

  Set<_Items> _selected = {};

  _onTap(int amount, _Items type) {
    setState(() {
      if (_selected.contains(type)) {
        _selected.remove(type);
        _specialItemsState.minus(D(amount.toString()));
      } else {
        _selected.add(type);
        _specialItemsState.add(D(amount.toString()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: _list
          .map((item) => CardPiece(
                img: item.img,
                title: item.title,
                subTitle: '${item.price}元/月',
                smallSize: true,
                onTap: () => _onTap(item.price, item.key),
                selected: _selected.contains(item.key),
              ))
          .toList(),
    );
  }
}
