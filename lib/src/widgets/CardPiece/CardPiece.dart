import 'package:flutter/material.dart';
import 'package:tax_calculator/src/styles/theme.dart';

import 'CardPiece.style.dart' as CardPieceStyle;

class CardPiece extends StatelessWidget {
  final String img;
  final String title;
  final String subTitle;
  final Function onTap;
  final bool smallSize;

  CardPiece({
    this.img,
    this.title,
    this.subTitle,
    this.onTap,
    this.smallSize = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: CardPieceStyle.borderRadius,
      child: Ink(
        decoration: CardPieceStyle.inkBoxDecoration,
        child: Container(
          constraints:
              smallSize ? CardPieceStyle.boxSmallSize : CardPieceStyle.boxSize,
          padding: smallSize
              ? CardPieceStyle.boxSmallPadding
              : CardPieceStyle.boxPadding,
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: CardPieceStyle.imgPadding,
                  child: Image.asset(
                    img,
                    width: 45,
                    height: 45,
                    fit: BoxFit.contain,
                  ),
                ),
                Text(title,
                    style: smallSize
                        ? CardPieceStyle.smallTitle
                        : CardPieceStyle.title),
                Text(subTitle, style: GlobalStyle.tipText),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
