// // lib/cubit/place_order_cubit.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:tradingsolutions/screens/orders/regular_order.dart';
// import 'place_order_state.dart';

// export 'place_order_state.dart' show Exchange; // So UI can use it

// class PlaceOrderCubit extends Cubit<PlaceOrderState> {
//   final TickerProvider vsync;

//   // --- All keys are owned by the Cubit ---
//   final _bseRegularKey = GlobalKey<RegularOrderState>();
//   // ... other BSE keys
//   final _nseRegularKey = GlobalKey<RegularOrderState>();
//   // ... other NSE keys
  
//   // --- All tab definitions are owned by the Cubit ---
//   late final List<Tab> _bseTabs;
//   late final List<Widget> _bseTabViews;
//   late final List<Tab> _nseTabs;
//   late final List<Widget> _nseTabViews;

//   PlaceOrderCubit({
//     required this.vsync,
//     required bool initialIsBuy, // Get this from the widget
//   }) : super(PlaceOrderState.initial(vsync).copyWith(isBuy: initialIsBuy)) {
//     // 1. Define all possible tabs and views
//     _bseTabs = const [Tab(text: 'Regular'), /* ... */];
//     _bseTabViews = [RegularOrder(key: _bseRegularKey), /* ... */];
//     _nseTabs = const [Tab(text: 'Regular'), Tab(text: 'Cover'), /* ... */];
//     _nseTabViews = [RegularOrder(key: _nseRegularKey), /* ... */];

//     // 2. Load initial data and set initial tabs (e.g., for BSE)
//     _updateTabsAndController(Exchange.bse);
//     _fetchPrices();
//   }

//   // --- PUBLIC EVENTS (Called by the UI) ---

//   void setBuySellMode(bool isBuy) {
//     if (isBuy == state.isBuy) return;
//     // Just emit a new state. The UI will react.
//     emit(state.copyWith(isBuy: isBuy));
//   }

//   void changeExchange(Exchange newExchange) {
//     if (newExchange == state.selectedExchange) return;

//     // Call our private helper
//     _updateTabsAndController(newExchange);
//   }
  
//   void submitActiveOrder() {
//     final index = state.tabController.index;
//     if (state.selectedExchange == Exchange.bse) {
//       switch (index) {
//         case 0:
//           _bseRegularKey.currentState?.submitOrder();
//           break;
//         // ... other cases
//       }
//     } else {
//       switch (index) {
//         case 0:
//           _nseRegularKey.currentState?.submitOrder();
//           break;
//         // ... other cases
//       }
//     }
//   }

//   // --- PRIVATE LOGIC (Internal to the Cubit) ---

//   void _fetchPrices() {
//     // In a real app, you'd use an API service here.
//     // Simulating a network call:
//     emit(state.copyWith(status: PageStatus.loading));
//     Future.delayed(const Duration(milliseconds: 500), () {
//       emit(state.copyWith(
//         status: PageStatus.success,
//         bsePrice: "3.43",
//         nsePrice: "3.42",
//       ));
//     });
//   }

//   void _updateTabsAndController(Exchange exchange) {
//     final tabs = (exchange == Exchange.bse) ? _bseTabs : _nseTabs;
//     final views = (exchange == Exchange.bse) ? _bseTabViews : _nseTabViews;

//     // Dispose old controller
//     state.tabController.dispose();
    
//     // Create new controller
//     final newController = TabController(length: tabs.length, vsync: vsync);

//     // Emit the new state with the correct tabs, views, and controller
//     emit(state.copyWith(
//       selectedExchange: exchange,
//       tabs: tabs,
//       tabViews: views,
//       tabController: newController,
//     ));
//   }
  
//   @override
//   Future<void> close() {
//     state.tabController.dispose();
//     return super.close();
//   }
// }