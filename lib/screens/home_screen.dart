import 'package:flutter/material.dart';
import 'package:tradingsolutions/screens/bidsd/bid_screen.dart';
import 'package:tradingsolutions/screens/orders/orders_screen.dart';
import 'package:tradingsolutions/screens/portfolio/portfolio_screen.dart';
import 'package:tradingsolutions/screens/profile/profile_screen.dart';
import 'package:tradingsolutions/widgets/market_appbar.dart';

import 'package:tradingsolutions/widgets/top_sheet_content.dart';
import 'dart:ui'; 

import 'watchlist/watchlist_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  bool _isTopSheetOpen = false; 
  final double _topSheetHeight = 300.0; 

  static const List<Widget> _screens = <Widget>[
    WatchlistScreen(),
    OrdersScreen(),
    PortfolioScreen(),
    BidScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // NEW: Toggles the animation state
  void _toggleTopSheet() {
    setState(() {
      _isTopSheetOpen = !_isTopSheetOpen;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Stack(
        children: [
      
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
     
            top: _isTopSheetOpen ? 0 : -_topSheetHeight,
            left: 0,
            right: 0,
            height: _topSheetHeight,
            child:TopSheetContent(
              onClose: _toggleTopSheet, // Pass the toggle function
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),

            top: _isTopSheetOpen ? _topSheetHeight : 0,

            bottom: _isTopSheetOpen ? -_topSheetHeight : 0,
            left: 0,
            right: 0,
            child: ImageFiltered(
   
              imageFilter: ImageFilter.blur(
                sigmaX: _isTopSheetOpen ? 2.0 : 0.0,
                sigmaY: _isTopSheetOpen ? 2.0 : 0.0,
              ),
              child: IgnorePointer(

                ignoring: _isTopSheetOpen,
                child: Scaffold(
                  appBar: MarketAppBar(onToggleTopSheet: _toggleTopSheet)
                  ,
                  body: Center(
                    child: _screens.elementAt(_selectedIndex),
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.bookmark_border),
                        label: 'Watchlist',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.book),
                        label: 'Orders',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.work_outline),
                        label: 'Portfolio',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.airplay),
                        label: 'Bids',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person_outline),
                        label: 'Profile',
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    selectedItemColor: Colors.blue,
                    unselectedItemColor: Colors.grey,
                    backgroundColor: Colors.white,
                    elevation: 10,
                    showUnselectedLabels: true,
                    type: BottomNavigationBarType.fixed,
                    onTap: _onItemTapped,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
