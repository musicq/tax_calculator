import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';

/// 酬金收入
class Remunerations {
  static Remunerations _instance;

  // 劳务报酬
  final _serviceRemuneration$ = BehaviorSubject<Decimal>.seeded(D('0'));

  // 稿酬
  final _manuscriptRemuneration$ = BehaviorSubject<Decimal>.seeded(D('0'));

  // 特许权使用费所得
  final _royalties$ = BehaviorSubject<Decimal>.seeded(D('0'));

  Remunerations._internal();

  factory Remunerations([Decimal initialValue]) {
    return Remunerations._instance ??
        (Remunerations._instance = Remunerations._internal());
  }

  /// 订阅劳务报酬
  Stream<Decimal> get service$ => Observable(_serviceRemuneration$);

  /// 设置劳务报酬
  setServiceRemuneration(Decimal v) {
    _serviceRemuneration$.add(v);
  }

  /// 订阅稿酬
  Stream<Decimal> get manuscript$ => Observable(_manuscriptRemuneration$);

  /// 设置稿酬
  setManuscriptRemuneration(Decimal v) {
    _manuscriptRemuneration$.add(v);
  }

  /// 订阅特许权使用费所得
  Stream<Decimal> get royalties$ => Observable(_royalties$);

  /// 设置特许权使用费所得
  setRoyalties(Decimal v) {
    _royalties$.add(v);
  }
}
