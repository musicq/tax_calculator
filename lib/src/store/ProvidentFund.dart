import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';

import 'Income.dart';

enum ProvidentType { Highest, Lowest, No, Customize }

final lowestLine = D('2050');
final highestLine = D('25983');

/// 住房公积金
class ProvidentFund {
  static ProvidentFund _instance;
  final _income = Income();

  // 公积金基数
  final _basisInput$ = BehaviorSubject<Decimal>.seeded(D('0'));
  final _basis$ = ReplaySubject<Decimal>(maxSize: 1);

  // 公积金缴纳比例
  final _rate$ = BehaviorSubject<Decimal>.seeded(D('0.11'));

  // 公积金金额
  ReplaySubject<Decimal> _val$ = ReplaySubject<Decimal>(maxSize: 1);

  ProvidentFund._internal() {
    // 公积金金额
    CombineLatestStream.list([basis$, rate$])
        .map((groups) => groups[0] * groups[1])
        .listen((v) => _val$.add(v));

    // 公积金基数
    MergeStream([_basisInput$, _income.val$])
        .map((v) => min(
            highestLine.toDouble(), max(lowestLine.toDouble(), v.toDouble())))
        .listen((v) => _basis$.add(D(v.toString())));
  }

  factory ProvidentFund() {
    return ProvidentFund._instance ??
        (ProvidentFund._instance = ProvidentFund._internal());
  }

  /// 获取公积金比例
  Stream<Decimal> get rate$ => _rate$;

  /// 设置公积金比例
  setRate(Decimal v) {
    _rate$.add(v);
  }

  /// 获取公积金金额
  Stream<Decimal> get val$ => _val$;

  /// 公积金基数
  Stream<Decimal> get basis$ => _basis$;

  /// 设置公积金基数
  setBasis(Decimal v) {
    _basisInput$.add(v);
  }
}
