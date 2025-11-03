import 'package:flutter/material.dart';
import 'package:tradingsolutions/data/stock_data.dart';
import 'package:tradingsolutions/screens/search_view_screen.dart';
import 'package:tradingsolutions/widgets/search_bar.dart';
import 'package:tradingsolutions/widgets/stock_detail_sheet.dart';

class Watchlist1 extends StatelessWidget {
   Watchlist1({super.key});
 
  final List<Stock> dummyWatchlist = [
    Stock(
      companyName: "HDFCBANK",
      exchange: "BSE",
      value: "986.45",
      change: "-2.10 (1.71%)",
      isPositive: false,
    ),
    Stock(
      companyName: "TCS",
      exchange: "BSE",
      value: "1487",
      change: "+45.10 (5.71%)",
      isPositive: true,
    ),
    Stock(
      companyName: "INFY",
      exchange: "NSE",
      value: "3056.1",
      change: "+25.10 (2.71%)",
      isPositive: true,
    ),
    Stock(
      companyName: "GOLDBEES",
      exchange: "NSE",
      value: "100.23",
      change: "-12.10 (-1.71%)",
      isPositive: false,
    ),
    Stock(
      companyName: "HDFCBANK",
      exchange: "BSE",
      value: "986.45",
      change: "-2.10 (1.71%)",
      isPositive: false,
    ),
    Stock(
      companyName: "GROWW",
      exchange: "NSE",
      value: "92.45",
      change: "-5.10 (1.71%)",
      isPositive: false,
    ),
    Stock(
      companyName: "LENSKART",
      exchange: "BSE",
      value: "382.45",
      change: "1.10 (1.71%)",
      isPositive: true,
    ),
    Stock(
      companyName: "VODAPHONE",
      exchange: "BSE",
      value: "986.45",
      change: "-2.10 (1.71%)",
      isPositive: false,
    ),
    Stock(
      companyName: "SAFECURE",
      exchange: "NSE",
      value: "102",
      change: "3 (1.71%)",
      isPositive: true,
    ),
    Stock(
      companyName: "STUDDS",
      exchange: "BSE",
      value: "382.45",
      change: "-1.3 (1.71%)",
      isPositive: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                _buildStocksContainer(context),
                _buildSearchBar(context),
              ],
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildSearchBar(BuildContext context) {
    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: MySearchBar(
        count: 0,
        total: 100,
        onSearchTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchViewScreen()),
          );
        },
        onFilterTap: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            builder: (_) => const Center(
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Text('Filter options here'),
              ),
            ),
          );
        },
      ),
    );
  }

 Widget _buildStocksContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          ListView.separated(
            itemCount: dummyWatchlist.length,
            shrinkWrap: true, // Important inside a SingleChildScrollView
            physics:
                const NeverScrollableScrollPhysics(), 
            itemBuilder: (context, index) {
              final stock = dummyWatchlist[index];
              return _watchListItem(
                stock: stock,
                onTap: () {

                  showStockDetails(context, stock);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 16),
          ),
        ],
      ),
    );
  }

  // --- 4. UPDATED WIDGET ---
  Widget _watchListItem({
    required Stock stock,
    required VoidCallback onTap, // <-- Added onTap
  }) {
    // Wrap with InkWell to make it tappable
    return InkWell(
      onTap: onTap, // <-- Assign the tap callback
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0), // Add padding for a better tap area
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Company name + exchange
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stock.companyName, // <-- Use data from model
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  stock.exchange, // <-- Use data from model
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            // Right: Price + change
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  stock.value, // <-- Use data from model
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  stock.change, // <-- Use data from model
                  style: TextStyle(
                    color: stock.isPositive
                        ? Colors.green
                        : Colors.red, // <-- Use data from model
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}