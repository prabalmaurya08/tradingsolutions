import 'package:flutter/material.dart';


import 'package:tradingsolutions/widgets/investment_card.dart';
import 'package:tradingsolutions/widgets/holding_card.dart';

class HoldingsScreen extends StatelessWidget {
  const HoldingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
  
    const double kContainerMarginTop = 96.0;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        
        child: SingleChildScrollView(
          child: Stack(
           
            clipBehavior: Clip.none,
            children: [
           
              Padding(
                padding: const EdgeInsets.only(top: kContainerMarginTop),
                child: _buildHoldingContainer(), // Using the helper below
              ),


              const Positioned(
                top: 16.0, // Standard padding from the top
                left: 16.0,
                right: 16.0,
                child: InvestmentCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHoldingContainer() {
    return Container(
      width: double.infinity,

      padding: const EdgeInsets.only(
        top: 60.0,
        left: 16.0,
        right: 16.0,
        bottom: 16.0
        ),
      decoration: const BoxDecoration(
        color: Colors.white,
     
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔍 Filter + Search Row
          Row(
            children: [
              Icon(Icons.filter_list, color: Colors.blue),
              const SizedBox(width: 12),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search holdings",
                    hintStyle: const TextStyle(color:Colors.blue),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 12,
                    ),
                  ),
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
              const SizedBox(width: 12),
              Icon(Icons.analytics_outlined, color: Colors.blue),
            ],
          ),

          const SizedBox(height: 16),

        
          ListView.builder(
            shrinkWrap: true, // Tells the ListView to only take up the space it needs
            physics: const NeverScrollableScrollPhysics(), // Disables this list's scrolling
            itemCount: 10, // Example: Show 10 holding cards
            itemBuilder: (context, index) {
              // Add some padding between cards
              return const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: HoldingCard(),
              );
            },
          ),
        ],
      ),
    );
  }
}