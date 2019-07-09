import 'package:flutter/material.dart';
import 'package:tax_calculator/src/styles/theme.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

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
              Center(
                child: Column(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                        text: excludeMoney.toString(),
                        style: TextStyle(fontSize: 28, color: Colors.black),
                        children: [
                          TextSpan(
                            text: '/月',
                            style: TextStyle(
                              fontSize: 16,
                              color: GlobalStyle.textSecondary,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text('税前扣除金额', style: GlobalStyle.tipText),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
