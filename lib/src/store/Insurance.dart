import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';

import 'Income.dart';

enum InsuranceType { Highest, Lowest, No, Customize }

const _lowestLine = 4279.00;
const _highestLine = 21396.00;

const Map<InsuranceType, double> _typeToMoney = {
  InsuranceType.Highest: _highestLine,
  InsuranceType.Lowest: _lowestLine,
  InsuranceType.No: 0,
  InsuranceType.Customize: -1,
};

/// 社保
class Insurance {
  static Insurance _instance;
  final _income = Income();

  // 社保基数
  final _basisInput$ = BehaviorSubject<Decimal>.seeded(D('0'));
  final _basis$ = ReplaySubject<Decimal>(maxSize: 1);

  // 公积金类型
  final _type$ = BehaviorSubject<InsuranceType>.seeded(InsuranceType.Highest);

  // 养老保险
  final _pensionRate$ = BehaviorSubject<Decimal>.seeded(D('0.08'));
  final _pensionVal$ = BehaviorSubject<Decimal>.seeded(D('0'));

  // 医疗保险
  final _medicalRate$ = BehaviorSubject<Decimal>.seeded(D('0.02'));
  final _medicalVal$ = BehaviorSubject<Decimal>.seeded(D('0'));

  // 失业保险
  final _unEmployRate$ = BehaviorSubject<Decimal>.seeded(D('0.005'));
  final _unEmployVal$ = BehaviorSubject<Decimal>.seeded(D('0'));

  // 社保总金额
  ReplaySubject<Decimal> _val$ = ReplaySubject<Decimal>(maxSize: 1);

  Insurance._internal() {
    CombineLatestStream.list([_basis$, _pensionRate$])
        .map((groups) => groups[0] * groups[1])
        .listen((v) => _pensionVal$.add(v));

    CombineLatestStream.list([_basis$, _medicalRate$])
        .map((groups) => groups[0] * groups[1])
        .listen((v) => _medicalVal$.add(v));

    CombineLatestStream.list([_basis$, _unEmployRate$])
        .map((groups) => groups[0] * groups[1])
        .listen((v) => _unEmployVal$.add(v));

    CombineLatestStream.list([_pensionVal$, _medicalVal$, _unEmployVal$])
        .map((group) => group.reduce((acc, cur) => acc + cur))
        .listen((v) => _val$.add(v));

    // 社保基数随着类型改变
    _type$.distinct().listen((InsuranceType type) {
      if (type != InsuranceType.Customize) {
        _basisInput$.add(D(_typeToMoney[type].toString()));
      }
    });

    // 社保基数
    MergeStream([_basisInput$.distinct(), _income.val$.distinct()])
        .skip(2)
        .distinct()
        .map((v) => max(_lowestLine, min(_highestLine, v.toDouble())))
        .transform(DoStreamTransformer(onData: (double v) {
      if (v == _typeToMoney[InsuranceType.Highest]) {
        _type$.add(InsuranceType.Highest);
      } else if (v == _typeToMoney[InsuranceType.Lowest]) {
        _type$.add(InsuranceType.Lowest);
      } else if (v == _typeToMoney[InsuranceType.No]) {
        _type$.add(InsuranceType.No);
      } else {
        _type$.add(InsuranceType.Customize);
      }
    })).listen((v) {
      _basis$.add(D(v.toString()));
    });
  }

  factory Insurance() {
    return Insurance._instance ?? (Insurance._instance = Insurance._internal());
  }

  /// 获取养老保险比例
  Observable<Decimal> get pensionRate$ => _pensionRate$;

  /// 获取养老保险金额
  Observable<Decimal> get pensionVal$ => _pensionVal$;

  /// 获取医疗保险比例
  Observable<Decimal> get medicalRate$ => _medicalRate$;

  /// 获取医疗保险金额
  Observable<Decimal> get medicalVal$ => _medicalVal$;

  /// 获取失业保险比例
  Observable<Decimal> get unEmployRate$ => _unEmployRate$;

  /// 获取失业保险金额
  Observable<Decimal> get unEmployVal$ => _unEmployVal$;

  /// 获取社保总金额
  Stream<Decimal> get val$ => _val$;

  /// 获取公积金类型
  Observable<InsuranceType> get type$ => _type$;

  /// 设置公积金类型
  setType(InsuranceType t) {
    _type$.add(t);
  }

  /// 社保基数
  Stream<Decimal> get basis$ => _basis$;

  /// 设置社保基数
  setBasis(Decimal v) {
    _basisInput$.add(v);
  }
}
