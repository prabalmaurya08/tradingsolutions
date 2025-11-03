import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  final int count;
  final int total;
  final VoidCallback onSearchTap;
  final VoidCallback onFilterTap;

  const MySearchBar({
    super.key,
    required this.count,
    required this.total,
    required this.onSearchTap,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 12),
   
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onSearchTap,
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey, size: 22),
                    const SizedBox(width: 8),
                    Text(
                      'Search...',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      
            // Counter
            Text(
              '$count/$total',
              style: TextStyle(color: Colors.grey[700], fontSize: 14),
            ),
      
            const SizedBox(width: 8),
      
            // Divider
            Container(
              height: 24,
              width: 1,
              color: Colors.grey[300],
            ),
      
            const SizedBox(width: 8),
      
            // 🧩 Filter icon tappable separately
            InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: onFilterTap,
              child: const Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(Icons.filter_alt_outlined,
                    color: Colors.grey, size: 22),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
