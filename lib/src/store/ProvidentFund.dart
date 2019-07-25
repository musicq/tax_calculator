import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';

import 'Income.dart';

enum ProvidentType { Highest, Lowest, No, Customize }

/// 住房公积金
class ProvidentFund {
  static ProvidentFund _instance;

  // 公积金缴纳比例
  final _rate$ = BehaviorSubject<Decimal>.seeded(D('0.11'));

  // 公积金金额
  ReplaySubject<Decimal> _val$ = ReplaySubject<Decimal>(maxSize: 1);

  ProvidentFund._internal() {
    CombineLatestStream.list([Income().val$, rate$])
        .map((groups) => groups[0] * groups[1])
        .listen((v) => _val$.add(v));
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
}
