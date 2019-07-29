import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';

import 'Income.dart';

enum InsuranceType { Highest, Lowest, No, Customize }

/// 社保
class Insurance {
  static Insurance _instance;

  // 社保比例
  final _rate$ = BehaviorSubject<Decimal>.seeded(D('0.11'));

  // 社保金额
  ReplaySubject<Decimal> _val$ = ReplaySubject<Decimal>(maxSize: 1);

  Insurance._internal() {
    CombineLatestStream.list([Income().val$, rate$])
        .map((groups) => groups[0] * groups[1])
        .listen((v) => _val$.add(v));
  }

  factory Insurance() {
    return Insurance._instance ?? (Insurance._instance = Insurance._internal());
  }

  /// 获取社保比例
  Stream<Decimal> get rate$ => _rate$;

  /// 设置社保比例
  setRate(Decimal v) {
    _rate$.add(v);
  }

  /// 获取社保金额
  Stream<Decimal> get val$ => _val$;
}
