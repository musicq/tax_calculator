import 'package:flutter/material.dart';
import 'package:tax_calculator/src/styles/theme.dart';

class CardPiece extends StatelessWidget {
  final String img;
  final String title;
  final String subTitle;

  CardPiece({
    this.img,
    this.title,
    this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
          boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
        ),
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
    );
  }
}
