import 'package:flutter/material.dart';
import 'market_index_widget.dart'; // your existing widget file

class MarketAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onToggleTopSheet;

  const MarketAppBar({
    super.key,
    required this.onToggleTopSheet,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey[300],
      title: Row(
        children: [
         
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  MarketIndexWidget(
                    name: "NIFTY 50",
                    value: "27000.50",
                    change: "-120.25 (-0.44%)",
                    isPositive: false,
                  ),
                  SizedBox(width: 16),
                  MarketIndexWidget(
                    name: "NIFTY BANK",
                    value: "45000.75",
                    change: "+50.10 (+0.11%)",
                    isPositive: true,
                  ),
                
                ],
              ),
            ),
          ),

         
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, color: Colors.black),
                onPressed: () {
                  // handle cart click
                },
              ),
              IconButton(
                icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.black),
                onPressed: onToggleTopSheet, // passed from parent
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 👇 REQUIRED for AppBar-like widgets
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
