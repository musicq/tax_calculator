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

class _MoreOptionsState extends State<MoreOptions>
    with AutomaticKeepAliveClientMixin {
  final serviceCtrl = TextEditingController();
  final manuscriptCtrl = TextEditingController();
  final royaltiesCtrl = TextEditingController();

  _onChange(String v, BehaviorSubject<Decimal> stream) {
    stream.add(D(v));
  }

  @override
  void initState() {
    super.initState();

    // restore the money
    serviceRemuneration$.take(1).listen((v) => serviceCtrl.text = toMoney(v));
    royalties$.take(1).listen((v) => royaltiesCtrl.text = toMoney(v));
    manuscriptRemuneration$
        .take(1)
        .listen((v) => manuscriptCtrl.text = toMoney(v));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: MonthlyCalculationStyle.container,
        child: Stack(
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
                          _onChange(v, serviceRemuneration$)),
                ),
                Container(
                  padding: MonthlyCalculationStyle.itemPadding,
                  child: InputField(
                      label: '输入稿酬',
                      tipMsg: kManuscriptRemuneration,
                      controller: manuscriptCtrl,
                      onChanged: (String v) =>
                          _onChange(v, manuscriptRemuneration$)),
                ),
                Container(
                  padding: MonthlyCalculationStyle.itemPadding,
                  child: InputField(
                      label: '输入特许权使用费所得',
                      tipMsg: kRoyalties,
                      controller: royaltiesCtrl,
                      onChanged: (String v) => _onChange(v, royalties$)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
