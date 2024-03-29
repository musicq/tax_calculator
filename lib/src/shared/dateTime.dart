const Map<int, String> _months = {
  1: '一',
  2: '二',
  3: '三',
  4: '四',
  5: '五',
  6: '六',
  7: '七',
  8: '八',
  9: '九',
  10: '十',
  11: '十一',
  12: '十二',
};

/// translateMonth 是将数字转换成中文月份
/// 比如：translateMonth(1) -> 一月
String translateMonth(int month) {
  return '${_months[month]}月';
}
