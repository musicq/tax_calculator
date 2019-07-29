import 'package:flutter/material.dart';

import 'SelectButtonGroup.style.dart' as SelectButtonGroupStyle;

class SelectButtonGroupItem<T> {
  final String label;
  final T type;

  const SelectButtonGroupItem({this.label, this.type});
}

typedef OnSelected<T> = void Function(T type);

class SelectButtonGroup<T> extends StatelessWidget {
  final List<SelectButtonGroupItem<T>> actions;
  final T selectedType;
  final OnSelected<T> onSelected;

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
