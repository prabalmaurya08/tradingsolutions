import 'package:flutter/material.dart';
import 'package:tradingsolutions/data/stock_data.dart';
import 'package:tradingsolutions/screens/chart_screen.dart';
import 'package:tradingsolutions/screens/orders/place_order.dart';
// lib/utils/helpers.dart

void showStockDetails(BuildContext context, Stock stock) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.45,
        minChildSize: 0.45,
        maxChildSize: 0.95, 
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: StockDetailsSheet(
             stock: stock,
              isPositive: stock.isPositive,
              scrollController: scrollController, // 👈 pass controller
            ),
          );
        },
      );
    },
  );
}

class StockDetailsSheet extends StatelessWidget {
     Stock stock;
   final bool isPositive;
  final ScrollController? scrollController;
   StockDetailsSheet({
    super.key,
    required this.stock,
    required this.isPositive,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    // This container gives the rounded corners and top padding.
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor, // Or use Colors.white
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      // SingleChildScrollView ensures the content can scroll if it's too long
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle for the bottom sheet
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 1. Header (Using your parameters)
            _buildHeader(context),
            const SizedBox(height: 24),

            // 2. Buy / Sell Buttons (from image 2)
            _buildBuySellButtons(context),
            const SizedBox(height: 20),

            // 3. View Chart / Option Chain (from image 2)
            _buildChartOptions(context),
            const SizedBox(height: 20),

            // 4. Quick Actions: Alert / Notes / GTT (from image 2)
            _buildQuickActions(context),
            const Divider(height: 40),

            // 5. Market Depth Totals (from image 1)
            _buildMarketDepthTotals(context),
            const Divider(height: 40),

            // 6. Day's Range (from image 1)
            _buildDaysRange(context),
            const Divider(height: 40),

            // 7. Info Rows (Open, Prev. Close, Volume, etc. from image 1)
            _buildInfoRows(context),
            const Divider(height: 40),

            // 8. Apps (from image 1)
            _buildApps(context),
            const SizedBox(height: 16), // Extra space at the bottom
          ],
        ),
      ),
    );
  }

  // --- Reusable Helper Widgets ---

  /// Builds the header using the provided parameters
  Widget _buildHeader(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final priceColor = isPositive ? Colors.green[600] : Colors.red[600];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          stock.companyName,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              stock.exchange,
              style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(width: 8),
            Text(
              stock.value,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              stock.change,
              style: textTheme.bodyLarge?.copyWith(color: priceColor),
            ),
          ],
        ),
      ],
    );
  }
    /// 4. UPDATED Build the Buy and Sell buttons
  Widget _buildBuySellButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton(
            // --- ONPRESSED UPDATED ---
            onPressed: () {
               Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TradingOrderScreen(
                    nsePrice: '5.00',
                    bsePrice: '4.6',
                    stockName: stock.companyName,
                    isBuy: true, 
                  ),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 14),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            child: const Text('BUY'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: FilledButton(
            // --- ONPRESSED UPDATED ---
            onPressed: () {
              // Close the bottom sheet first
              Navigator.of(context).pop();
             // Then push the new order screen
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TradingOrderScreen(
                    nsePrice: '5.00',
                    bsePrice: '4.6',
                    stockName: stock.companyName,
                    isBuy: false, // This is the SELL button
                  ),
                ),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 14),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            child: const Text('SELL'),
          ),
        ),
      ],
    );
  }




  /// Builds the "View Chart" and "Option Chain" links
  Widget _buildChartOptions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> TradingChartScreen()));
          },
          icon: const Icon(Icons.bar_chart),
          label: const Text('View chart'),
        ),
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.list_alt_outlined),
          label: const Text('Option chain'),
        ),
      ],
    );
  }

  /// Builds the small icon buttons for Alert, Notes, and GTT
  Widget _buildQuickActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _IconTextButton(
          icon: Icons.notifications_outlined,
          label: 'Set alert',
          onPressed: () {},
        ),
        _IconTextButton(
          icon: Icons.note_add_outlined,
          label: 'Add notes',
          onPressed: () {},
        ),
        _IconTextButton(
          icon: Icons.toc_outlined,
          label: 'Create GTT',
          onPressed: () {},
        ),
      ],
    );
  }

  /// Builds the Bid/Ask totals view
  Widget _buildMarketDepthTotals(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final greyText = textTheme.bodyMedium?.copyWith(color: Colors.grey[600]);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Bid Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  '2,464.15',
                  style: textTheme.bodyLarge?.copyWith(color: Colors.blue),
                ),
                const SizedBox(width: 8),
                Text('1', style: greyText),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text('Total', style: greyText),
                const SizedBox(width: 8),
                Text(
                  '26,499',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Offer Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Text('1', style: greyText),
                const SizedBox(width: 8),
                Text(
                  '2,465.50',
                  style: textTheme.bodyLarge?.copyWith(color: Colors.red),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '31,244',
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Text('Total', style: greyText),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDaysRange(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final greyText = textTheme.bodySmall?.copyWith(color: Colors.grey[600]);

    const double low = 2453.65;
    const double high = 2479.25;

    final double parsedValue =
        double.tryParse(stock.value.replaceAll(',', '')) ?? low;
    final double currentValue = parsedValue.clamp(low, high);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Day's range",
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 2.0,
            thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 6.0),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 14.0),
            activeTrackColor: Colors.grey[400],
            inactiveTrackColor: Colors.grey[400],
            thumbColor: Colors.grey[700],
          ),
          child: Slider(
            value: currentValue,
            min: low,
            max: high,
            onChanged: null,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Low', style: greyText),
                Text(
                  low.toStringAsFixed(2),
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('High', style: greyText),
                Text(
                  high.toStringAsFixed(2),
                  style: textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Builds all the key-value info rows
  Widget _buildInfoRows(BuildContext context) {
    return Column(
      children: [
        _InfoRow(
          title1: 'Open',
          value1: '2,469.00',
          title2: 'Prev. close',
          value2: '2,469.60',
        ),
        const SizedBox(height: 16),
        _InfoRow(
          title1: 'Volume',
          value1: '71,550',
          title2: 'Avg. trade price',
          value2: '2,464.25',
        ),
        const SizedBox(height: 16),
        _InfoRow(
          title1: 'Last traded quantity',
          value1: '32',
          title2: 'Last traded at',
          value2: '2025-10-31 14:12:43',
        ),
        const SizedBox(height: 16),
        _InfoRow(
          title1: 'Lower circuit',
          value1: '2,222.65',
          title2: 'Upper circuit',
          value2: '2,716.55',
        ),
      ],
    );
  }

  /// Builds the "Apps" section
  Widget _buildApps(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Apps',
          style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ListTile(
          leading: const Icon(Icons.show_chart, color: Colors.orange),
          title: const Text('Fundamentals'),
          contentPadding: EdgeInsets.zero,
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.analytics_outlined, color: Colors.blue),
          title: const Text('Technicals'),
          contentPadding: EdgeInsets.zero,
          onTap: () {},
        ),
      ],
    );
  }
}

/// A reusable helper widget for the key-value pairs
class _InfoRow extends StatelessWidget {
  final String title1, value1, title2, value2;
  const _InfoRow({
    required this.title1,
    required this.value1,
    required this.title2,
    required this.value2,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final greyText = textTheme.bodySmall?.copyWith(color: Colors.grey[600]);
    final boldText = textTheme.bodyMedium?.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title1, style: greyText),
            const SizedBox(height: 4),
            Text(value1, style: boldText),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(title2, style: greyText),
            const SizedBox(height: 4),
            Text(value2, style: boldText),
          ],
        ),
      ],
    );
  }
}

/// A reusable helper widget for the small icon buttons
class _IconTextButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _IconTextButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Theme.of(context).primaryColor),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
