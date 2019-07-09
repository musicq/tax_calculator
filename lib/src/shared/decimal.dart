import 'package:decimal/decimal.dart';

Decimal D(String value) {
  return Decimal.parse(value);
}

String toMoney(Decimal value) {
  return value.toStringAsFixed(2);
}
