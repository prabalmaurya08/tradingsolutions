import 'package:flutter/material.dart';

class TradingOrderScreen extends StatefulWidget {
  final bool isBuy;
  final String stockName;
  final String bsePrice;
  final String nsePrice;

  TradingOrderScreen({
    this.isBuy = true,
    this.stockName = 'TCS',
    this.bsePrice = '3,057.80',
    this.nsePrice = '3,058.00',
  });

  @override
  _TradingOrderScreenState createState() => _TradingOrderScreenState();
}

class _TradingOrderScreenState extends State<TradingOrderScreen> {
  String selectedExchange = 'BSE';
  String selectedOrderType = 'Regular';
  String selectedDuration = 'Longterm';
  bool isStoplossEnabled = false;
  bool isGTTEnabled = false;
  bool isMarketProtectionEnabled = false;
  bool showAdvanced = false;
  
  TextEditingController quantityController = TextEditingController(text: '1');
  TextEditingController limitController = TextEditingController(text: '3057.8');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.stockName,
          style: TextStyle(color: Colors.black87, fontSize: 18),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Exchange Selection
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        _buildExchangeOption('BSE', widget.bsePrice),
                        SizedBox(width: 24),
                        _buildExchangeOption('NSE', widget.nsePrice),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Order Type Tabs
                  Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          _buildOrderTypeTab('Regular'),
                          _buildOrderTypeTab('MTF'),
                          _buildOrderTypeTab('AMO'),
                          _buildOrderTypeTab('Iceberg'),
                          _buildOrderTypeTab('Cover'),
                        ],
                      ),
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Main Form
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Quantity
                        Text(
                          'Quantity',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildInputField(quantityController, widget.isBuy),
                        
                        SizedBox(height: 24),
                        
                        // Limit
                        Row(
                          children: [
                            Text(
                              'Limit',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.edit,
                              size: 18,
                              color: widget.isBuy ? Colors.blue : Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        _buildInputField(limitController, widget.isBuy),
                        
                        SizedBox(height: 24),
                        
                        // Duration Selection
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildDurationOption('Intraday'),
                            SizedBox(width: 32),
                            _buildDurationOption('Longterm'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Stoploss Toggle
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Stoploss',
                              style: TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.info_outline, size: 18, color: Colors.blue),
                          ],
                        ),
                        Switch(
                          value: isStoplossEnabled,
                          onChanged: (value) => setState(() => isStoplossEnabled = value),
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  
                  if (selectedOrderType == 'Regular') ...[
                    // GTT Toggle
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'GTT',
                                style: TextStyle(fontSize: 16, color: Colors.black87),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.info_outline, size: 18, color: Colors.blue),
                            ],
                          ),
                          Switch(
                            value: isGTTEnabled,
                            onChanged: (value) => setState(() => isGTTEnabled = value),
                            activeColor: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ],
                  
                  // Market Protection Toggle
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Market protection',
                              style: TextStyle(fontSize: 16, color: Colors.black87),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.info_outline, size: 18, color: Colors.blue),
                          ],
                        ),
                        Switch(
                          value: isMarketProtectionEnabled,
                          onChanged: (value) => setState(() => isMarketProtectionEnabled = value),
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 8),
                  
                  // Help and Advanced
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Help',
                          style: TextStyle(
                            fontSize: 16,
                            color: widget.isBuy ? Colors.blue : Colors.red,
                          ),
                        ),
                        InkWell(
                          onTap: () => setState(() => showAdvanced = !showAdvanced),
                          child: Row(
                            children: [
                              Text(
                                'Advanced',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: widget.isBuy ? Colors.blue : Colors.red,
                                ),
                              ),
                              Icon(
                                showAdvanced ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                color: widget.isBuy ? Colors.blue : Colors.red,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  if (showAdvanced)
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text(
                          'Less',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  
                  SizedBox(height: 80),
                ],
              ),
            ),
          ),
          
          // Bottom Bar with Amount and Swipe Button
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Amount',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '₹${widget.isBuy ? '3,057.80' : '0.00'}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.isBuy ? Colors.blue : Colors.black87,
                          ),
                        ),
                        Text(
                          ' + ',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        Text(
                          '₹${widget.isBuy ? '3.20' : '0.26'}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.isBuy ? Colors.blue : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Avail.',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '₹10.00',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.refresh, color: Colors.grey[600]),
                  ],
                ),
                SizedBox(height: 16),
                _buildSwipeButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExchangeOption(String exchange, String price) {
    bool isSelected = selectedExchange == exchange;
    return InkWell(
      onTap: () => setState(() => selectedExchange = exchange),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected 
                  ? (widget.isBuy ? Colors.blue : Colors.red) 
                  : Colors.grey[400]!,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isBuy ? Colors.blue : Colors.red,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8),
          Text(
            '$exchange ₹$price',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderTypeTab(String type) {
    bool isSelected = selectedOrderType == type;
    return Padding(
      padding: EdgeInsets.only(right: 24),
      child: InkWell(
        onTap: () => setState(() => selectedOrderType = type),
        child: Column(
          children: [
            Text(
              type,
              style: TextStyle(
                fontSize: 15,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected 
                  ? (widget.isBuy ? Colors.blue : Colors.red)
                  : Colors.grey[600],
              ),
            ),
            SizedBox(height: 4),
            if (isSelected)
              Container(
                height: 2,
                width: 40,
                color: widget.isBuy ? Colors.blue : Colors.red,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, bool isBuy) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
              keyboardType: TextInputType.number,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border(left: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.arrow_drop_up,
                  color: isBuy ? Colors.blue : Colors.red,
                  size: 24,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: isBuy ? Colors.blue : Colors.red,
                  size: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationOption(String duration) {
    bool isSelected = selectedDuration == duration;
    return InkWell(
      onTap: () => setState(() => selectedDuration = duration),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected 
                  ? (widget.isBuy ? Colors.blue : Colors.red) 
                  : Colors.grey[400]!,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isBuy ? Colors.blue : Colors.red,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8),
          Text(
            duration,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwipeButton() {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: widget.isBuy ? Colors.blue : Colors.red,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              widget.isBuy ? 'SWIPE TO BUY' : 'SWIPE TO SELL',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Positioned(
            left: 4,
            top: 4,
            bottom: 4,
            child: Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_right,
                color: widget.isBuy ? Colors.blue : Colors.red,
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Example Usage:
class BuyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TradingOrderScreen(
      isBuy: true,
      stockName: 'TCS',
      bsePrice: '3,057.80',
      nsePrice: '3,058.00',
    );
  }
}

class SellScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TradingOrderScreen(
      isBuy: false,
      stockName: 'ONGC',
      bsePrice: '255.45',
      nsePrice: '255.37',
    );
  }
}