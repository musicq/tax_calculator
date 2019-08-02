import 'package:flutter/material.dart';
import 'package:tax_calculator/src/shared/documents.dart';

import 'AmountLabel.dart';
import 'style.dart' as Style;

class Dot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints.tight(Size(4, 4)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.yellowAccent,
        ),
      ),
    );
  }
}

class IncomeSummaryPanel extends StatelessWidget {
  final String incomeAfterTax;
  final String tax;

  IncomeSummaryPanel({this.incomeAfterTax = '0.00', this.tax = '0.00'});

  Widget panel({Widget child}) {
    return Opacity(
      opacity: 0.95,
      child: Container(
        constraints: BoxConstraints.expand(height: 260),
        decoration: Style.boxStyle,
        child: child,
      ),
    );
  }

  void _onTapQuestionIcon(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(kIncomeQueryDoc, style: Style.alertText),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return panel(
      child: Padding(
        padding: EdgeInsets.only(top: 80, left: 20, right: 20),
        child: DefaultTextStyle(
          style: TextStyle(color: Colors.white),
          child: Column(
            children: <Widget>[
              AmountLabel(
                alignLeft: true,
                amount: Row(
                  children: <Widget>[
                    Text(
                      '收入查询',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onTapQuestionIcon(context),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/question.png',
                          width: 24,
                          height: 24,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
                label: Text('2019 年预估收入'),
              ),
              Container(
                padding: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: AmountLabel(
                        amount: Text(incomeAfterTax),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[Dot(), Text('预估税后收入')],
                        ),
                      ),
                    ),
                    Opacity(
                      opacity: 0.2,
                      child: Container(
                        constraints: BoxConstraints.tight(Size(1, 30)),
                        color: Colors.white,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: AmountLabel(
                        amount: Text(tax),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Dot(),
                            Text('预估缴纳个税'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
