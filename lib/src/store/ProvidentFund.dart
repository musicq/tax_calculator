import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';

import 'Income.dart';

/// 住房公积金
class ProvidentFund {
  static ProvidentFund _instance;

  // 公积金缴纳比例
  final _rate$ = BehaviorSubject<Decimal>.seeded(D('0.11'));

  // 公积金金额
  Stream<Decimal> _val$ = Observable.just(D('0'));

  ProvidentFund._internal() {
    _val$ = CombineLatestStream.list([Income().val$, rate$])
        .map((groups) => groups[0] * groups[1])
        .asBroadcastStream();
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
