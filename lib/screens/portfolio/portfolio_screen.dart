import 'package:flutter/material.dart';
import 'package:tradingsolutions/screens/portfolio/holdings_screen.dart';
import 'package:tradingsolutions/screens/portfolio/positions_screen.dart';
import 'package:tradingsolutions/widgets/custom_tabbed_view.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomTabbedView(
          tabs: ['Holdings', 'Positions'],
          views: [HoldingsScreen(),PositionsScreen()],
        ),
      ),
    );
  }
}
