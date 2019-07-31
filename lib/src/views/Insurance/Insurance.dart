import 'package:decimal/decimal.dart';
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
  List<List<String>> rows = [];
  Decimal basis;

  Store.InsuranceType _selectedType = Store.InsuranceType.Highest;

  @override
  void initState() {
    super.initState();

    _sub.add(_insurance.basis$.listen((v) {
      basis = v;
      _inputCtrl.text = toMoney(v);
    }));
    _sub.add(_insurance.type$
        .listen((type) => setState(() => _selectedType = type)));

    final _pension$ = CombineLatestStream.list([
      _insurance.pensionRate$,
      _insurance.pensionVal$,
    ]).map((x) => [
          '养老保险',
          toMoney(basis),
          '${toMoney(x[0] * D('100'))}%',
          toMoney(x[1])
        ]);

    final _medical$ = CombineLatestStream.list([
      _insurance.medicalRate$,
      _insurance.medicalVal$,
    ]).map((x) => [
          '医疗保险',
          toMoney(basis),
          '${toMoney(x[0] * D('100'))}%',
          toMoney(x[1])
        ]);

    final _unEmploy$ = CombineLatestStream.list([
      _insurance.unEmployRate$,
      _insurance.unEmployVal$,
    ]).map((x) => [
          '失业保险',
          toMoney(basis),
          '${toMoney(x[0] * D('100'))}%',
          toMoney(x[1])
        ]);

    final _total$ = _insurance.val$.map((x) => ['合计', '', '', toMoney(x)]);

    _sub.add(CombineLatestStream.list([
      _pension$,
      _medical$,
      _unEmploy$,
      _total$,
    ]).listen((list) => setState(() => rows = [...list])));
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
                rows: rows,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
