import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';

enum SpecialItemOptions {
  Child,
  Parent,
  Department,
  Rent,
  Education,
}

/// 专项附加扣除金额
class SpecialItemsAmount {
  static SpecialItemsAmount _instance;

  // 选中项
  Set<SpecialItemOptions> _selected = {};
  BehaviorSubject<Set<SpecialItemOptions>> _selected$ =
      BehaviorSubject.seeded({});

  // 总金额
  Decimal _value = D('0');

  BehaviorSubject<Decimal> _specialItemsAmount$ =
      BehaviorSubject.seeded(D('0'));

  SpecialItemsAmount._internal();

  factory SpecialItemsAmount([Decimal initialValue]) {
    return SpecialItemsAmount._instance ??
        (SpecialItemsAmount._instance = SpecialItemsAmount._internal());
  }

  /// 获取专项附加扣除金额
  Stream<Decimal> get val$ => _specialItemsAmount$;

  /// 获取已选中的扣除项
  Stream<Set<SpecialItemOptions>> get selected$ => _selected$;

  /// 增加专项附加扣除金额
  add(Decimal v, SpecialItemOptions type) {
    // 如果已经选中了，则去掉，反之加上
    if (_selected.contains(type)) {
      _selected.remove(type);
      _value -= v;
    } else {
      _selected.add(type);
      _value += v;
    }

    _selected$.add(_selected);
    _specialItemsAmount$.add(_value);
  }
}
