import 'package:flutter/material.dart';
import 'package:tax_calculator/src/views/MonthlyCalculation/MonthlyCalculation.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final List<Widget> _views = [
    // 月度计算
    MonthlyCalculation(),
    Text('年度计算'),
  ];

  int _currentIndex = 0;

  Widget bottomNavigationBarWidget() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black38,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/month.png', width: 30, height: 30),
          activeIcon:
              Image.asset('assets/month-active.png', width: 30, height: 30),
          title: Text('月度计算'),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/year.png', width: 30, height: 30),
          activeIcon:
              Image.asset('assets/year-active.png', width: 30, height: 30),
          title: Text('年度计算'),
        ),
      ],
      onTap: (int index) => setState(() {
        _currentIndex = index;
      }),
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
