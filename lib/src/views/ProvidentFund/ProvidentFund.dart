import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:tax_calculator/src/shared/decimal.dart';
import 'package:tax_calculator/src/store/store.dart' as Store;
import 'package:tax_calculator/src/widgets/InputField/InputField.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

import 'ProvidentFund.style.dart' as ProvidentFundStyle;

class _Action {
  final String label;
  final Store.ProvidentType type;

  const _Action({this.label, this.type});
}

const _actions = [
  _Action(
    label: '最高',
    type: Store.ProvidentType.Highest,
  ),
  _Action(
    label: '最低',
    type: Store.ProvidentType.Lowest,
  ),
  _Action(
    label: '不缴纳',
    type: Store.ProvidentType.No,
  ),
  _Action(
    label: '自定义',
    type: Store.ProvidentType.Customize,
  ),
];

class ProvidentFund extends StatefulWidget {
  @override
  _ProvidentFundState createState() => _ProvidentFundState();
}

class _ProvidentFundState extends State<ProvidentFund> {
  final _inputCtrl = TextEditingController();
  final _providentFund = Store.ProvidentFund();

  Store.ProvidentType _selectedType = Store.ProvidentType.Highest;

  @override
  void initState() {
    super.initState();

    _providentFund.basis$.listen((v) => _inputCtrl.text = toMoney(v));
    _providentFund.type$.listen((type) {
      setState(() {
        _selectedType = type;
      });
    });
  }

  List<Widget> _chipsFactory() {
    return _actions
        .map((action) => Container(
              padding: EdgeInsets.only(right: 10),
              child: ChoiceChip(
                shadowColor: Colors.black,
                key: ValueKey(action.type),
                label: Text(action.label,
                    style: ProvidentFundStyle.labelStyle(
                        _selectedType == action.type)),
                backgroundColor: Colors.white,
                selectedColor: Colors.blueAccent,
                selected: _selectedType == action.type,
                onSelected: (bool v) => _providentFund.setType(action.type),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text('公积金缴纳', style: ProvidentFundStyle.title),
            ),
            InputField(
              showTip: false,
              label: '输入公积金缴纳基数',
              controller: _inputCtrl,
              onSubmit: (String v) => _providentFund.setBasis(D(v)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: _chipsFactory(),
              ),
            ),
            StreamBuilder(
              stream: _providentFund.val$,
              builder: (BuildContext context, AsyncSnapshot<Decimal> snapshot) {
                if (snapshot.hasData) {
                  return Text(toMoney(snapshot.data));
                }
                return Text('空的');
              },
            )
          ],
        ),
      ),
    );
  }
}
