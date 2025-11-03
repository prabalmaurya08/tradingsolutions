import 'package:flutter/material.dart';
import 'package:tradingsolutions/data/stock_data.dart';
import 'package:tradingsolutions/widgets/custom_tabbed_view.dart';
import 'package:tradingsolutions/widgets/stock_detail_sheet.dart';

class SearchViewScreen extends StatefulWidget {
  const SearchViewScreen({super.key});

  @override
  State<SearchViewScreen> createState() => _SearchViewScreenState();
}

class _SearchViewScreenState extends State<SearchViewScreen> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
final List<Stock> searchResults = [
    Stock(
      companyName: "RELIANCE",
      exchange: "NSE",
      value: "2845.10",
      change: "+30.05 (1.07%)",
      isPositive: true,
    ),
    Stock(
      companyName: "HDFCBANK",
      exchange: "BSE",
      value: "986.45",
      change: "-2.10 (1.71%)",
      isPositive: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _controller,
          focusNode: _focusNode,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search e.g:RELIANCE, HDFCBANK',
            border: InputBorder.none,
          ),
        ),
      ),
      body: 
          
           // CustomTabbedView(tabs: ['#','MF','IPO','Events','Brands','ETFS'], views: [HashScreen(),MFScreen(),IPOScreen(),EventScreen(),BrandScreen(),ETFScreen()]),
        
          
            ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            final stock = searchResults[index];
            
            return ListTile(
              title: Text(stock.companyName),
              subtitle: Text(stock.exchange),
              trailing: Text(
                stock.value,
                style: TextStyle(
                    color: stock.isPositive ? Colors.green : Colors.red),
              ),
              onTap: () {
                // --- 3. CALL THE SAME FUNCTION ---
                showStockDetails(context, stock);
              },
            );
          },
        ),
        
     
      
    );
  }
}
class HashScreen extends StatelessWidget {
  const HashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class IPOScreen extends StatelessWidget {
  const IPOScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class MFScreen extends StatelessWidget {
  const MFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class ETFScreen extends StatelessWidget {
  const ETFScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class BrandScreen extends StatelessWidget {
  const BrandScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}