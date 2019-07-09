import 'package:flutter/material.dart';
import 'package:tax_calculator/src/bizViews/SpecialItems/SpecialItems.dart';
import 'package:tax_calculator/src/styles/theme.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

import 'SpecialAttachment.style.dart' as SpecialAttachmentStyle;

class SpecialAttachment extends StatefulWidget {
  @override
  _SpecialAttachmentState createState() => _SpecialAttachmentState();
}

class _SpecialAttachmentState extends State<SpecialAttachment> {
  int excludeMoney = 1000;

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          text: excludeMoney.toString(),
                          style: SpecialAttachmentStyle.totalMoney,
                          children: [
                            TextSpan(text: '/月', style: GlobalStyle.tipText)
                          ],
                        ),
                      ),
                      Text('税前扣除金额', style: GlobalStyle.tipText),
                    ],
                  ),
                ),
              ),
              SpecialItems(),
            ],
          ),
        ),
      ),
    );
  }
}
