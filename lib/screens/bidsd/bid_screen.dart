import 'package:flutter/material.dart';
import 'package:tradingsolutions/screens/bidsd/bid_action_screen.dart';
import 'package:tradingsolutions/widgets/custom_tabbed_view.dart';

class BidScreen extends StatefulWidget {
  const BidScreen({super.key});

  @override
  State<BidScreen> createState() => _BidScreenState();
}

class _BidScreenState extends State<BidScreen> {
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: SafeArea(
        child: CustomTabbedView(
          tabs: ['Action', 'IPO', 'Gov.Securities'],
          views: [BidActionScreen(), IPOScreen(),GovScreen()],
        ),
      ),
    );
  }
}
class IPOScreen extends StatelessWidget {
  const IPOScreen({super.key});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
 
          Expanded(
            child: HoldingsListWidget(),
          ),
        ],
      ),
    );
  }
}
class GovScreen extends StatelessWidget {
  const GovScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
 
          Expanded(
            child: HoldingsListWidget(),
          ),
        ],
      ),
    );
  }
}