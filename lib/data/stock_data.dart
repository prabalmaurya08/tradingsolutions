// lib/models/stock.dart

class Stock {
  final String companyName;
  final String exchange;
  final String value;
  final String change;
  final bool isPositive;
  // You can add more fields here if the bottom sheet needs them (e.g., open, high, low)

  Stock({
    required this.companyName,
    required this.exchange,
    required this.value,
    required this.change,
    required this.isPositive,
  });
}