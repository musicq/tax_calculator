import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';

import 'Income.dart';

enum ProvidentType { Highest, Lowest, No, Customize }

const _lowestLine = 2050.00;
const _highestLine = 25983.00;

const Map<ProvidentType, double> _typeToMoney = {
  ProvidentType.Highest: _highestLine,
  ProvidentType.Lowest: _lowestLine,
  ProvidentType.No: 0,
  ProvidentType.Customize: -1,
};

/// 住房公积金
class ProvidentFund {
  static ProvidentFund _instance;

  final _income = Income();

  // 公积金基数
  final _basisInput$ = BehaviorSubject<Decimal>.seeded(D('0'));
  final _basis$ = ReplaySubject<Decimal>(maxSize: 1);

  // 公积金类型
  final _type$ = BehaviorSubject<ProvidentType>.seeded(ProvidentType.Highest);

  // 公积金缴纳比例
  final _rate$ = BehaviorSubject<Decimal>.seeded(D('0.07'));

  // 公积金金额
  ReplaySubject<Decimal> _val$ = ReplaySubject<Decimal>(maxSize: 1);

  ProvidentFund._internal() {
    // 公积金金额
    CombineLatestStream.list([_basis$, _rate$])
        .map((groups) => groups[0] * groups[1])
        .listen((v) => _val$.add(v));

    // 公积金基数随着类型改变
    _type$.distinct().listen((ProvidentType type) {
      if (type != ProvidentType.Customize) {
        _basisInput$.add(D(_typeToMoney[type].toString()));
      }
    });

    // 公积金基数
    MergeStream([_basisInput$.distinct(), _income.val$.distinct()])
        .skip(2)
        .distinct()
        .map((v) => max(_lowestLine, min(_highestLine, v.toDouble())))
        .transform(DoStreamTransformer(onData: (double v) {
      if (v == _typeToMoney[ProvidentType.Highest]) {
        _type$.add(ProvidentType.Highest);
      } else if (v == _typeToMoney[ProvidentType.Lowest]) {
        _type$.add(ProvidentType.Lowest);
      } else if (v == _typeToMoney[ProvidentType.No]) {
        _type$.add(ProvidentType.No);
      } else {
        _type$.add(ProvidentType.Customize);
      }
    })).listen((v) {
      _basis$.add(D(v.toString()));
    });
  }

  factory ProvidentFund() {
    return ProvidentFund._instance ??
        (ProvidentFund._instance = ProvidentFund._internal());
  }

  /// 获取公积金比例
  Stream<Decimal> get rate$ => _rate$;

  /// 设置公积金比例
  setRate(Decimal v) {
    // 转换成小数
    _rate$.add(v / D('100'));
  }

  /// 获取公积金金额
  Stream<Decimal> get val$ => _val$;

  /// 公积金基数
  Stream<Decimal> get basis$ => _basis$;

  /// 设置公积金基数
  setBasis(Decimal v) {
    _basisInput$.add(v);
  }

  /// 获取公积金类型
  Observable<ProvidentType> get type$ => _type$;

  /// 设置公积金类型
  setType(ProvidentType t) {
    _type$.add(t);
  }
}
