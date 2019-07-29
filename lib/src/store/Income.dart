import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';

import 'Insurance.dart';
import 'ProvidentFund.dart';
import 'Remunerations.dart';
import 'SpecialItemsAmount.dart';

/// 税前总工资收入
class Income {
  static Income _instance;

  final _remunerations = Remunerations();
  final _income$ = BehaviorSubject<Decimal>.seeded(D('0'));

  Income._internal([Decimal initialValue]) {
    if (initialValue != null) {
      _income$.add(initialValue);
    }
  }

  factory Income([Decimal initialValue]) {
    return Income._instance ??
        (Income._instance = Income._internal(initialValue));
  }

  /// 获得税前总工资收入
  Observable<Decimal> get val$ => _income$;

  /// 设置税前总工资收入
  setVal(Decimal v) => _income$.add(v);

  /// 总收入
  Stream<Decimal> get _totalIncome$ {
    return CombineLatestStream.list([
      val$,
      _remunerations.service$,
      _remunerations.manuscript$,
      _remunerations.royalties$,
    ]).map((groups) => groups[0] + groups[1] + groups[2] + groups[3]);
  }

  /// 需要上税金额
  Stream<Decimal> get _incomeNeedForTax$ {
    return CombineLatestStream.list([
      _totalIncome$,
      ProvidentFund().val$,
      Insurance().val$,
      SpecialItemsAmount().val$,
    ])
        .map((groups) => groups[0] - groups[1] - groups[2] - groups[3])
        .asBroadcastStream();
  }

  /// 税率
  Stream<Decimal> get _taxRate$ {
    return _incomeNeedForTax$.map<Decimal>((income) {
      if (income <= D('5000')) {
        return D('0');
      } else if (income < D('10000')) {
        return D('0.15');
      } else {
        return D('0.25');
      }
    });
  }

  /// 个税
  Stream<Decimal> get tax$ {
    return CombineLatestStream.list([_incomeNeedForTax$, _taxRate$])
        .map((groups) => groups[0] * groups[1])
        .asBroadcastStream();
  }

  /// 税后收入
  Stream<Decimal> get incomeAfterTax$ {
    return CombineLatestStream.list([_incomeNeedForTax$, tax$])
        .map((groups) => groups[0] - groups[1])
        .asBroadcastStream();
  }
}
