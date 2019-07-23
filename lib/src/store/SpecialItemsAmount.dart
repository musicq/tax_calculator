import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';

/// 专项附加扣除金额
class SpecialItemsAmount {
  static SpecialItemsAmount _instance;

  Decimal _value = D('0');

  //  final _tmp$ = BehaviorSubject<_Operator>.seeded(
  //      _Operator(type: OperatorType.add, value: D('0')));

  BehaviorSubject<Decimal> _specialItemsAmount$ =
      BehaviorSubject.seeded(D('0'));

  SpecialItemsAmount._internal() {
    // 由于 scan 操作符有问题，改用另一种实现方式
    //    _specialItemsAmount$ = _tmp$.scan<Decimal>((acc, cur, _) {
    //      if (cur.type == OperatorType.add) {
    //        return acc + cur.value;
    //      } else if (cur.type == OperatorType.minus) {
    //        return acc - cur.value;
    //      }
    //
    //      print('invalid operator, skip process.');
    //      return acc;
    //    }, D('0'));
  }

  factory SpecialItemsAmount([Decimal initialValue]) {
    return SpecialItemsAmount._instance ??
        (SpecialItemsAmount._instance = SpecialItemsAmount._internal());
  }

  /// 获取专项附加扣除金额
  Stream<Decimal> get val$ => _specialItemsAmount$;

  /// 增加专项附加扣除金额
  add(Decimal v) {
    //     final next = _Operator(type: OperatorType.add, value: v);
    //     _tmp$.add(next);

    _value += v;
    _specialItemsAmount$.add(_value);
  }

  /// 减少专项附加扣除金额
  minus(Decimal v) {
    //    final next = _Operator(type: OperatorType.minus, value: v);
    //    _tmp$.add(next);

    _value -= v;
    _specialItemsAmount$.add(_value);
  }
}

/// 操作类型
enum OperatorType { add, minus }

/// 内部数据操作类
class _Operator {
  final OperatorType type;
  final Decimal value;

  _Operator({this.type, this.value});
}
