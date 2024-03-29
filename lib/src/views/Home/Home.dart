import 'package:flutter/material.dart';
import 'package:tax_calculator/src/shared/decimal.dart';
import 'package:tax_calculator/src/views/MonthlyCalculation/MonthlyCalculation.dart';
import 'package:tax_calculator/src/views/YearlyCalculation/YearlyCalculation.dart';

// bottom navigation
const _kNavigationItems = [
  {
    'icon': 'assets/month.png',
    'activeIcon': 'assets/month-active.png',
    'title': '月度计算',
  },
  {
    'icon': 'assets/year.png',
    'activeIcon': 'assets/year-active.png',
    'title': '年度计算',
  },
];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _views = [
    // 月度计算
    MonthlyCalculation(initMoney: D('2000')),
    YearlyCalculation(),
  ];

  int _currentIndex = 0;

  Widget bottomNavigationBarWidget() {
    final items = _kNavigationItems
        .map((var item) => BottomNavigationBarItem(
            icon: Image.asset(item['icon'], width: 30, height: 30),
            activeIcon: Image.asset(item['activeIcon'], width: 30, height: 30),
            title: Text(item['title'])))
        .toList();

    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black38,
      items: items,
      onTap: (int index) => setState(() => _currentIndex = index),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _views[_currentIndex],
      bottomNavigationBar: bottomNavigationBarWidget(),
    );
  }
}
