import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';
import 'package:tax_calculator/src/store/store.dart' as Store;
import 'package:tax_calculator/src/widgets/InputField/InputField.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';
import 'package:tax_calculator/src/widgets/SelectButtonGroup/SelectButtonGroup.dart';

import 'ProvidentFund.style.dart' as ProvidentFundStyle;

const _actions = [
  SelectButtonGroupItem(
    label: '最高',
    type: Store.ProvidentType.Highest,
  ),
  SelectButtonGroupItem(
    label: '最低',
    type: Store.ProvidentType.Lowest,
  ),
  SelectButtonGroupItem(
    label: '不缴纳',
    type: Store.ProvidentType.No,
  ),
  SelectButtonGroupItem(
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
  final _sub = CompositeSubscription();

  Store.ProvidentType _selectedType = Store.ProvidentType.Highest;
  double _rate = 0;
  String _fundVal;

  @override
  void initState() {
    super.initState();

    _sub.add(_providentFund.val$
        .listen((v) => setState(() => _fundVal = toMoney(v))));
    _sub.add(_providentFund.type$
        .listen((type) => setState(() => _selectedType = type)));
    _sub.add(_providentFund.basis$.listen((v) => _inputCtrl.text = toMoney(v)));
    _sub.add(_providentFund.rate$
        .listen((v) => setState(() => _rate = (v * D('100')).toDouble())));
  }

  @override
  void dispose() {
    _sub.dispose();
    super.dispose();
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
              decimal: false,
              onSubmit: (String v) => _providentFund.setBasis(D(v)),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SelectButtonGroup<Store.ProvidentType>(
                  actions: _actions,
                  selectedType: _selectedType,
                  onSelected: (type) => _providentFund.setType(type),
                )),
            Container(
              padding: EdgeInsets.all(20),
              decoration: ProvidentFundStyle.box,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('个人缴纳比例'),
                      Text('$_fundVal'),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Slider(
                          value: _rate,
                          min: 0.0,
                          max: 12.0,
                          divisions: 12,
                          label: _rate.toString(),
                          onChanged: (double v) {
                            _providentFund.setRate(D(v.toString()));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        child: Text('$_rate%'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
