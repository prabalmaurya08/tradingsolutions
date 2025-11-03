import 'package:flutter/material.dart';

class MarketIndexWidget extends StatelessWidget {
  final String name;
  final String value;
  final String change;
  final bool isPositive;

  const MarketIndexWidget({
    super.key,
    required this.name,
    required this.value,
    required this.change,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    // Determine the color based on positive or negative change
    final Color changeColor = isPositive ? Colors.green : Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                color: changeColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              change,
              style: TextStyle(
                fontSize: 12,
                color: changeColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
