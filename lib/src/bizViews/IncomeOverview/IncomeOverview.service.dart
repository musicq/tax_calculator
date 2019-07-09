import 'package:decimal/decimal.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tax_calculator/src/shared/decimal.dart';

final taxRate = D('0.1');
final providentFundRate = D('0.11');
final insuranceRate = D('0.12');

// 计算税后收入
Observable<Decimal> calcIncomeAfterTax(BehaviorSubject<Decimal> income$) {
  return income$.map((income) => income * (D('1') - taxRate));
}

// 计算个税
Observable<Decimal> calcTax(BehaviorSubject<Decimal> income$) {
  return income$.map((income) => income * taxRate);
}

// 计算公积金
Observable<Decimal> calcProvidentFund(BehaviorSubject<Decimal> income$) {
  return income$.map((income) => income * providentFundRate);
}

// 计算公积金
Observable<Decimal> calcInsurance(BehaviorSubject<Decimal> income$) {
  return income$.map((income) => income * insuranceRate);
}
