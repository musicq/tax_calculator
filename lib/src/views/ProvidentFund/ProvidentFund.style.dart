import 'package:flutter/material.dart';
import 'package:tax_calculator/src/styles/theme.dart';

const title = TextStyle(fontSize: 28);

final labelStyle = (bool active) =>
    TextStyle(color: active ? Colors.white : GlobalStyle.textSecondary);

final box = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  color: Colors.white,
  boxShadow: [BoxShadow(color: Colors.grey[100], spreadRadius: 2)],
);
