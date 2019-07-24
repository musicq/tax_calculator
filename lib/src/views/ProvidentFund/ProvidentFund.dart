import 'package:flutter/material.dart';
import 'package:tax_calculator/src/widgets/InputField/InputField.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

import 'ProvidentFund.style.dart' as ProvidentFundStyle;

/// 缴纳类型
enum ActionType { Highest, Lowest, No, Customize }

class _Action {
  final String label;
  final ActionType type;

  const _Action({this.label, this.type});
}

const _actions = [
  _Action(
    label: '最高',
    type: ActionType.Highest,
  ),
  _Action(
    label: '最低',
    type: ActionType.Lowest,
  ),
  _Action(
    label: '不缴纳',
    type: ActionType.No,
  ),
  _Action(
    label: '自定义',
    type: ActionType.Customize,
  ),
];

class ProvidentFund extends StatefulWidget {
  @override
  _ProvidentFundState createState() => _ProvidentFundState();
}

class _ProvidentFundState extends State<ProvidentFund> {
  final inputCtrl = TextEditingController();

  ActionType _selectedType = ActionType.Highest;

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
                onSelected: (bool v) {
                  setState(() {
                    _selectedType = action.type;
                  });
                },
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
              controller: inputCtrl,
              onChanged: (String v) => print(v),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: _chipsFactory(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
