import 'package:flutter/material.dart';
import 'package:tax_calculator/src/styles/theme.dart';

final labelStyle = (bool active) =>
    TextStyle(color: active ? Colors.white : GlobalStyle.textSecondary);
