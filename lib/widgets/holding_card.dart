import 'package:flutter/material.dart';

class HoldingCard extends StatelessWidget {
  const HoldingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: const [
           Divider(height: 8),
          HoldingItem(
            qty: 218,
            name: "ABCD FOODS",
            holdingPrice: "1,046.65",
            pnl: "+ 3,626.70",
            pnlColor: Colors.green,
            tag: "#47",
            ltp: "1,592.70",
          ),
          
        ],
   
    );
  }
}

class HoldingItem extends StatelessWidget {
  final int qty;
  final String name;
  final String holdingPrice;
  final String pnl;
  final Color pnlColor;
  final String tag;
  final String ltp;

  const HoldingItem({
    super.key,
    required this.qty,
    required this.name,
    required this.holdingPrice,
    required this.pnl,
    required this.pnlColor,
    required this.tag,
    required this.ltp,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Top Row: Eligible qty + P&L
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Eligible qty $qty",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            Text(
              "Holding P&L $pnl",
              style: TextStyle(
                color: pnlColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),

        // Stock Name + Tag
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              tag,
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),

        // Holding price + LTP
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Holding price $holdingPrice",
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
            Text(
              "LTP $ltp",
              style: const TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
