class OhlcData {
  final DateTime time;
  final double open;
  final double high;
  final double low;
  final double close;
  final double volume;

  OhlcData(this.time, this.open, this.high, this.low, this.close, this.volume);
}
final List<OhlcData> dummyChartData = [
  OhlcData(DateTime(2024, 8, 1), 100, 110, 90, 105, 120000),
  OhlcData(DateTime(2024, 8, 2), 105, 120, 100, 110, 150000),
  OhlcData(DateTime(2024, 8, 3), 110, 115, 105, 112, 130000),
  // Add more days...
];
