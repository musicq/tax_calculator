import 'package:flutter/material.dart';

import 'SelectButtonGroup.style.dart' as SelectButtonGroupStyle;

enum SelectButtonType { Highest, Lowest, No, Customize }

class SelectButtonGroupItem {
  final String label;
  final SelectButtonType type;

  const SelectButtonGroupItem({this.label, this.type});
}

typedef OnSelected = void Function(SelectButtonType type);

class SelectButtonGroup extends StatelessWidget {
  final List<SelectButtonGroupItem> actions;
  final SelectButtonType selectedType;
  final OnSelected onSelected;

  SelectButtonGroup({this.actions, this.selectedType, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: actions
          .map(
            (action) => Container(
              padding: EdgeInsets.only(right: 10),
              child: ChoiceChip(
                key: ValueKey(action.type),
                label: Text(
                  action.label,
                  style: SelectButtonGroupStyle.labelStyle(
                    selectedType == action.type,
                  ),
                ),
                shadowColor: Colors.black,
                backgroundColor: Colors.white,
                selectedColor: Colors.blueAccent,
                selected: selectedType == action.type,
                onSelected: (bool v) => onSelected(action.type),
              ),
            ),
          )
          .toList(),
    );
  }
}
