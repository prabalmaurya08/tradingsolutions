

import 'package:flutter/material.dart';

class TopSheetContent extends StatelessWidget {
  final VoidCallback onClose; // Callback to close the sheet

  const TopSheetContent({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
  
    final statusBarHeight = MediaQuery.of(context).padding.top;

    return Material(
   color: Color(0xFFF5F5F5),
      elevation: 10,
    

      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(16),
        bottomRight: Radius.circular(16),
      ),
      child: Padding(

        padding: EdgeInsets.only(
          top: statusBarHeight + 16.0,
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
       
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Overview',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onClose, // Use the callback to close
                ),
              ],
            ),

            Expanded(child: 
            Row(
              children: [
                Column(
                  children: [
                    Text("NIFTY 50"),
                    Text("27000.50"),
                    Text("-120.25 (-0.44%)"),
                  ],
                ),
                SizedBox(width: 16),
                Column(
                  children: [
                    Text("NIFTY BANK"),
                    Text("27000.50"),
                    Text("-120.25 (-0.44%)"),
                  ],
                )
              ],
            )),

            const Text("* Charts indicate 52 weeks trends"),
            const Divider(height: 12),
            Text("Fund"),
            Text('Rs 0.00')

           
            
            
          ],
        ),
      ),
    );
  }
}

