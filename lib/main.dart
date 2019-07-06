import 'package:flutter/material.dart';

import 'src/views/MonthlyCalculation/MonthlyCalculation.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '报税通',
      home: MonthlyCalculation(),
    );
  }
}
