import 'package:flutter/material.dart';
import 'package:tradingsolutions/screens/watchlist/watchlist1.dart';
import 'package:tradingsolutions/screens/watchlist/watchlists.dart';
import 'package:tradingsolutions/widgets/custom_tabbed_view.dart';

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomTabbedView(
          tabs: ['Watchlist 1', 'Watchlist 2', 'Watchlist 3','Watchlist 4','Watchlist 5'],
          views: [Watchlist1(), Watchlist2(), Watchlist3(),Watchlist4(),Watchlist5()],
        ),
      ),
    );
  }
}




