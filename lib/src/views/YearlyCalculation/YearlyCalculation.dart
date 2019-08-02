import 'package:flutter/material.dart';
import 'package:tax_calculator/src/bizViews/IncomeSummaryPanel/IncomeSummaryPanel.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

class YearlyCalculation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainContainer(
      showAppBar: false,
      body: IncomeSummaryPanel(),
    );
  }
}
