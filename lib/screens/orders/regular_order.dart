// // lib/screens/order_tabs/regular_order_form.dart

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';


// enum ProductType { intraday, longterm }

// enum Validity { day, ioc, minutes }


// class RegularOrder extends StatefulWidget {
//   const RegularOrder({super.key});

//   @override
//   RegularOrderState createState() => RegularOrderState();
// }

// class RegularOrderState extends State<RegularOrder> {
//   // --- THIS FORM'S INTERNAL STATE ---
//   ProductType _selectedProduct = ProductType.longterm;
//   Validity _selectedValidity = Validity.day;

//   bool _isStoplossOn = false;
//   bool _isGttOn = false;
//   bool _isMarketProtectionOn = false;
//   bool _isAdvancedExpanded = false;

//   final _quantityController = TextEditingController(text: '1');
//   final _limitPriceController = TextEditingController(text: '3.43');
//   final _disclosedQtyController = TextEditingController(text: '0');

//   void submitOrder() {}

//   void _onExchangeChanged(ProductType? value) {
//     if (value == null || value == _selectedProduct) return;

//     setState(() {
//       _selectedProduct = value;
//     });
//   }


//   @override
//   void dispose() {
//     _quantityController.dispose();
//     _limitPriceController.dispose();
//     _disclosedQtyController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return SingleChildScrollView(
//       child: Stack(
//         children: [_mainContainer(theme), _buildProductCard(theme)],
//       ),
//     );

  
//   }

//   Widget _buildProductCard(ThemeData theme) {
//     return 

//     Container(
      
//         margin: const EdgeInsets.only( left: 24, right: 24),
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(4),
//         color: Colors.green),
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 10,),
//             Text("Quantity"),
//             _buildTextField(_quantityController, 'Quantity'),
//             const SizedBox(height: 16),
//             Text("Limit"),
//             _buildTextField(_limitPriceController, 'Limit'),
         
//           ],
//         ),
     
//     );
//   }

//   Widget _mainContainer(ThemeData theme) {
//     return Container(
     
//       margin: EdgeInsets.only(top: 50),
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 184, 160, 160),
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12),
//         ),
//       ),
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           SizedBox(height: 150,),
//            if (_selectedProduct == ProductType.longterm)
//             _buildSwitch('GTT', _isGttOn, (val) {
//               setState(() => _isGttOn = val);
//             }),
//           _buildSwitch('Stoploss', _isStoplossOn, (val) {
//             setState(() => _isStoplossOn = val);
//           }),
//           _buildSwitch('Market protection', _isMarketProtectionOn, (val) {
//             setState(() => _isMarketProtectionOn = val);
//           }),
//              const SizedBox(height: 24),
//             _buildAdvancedSection(theme)
//         ],
//       )
//     );
//   }
//    Widget _buildExchangeRadio(
//       String title, ProductType value, ThemeData theme) {
//     return InkWell(
//       onTap: () => _onExchangeChanged(value),
//       child: Row(
//         children: [
//           Radio<Exchange>(
//             value: value,
//             groupValue: _selectedExchange,
//             onChanged: _onExchangeChanged,
//           ),
//           RichText(
//             text: TextSpan(
//               text: '$title ',
//               style: theme.textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.bold,
//                   color: _selectedExchange == value
//                       ? theme.primaryColor
//                       : Colors.grey),
//               children: [
//                 TextSpan(
//                   text: '₹$price',
//                   style: theme.textTheme.bodyMedium?.copyWith(
//                       color: _selectedExchange == value
//                           ? theme.primaryColorDark
//                           : Colors.grey,
//                       fontWeight: FontWeight.normal),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProductTypeToggle(ThemeData theme) {
//     return SizedBox(
//       width: double.infinity,
//       child: CupertinoSegmentedControl<ProductType>(
//         children: const {
//           ProductType.intraday: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text('Intraday'),
//           ),
//           ProductType.longterm: Padding(
//             padding: EdgeInsets.all(8.0),
//             child: Text('Longterm'),
//           ),
//         },
//         groupValue: _selectedProduct,
//         onValueChanged: (value) {
//           setState(() => _selectedProduct = value);
//         },
//         borderColor: theme.primaryColor,
//         selectedColor: theme.primaryColor,
//         unselectedColor: Colors.white,
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//         suffixIcon: IconButton(
//           icon: const Icon(Icons.swap_horiz_outlined, color: Colors.blue),
//           onPressed: () {},
//         ),
//       ),
//     );
//   }

//   Widget _buildSwitch(String title, bool value, Function(bool) onChanged) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           children: [
//             Text(title, style: const TextStyle(fontSize: 16)),
//             const SizedBox(width: 4),
//             Icon(Icons.info_outline, color: Colors.grey[400], size: 16),
//           ],
//         ),
//         Switch(value: value, onChanged: onChanged),
//       ],
//     );
//   }

//   Widget _buildAdvancedSection(ThemeData theme) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: () =>
//               setState(() => _isAdvancedExpanded = !_isAdvancedExpanded),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 Text('Advanced', style: TextStyle(color: theme.primaryColor)),
//                 Icon(
//                   _isAdvancedExpanded ? Icons.expand_less : Icons.expand_more,
//                   color: theme.primaryColor,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Visibility(
//           visible: _isAdvancedExpanded,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Validity',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               SizedBox(
//                 width: double.infinity,
//                 child: CupertinoSegmentedControl<Validity>(
//                   children: const {
//                     Validity.day: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text('DAY'),
//                     ),
//                     Validity.ioc: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text('IOC'),
//                     ),
//                     Validity.minutes: Padding(
//                       padding: EdgeInsets.all(8.0),
//                       child: Text('Minutes'),
//                     ),
//                   },
//                   groupValue: _selectedValidity,
//                   onValueChanged: (value) {
//                     setState(() => _selectedValidity = value);
//                   },
//                   borderColor: Colors.grey,
//                   selectedColor: Colors.grey[300],
//                   unselectedColor: Colors.white,
//                   pressedColor: Colors.grey[200]!,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(_disclosedQtyController, 'Disclosed Qty.'),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
