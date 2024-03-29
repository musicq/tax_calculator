import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';
import 'package:tax_calculator/src/shared/documents.dart';
import 'package:tax_calculator/src/store/store.dart';
import 'package:tax_calculator/src/widgets/ChipButton/ChipButton.dart';
import 'package:tax_calculator/src/widgets/InputField/InputField.dart';

import 'MonthlyCalculation.style.dart' as MonthlyCalculationStyle;

class MoreOptions extends StatefulWidget {
  final PageController pageController;

  MoreOptions({this.pageController});

  @override
  _MoreOptionsState createState() => _MoreOptionsState();
}

class _MoreOptionsState extends State<MoreOptions> {
  final remuneration = Remunerations();
  final serviceCtrl = TextEditingController();
  final manuscriptCtrl = TextEditingController();
  final royaltiesCtrl = TextEditingController();

  final _sub = CompositeSubscription();

  _onChange(String v, void setterFn(Decimal v)) {
    setterFn(D(v));
  }

  @override
  void initState() {
    super.initState();

    // restore the money
    _sub.add(remuneration.service$
        .take(1)
        .listen((v) => serviceCtrl.text = toMoney(v)));
    _sub.add(remuneration.royalties$
        .take(1)
        .listen((v) => royaltiesCtrl.text = toMoney(v)));
    _sub.add(remuneration.manuscript$
        .take(1)
        .listen((v) => manuscriptCtrl.text = toMoney(v)));
  }

  @override
  void dispose() {
    _sub.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: MonthlyCalculationStyle.container,
      children: [
        Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: ChipButton(
                text: '返回',
                onTap: () {
                  widget.pageController.previousPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ),
            Column(
              children: <Widget>[
                Container(
                  padding: MonthlyCalculationStyle.itemPadding,
                  child: InputField(
                      label: '输入劳务报酬',
                      tipMsg: kServiceRemuneration,
                      controller: serviceCtrl,
                      onChanged: (String v) =>
                          _onChange(v, remuneration.setServiceRemuneration)),
                ),
                Container(
                  padding: MonthlyCalculationStyle.itemPadding,
                  child: InputField(
                      label: '输入稿酬',
                      tipMsg: kManuscriptRemuneration,
                      controller: manuscriptCtrl,
                      onChanged: (String v) =>
                          _onChange(v, remuneration.setManuscriptRemuneration)),
                ),
                Container(
                  padding: MonthlyCalculationStyle.itemPadding,
                  child: InputField(
                      label: '输入特许权使用费所得',
                      tipMsg: kRoyalties,
                      controller: royaltiesCtrl,
                      onChanged: (String v) =>
                          _onChange(v, remuneration.setRoyalties)),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
