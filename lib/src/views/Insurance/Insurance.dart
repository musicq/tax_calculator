import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';
import 'package:tax_calculator/src/store/store.dart' as Store;
import 'package:tax_calculator/src/widgets/CTable/CTable.dart';
import 'package:tax_calculator/src/widgets/InputField/InputField.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';
import 'package:tax_calculator/src/widgets/SelectButtonGroup/SelectButtonGroup.dart';

import 'Insurance.style.dart' as InsuranceStyle;

const _actions = [
  SelectButtonGroupItem(
    label: '最高',
    type: Store.InsuranceType.Highest,
  ),
  SelectButtonGroupItem(
    label: '最低',
    type: Store.InsuranceType.Lowest,
  ),
  SelectButtonGroupItem(
    label: '不缴纳',
    type: Store.InsuranceType.No,
  ),
  SelectButtonGroupItem(
    label: '自定义',
    type: Store.InsuranceType.Customize,
  ),
];

class Insurance extends StatefulWidget {
  @override
  _InsuranceState createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {
  final _inputCtrl = TextEditingController();
  final _insurance = Store.Insurance();
  final _sub = CompositeSubscription();

  static const List<String> titles = ['项目', '缴纳基数', '缴纳比例', '个人缴纳'];

  Store.InsuranceType _selectedType = Store.InsuranceType.Highest;

  @override
  void initState() {
    super.initState();

    _sub.add(_insurance.basis$.listen((v) => _inputCtrl.text = toMoney(v)));
    _sub.add(_insurance.type$
        .listen((type) => setState(() => _selectedType = type)));
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
              child: Text('社保缴纳', style: InsuranceStyle.title),
            ),
            InputField(
              showTip: false,
              label: '输入社保缴纳基数',
              controller: _inputCtrl,
              decimal: false,
              onSubmit: (String v) => _insurance.setBasis(D(v)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SelectButtonGroup<Store.InsuranceType>(
                actions: _actions,
                selectedType: _selectedType,
                onSelected: (t) => _insurance.setType(t),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15),
              child: CTable(
                titles: titles,
                rows: [
                  ['1', '2', '3', '4'],
                  ['4', '5', '6', '7'],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
