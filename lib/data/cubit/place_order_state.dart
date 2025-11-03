// lib/cubit/place_order_state.dart
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

enum Exchange { bse, nse }
enum PageStatus { loading, success, error }

class PlaceOrderState extends Equatable {
  // --- Core State ---
  final bool isBuy; // The big one!
  final Exchange selectedExchange;
  final PageStatus status;

  // --- Data ---
  final String bsePrice;
  final String nsePrice;
  
  // --- UI-Managed State ---
  final List<Tab> tabs;
  final List<Widget> tabViews; // These contain the keys
  final TabController tabController;

  const PlaceOrderState({
    required this.isBuy,
    required this.selectedExchange,
    required this.status,
    required this.bsePrice,
    required this.nsePrice,
    required this.tabs,
    required this.tabViews,
    required this.tabController,
  });

  // Helper to create a dummy initial state
  factory PlaceOrderState.initial(TickerProvider vsync) {
    return PlaceOrderState(
      isBuy: true, // Default to buy
      selectedExchange: Exchange.bse,
      status: PageStatus.loading,
      bsePrice: "0.00",
      nsePrice: "0.00",
      tabs: const [Tab(text: '')],
      tabViews: [Container()],
      tabController: TabController(length: 1, vsync: vsync),
    );
  }

  // Helper to create a new state from the old one
  PlaceOrderState copyWith({
    bool? isBuy,
    Exchange? selectedExchange,
    PageStatus? status,
    String? bsePrice,
    String? nsePrice,
    List<Tab>? tabs,
    List<Widget>? tabViews,
    TabController? tabController,
  }) {
    return PlaceOrderState(
      isBuy: isBuy ?? this.isBuy,
      selectedExchange: selectedExchange ?? this.selectedExchange,
      status: status ?? this.status,
      bsePrice: bsePrice ?? this.bsePrice,
      nsePrice: nsePrice ?? this.nsePrice,
      tabs: tabs ?? this.tabs,
      tabViews: tabViews ?? this.tabViews,
      tabController: tabController ?? this.tabController,
    );
  }

  @override
  List<Object> get props => [
        isBuy,
        selectedExchange,
        status,
        bsePrice,
        nsePrice,
        tabs,
        tabViews,
        tabController
      ];
}