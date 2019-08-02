import 'package:flutter/material.dart';
import 'package:tax_calculator/src/styles/theme.dart';

class _AmountDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 5),
          child: Text(
            '税前收入',
            style: TextStyle(color: GlobalStyle.textSecondary, fontSize: 12),
          ),
        ),
        Text(
          '100000.00',
          style: TextStyle(color: Colors.black, fontSize: 22),
        )
      ],
    );
  }
}

class MonthCard extends StatelessWidget {
  final int month;

  MonthCard({this.month});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: 90),
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 80,
            child: Center(
              child: RichText(
                text: TextSpan(
                  text: month.toString(),
                  style: TextStyle(fontSize: 30, color: Colors.black),
                  children: [
                    TextSpan(text: '月', style: TextStyle(fontSize: 12))
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 1,
            height: 30,
            child: Container(
              decoration: BoxDecoration(
                border: Border(right: BorderSide(color: Colors.black12)),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 30),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: _AmountDisplay(),
                  ),
                  Expanded(
                    child: _AmountDisplay(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
