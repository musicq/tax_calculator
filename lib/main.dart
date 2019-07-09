import 'package:flutter/material.dart';
import 'package:tax_calculator/src/views/Home/Home.dart';
import 'package:tax_calculator/src/views/SpecialAttachment/SpecialAttachment.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '报税通',
      home: Home(),
      routes: {
        // 专项附加扣除页面
        '/special-attachment': (BuildContext context) => SpecialAttachment(),
      },
    );
  }
}
