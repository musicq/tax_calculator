import 'package:flutter/material.dart';
import 'package:tax_calculator/src/views/MainLayout/MainLayout.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '报税通',
      home: MainLayout(),
    );
  }
}
