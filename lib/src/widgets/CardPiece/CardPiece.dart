import 'package:flutter/material.dart';
import 'package:tax_calculator/src/styles/theme.dart';

import 'CardPiece.style.dart' as CardPieceStyle;

class CardPiece extends StatelessWidget {
  final String img;
  final String title;
  final String subTitle;
  final Function onTap;
  final bool smallSize;
  final bool selected;

  CardPiece({
    this.img,
    this.title,
    this.subTitle,
    this.onTap,
    this.smallSize = false,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: CardPieceStyle.borderRadius,
      child: Ink(
        decoration: CardPieceStyle.inkBoxDecoration(selected),
        child: Container(
          constraints: CardPieceStyle.boxSize(smallSize),
          padding: CardPieceStyle.boxPadding(smallSize),
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: CardPieceStyle.imgPadding,
                  child: Image.asset(
                    selected ? 'assets/active.png' : img,
                    width: 45,
                    height: 45,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(title, style: CardPieceStyle.title(smallSize)),
                Text(subTitle, style: GlobalStyle.tipText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
