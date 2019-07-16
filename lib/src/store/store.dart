import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';

// 税前薪资收入
final income$ = BehaviorSubject<Decimal>.seeded(D('0'));
// 专项附加扣除金额
final specialItemsAmount$ = BehaviorSubject<Decimal>.seeded(D('0'));
// 劳务报酬
final serviceRemuneration$ = BehaviorSubject<Decimal>.seeded(D('0'));
// 稿酬
final manuscriptRemuneration$ = BehaviorSubject<Decimal>.seeded(D('0'));
// 特许权使用费所得
final royalties$ = BehaviorSubject<Decimal>.seeded(D('0'));

// 公积金缴纳
final providentFundRate$ = BehaviorSubject<Decimal>.seeded(D('0.11'));
final providentFund$ = CombineLatestStream.list([income$, providentFundRate$])
    .map((groups) => groups[0] * groups[1])
    .asBroadcastStream();

// 社保缴纳
final insuranceRate$ = BehaviorSubject<Decimal>.seeded(D('0.11'));
final insurance$ = CombineLatestStream.list([income$, insuranceRate$])
    .map((groups) => groups[0] * groups[1])
    .asBroadcastStream();

// 总收入
final _totalIncome$ = CombineLatestStream.list(
        [income$, serviceRemuneration$, manuscriptRemuneration$, royalties$])
    .map((groups) => groups[0] + groups[1] + groups[2] + groups[3]);

// 实际上税金额
final _incomeNeedForTax$ = CombineLatestStream.list(
        [_totalIncome$, providentFund$, insurance$, specialItemsAmount$])
    .map((groups) => groups[0] - groups[1] - groups[2] - groups[3])
    .asBroadcastStream();

// 税率
final taxRate$ = _incomeNeedForTax$.map<Decimal>((income) {
  if (income <= D('5000')) {
    return D('0');
  } else if (income < D('10000')) {
    return D('0.15');
  } else {
    return D('0.25');
  }
});

// 个税
final tax$ = CombineLatestStream.list([_incomeNeedForTax$, taxRate$])
    .map((groups) => groups[0] * groups[1])
    .asBroadcastStream();

// 税后收入
final incomeAfterTax$ = CombineLatestStream.list([_incomeNeedForTax$, tax$])
    .map((groups) => groups[0] - groups[1])
    .asBroadcastStream();
