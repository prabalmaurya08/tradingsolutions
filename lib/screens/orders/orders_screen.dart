import 'package:flutter/material.dart';
import 'package:tradingsolutions/widgets/custom_tabbed_view.dart';
import 'package:tradingsolutions/widgets/order_list_card.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SafeArea(
        child: CustomTabbedView(
          tabs: ['Open', 'Executed', 'GTT','Basket','SIPs'],
          views: [OpenScreen(), ExecutedScreen(), GttScreens(),BasketScreens(),Sipscreens()],
        ),
      ),
    );
  }
}

class OpenScreen extends StatelessWidget {
  const OpenScreen({super.key});

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
        
          
          // Orders List Widget
          Expanded(
            child: OrdersListWidget(),
          ),
        ],
      ),
    );
  }
}
class ExecutedScreen extends StatelessWidget {
  const ExecutedScreen({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
        
          
          // Orders List Widget
          Expanded(
            child: OrdersListWidget(),
          ),
        ],
      ),
    );
  }
}
class Sipscreens extends StatelessWidget {
  const Sipscreens({super.key});

     @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
        
          
          // Orders List Widget
          Expanded(
            child: OrdersListWidget(),
          ),
        ],
      ),
    );
  }
}
class GttScreens extends StatelessWidget {
  const GttScreens({super.key});

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
        
          
          // Orders List Widget
          Expanded(
            child: OrdersListWidget(),
          ),
        ],
      ),
    );
  }
}

class BasketScreens extends StatelessWidget {
  const BasketScreens({super.key});

     @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
        
          
          // Orders List Widget
          Expanded(
            child: OrdersListWidget(),
          ),
        ],
      ),
    );
  }
}