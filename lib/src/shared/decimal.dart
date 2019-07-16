import 'package:decimal/decimal.dart';

/// D 是 Decimal.parse 的缩写，来将一个字符串转换成 Decimal 对象
/// 如果输入值不是有效数字，则返回 Deciaml('0')
Decimal D(String value) {
  return Decimal.tryParse(value) ?? D('0');
}

/// toMoney 是格式化一个 Decimal 对象成 2 个小数点字符串
String toMoney(Decimal value) {
  return value.toStringAsFixed(2);
}
