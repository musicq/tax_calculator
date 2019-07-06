import 'package:flutter/material.dart';
import 'package:tax_calculator/src/styles/theme.dart';

class CardPiece extends StatelessWidget {
  final String img;
  final String title;
  final String subTitle;
  final Function onTap;

  CardPiece({
    this.img,
    this.title,
    this.subTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Container(
          constraints: BoxConstraints.expand(width: 150, height: 180),
          padding: const EdgeInsets.all(26),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    img,
                    height: 45,
                    width: 45,
                    fit: BoxFit.fill,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 28, color: Colors.black),
                ),
                Text(
                  subTitle,
                  style: Style.tipText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
