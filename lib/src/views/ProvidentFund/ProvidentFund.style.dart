import 'package:flutter/material.dart';
import 'package:tax_calculator/src/styles/theme.dart';

const title = TextStyle(fontSize: 28);

final labelStyle = (bool active) =>
    TextStyle(color: active ? Colors.white : GlobalStyle.textSecondary);
