import 'package:flutter/material.dart';
import 'package:tax_calculator/src/store/store.dart' as Store;
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
  final _selectedType = Store.InsuranceType.Lowest;

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
              //              onSubmit: (String v) => _providentFund.setBasis(D(v)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SelectButtonGroup<Store.InsuranceType>(
                actions: _actions,
                selectedType: _selectedType,
                onSelected: (t) => print(t),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
