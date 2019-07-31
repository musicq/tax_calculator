import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:tax_calculator/src/bizViews/SpecialItems/SpecialItems.dart';
import 'package:tax_calculator/src/shared/decimal.dart';
import 'package:tax_calculator/src/store/store.dart';
import 'package:tax_calculator/src/styles/theme.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

import 'SpecialAttachment.style.dart' as SpecialAttachmentStyle;

class SpecialAttachment extends StatelessWidget {
  final _specialItemsState = SpecialItemsAmount();

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: <Widget>[
                  StreamBuilder<Decimal>(
                    stream: _specialItemsState.val$,
                    builder: (context, snapshot) {
                      return RichText(
                        text: TextSpan(
                          text: toMoney(snapshot.data ?? D('0')),
                          style: SpecialAttachmentStyle.totalMoney,
                          children: [
                            TextSpan(text: '/月', style: GlobalStyle.tipText)
                          ],
                        ),
                      );
                    },
                  ),
                  Text('税前扣除金额', style: GlobalStyle.tipText),
                ],
              ),
            ),
          ),
          Center(child: SpecialItems())
        ],
      ),
    );
  }
}
