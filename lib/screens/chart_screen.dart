import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:math';


class TradingChartScreen extends StatefulWidget {
  @override
  _TradingChartScreenState createState() => _TradingChartScreenState();
}

class _TradingChartScreenState extends State<TradingChartScreen> {
  late ZoomPanBehavior _zoomPanBehavior;
  late CrosshairBehavior _crosshairBehavior;
  late TrackballBehavior _trackballBehavior;
  
  ChartType _selectedChartType = ChartType.Line;
  TimeFrame _selectedTimeFrame = TimeFrame.OneDay;
  bool _showVolume = true;
  bool _showEMA = true;
  bool _showSMA = false;
  bool _showBollingerBands = false;
  
  List<CandleData> _candleData = [];
  List<LineData> _lineData = [];
  List<VolumeData> _volumeData = [];
  
  @override
  void initState() {
    super.initState();
    _zoomPanBehavior = ZoomPanBehavior(
      enablePinching: true,
      enableDoubleTapZooming: true,
      enablePanning: true,
      enableMouseWheelZooming: true,
      enableSelectionZooming: true,
      selectionRectBorderColor: Colors.blue,
      selectionRectBorderWidth: 2,
      selectionRectColor: Colors.blue,
    );
    
    _crosshairBehavior = CrosshairBehavior(
      enable: true,
      lineType: CrosshairLineType.both,
      lineColor: Colors.grey,
      lineWidth: 1,
      activationMode: ActivationMode.singleTap,
    );
    
    _trackballBehavior = TrackballBehavior(
      enable: true,
      activationMode: ActivationMode.longPress,
      lineColor: Colors.blue,
      lineWidth: 1,
      tooltipSettings: InteractiveTooltip(
        enable: true,
        color: Colors.white,
        borderColor: Colors.blue,
        borderWidth: 1,
        textStyle: TextStyle(color: Colors.black87, fontSize: 12),
      ),
    );
    
    _generateData();
  }
  
  void _generateData() {
    Random random = Random();
    double basePrice = 45000.0;
    DateTime now = DateTime.now();
    
    _candleData.clear();
    _lineData.clear();
    _volumeData.clear();
    
    for (int i = 100; i >= 0; i--) {
      DateTime date = now.subtract(Duration(days: i));
      
      double open = basePrice + random.nextDouble() * 1000 - 500;
      double close = open + random.nextDouble() * 800 - 400;
      double high = max(open, close) + random.nextDouble() * 300;
      double low = min(open, close) - random.nextDouble() * 300;
      double volume = random.nextDouble() * 10000 + 5000;
      
      _candleData.add(CandleData(date, high, low, open, close));
      _lineData.add(LineData(date, close));
      _volumeData.add(VolumeData(date, volume, close > open));
      
      basePrice = close;
    }
  }
  
  void _changeTimeFrame(TimeFrame timeFrame) {
    setState(() {
      _selectedTimeFrame = timeFrame;
      _generateData();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 1,
        title: Row(
          children: [
            Text(
              'NIFTY 50',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '19,674.25',
                  style: TextStyle(fontSize: 14, color: Colors.green[700]),
                ),
                Text(
                  '+124.50 (+0.64%)',
                  style: TextStyle(fontSize: 10, color: Colors.green[700]),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Colors.black87),
            onPressed: () => _showSettingsPanel(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildToolbar(),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: _buildMainChart(),
                  ),
                  if (_showVolume)
                    Expanded(
                      flex: 2,
                      child: _buildVolumeChart(),
                    ),
                ],
              ),
            ),
          ),
          _buildBottomPanel(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Color(0xFF387ADF),
        child: Icon(Icons.refresh, color: Colors.white),
        onPressed: () {
          setState(() {
            _generateData();
          });
        },
      ),
    );
  }
  
  Widget _buildToolbar() {
    return Container(
      height: 50,
      color: Color(0xFFF5F5F5),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildChartTypeButton(ChartType.Line, Icons.show_chart),
            SizedBox(width: 4),
            _buildChartTypeButton(ChartType.Candle, Icons.candlestick_chart),
            SizedBox(width: 4),
            _buildChartTypeButton(ChartType.Area, Icons.area_chart),
            SizedBox(width: 12),
            Container(width: 1, height: 30, color: Colors.grey[400]),
            SizedBox(width: 12),
            _buildTimeFrameButton('1D', TimeFrame.OneDay),
            SizedBox(width: 4),
            _buildTimeFrameButton('1W', TimeFrame.OneWeek),
            SizedBox(width: 4),
            _buildTimeFrameButton('1M', TimeFrame.OneMonth),
            SizedBox(width: 4),
            _buildTimeFrameButton('3M', TimeFrame.ThreeMonths),
            SizedBox(width: 4),
            _buildTimeFrameButton('1Y', TimeFrame.OneYear),
            SizedBox(width: 12),
            PopupMenuButton<String>(
              icon: Icon(Icons.insights, color: Colors.black87),
              color: Colors.white,
              onSelected: (value) {
                setState(() {
                  if (value == 'EMA') _showEMA = !_showEMA;
                  if (value == 'SMA') _showSMA = !_showSMA;
                  if (value == 'BB') _showBollingerBands = !_showBollingerBands;
                });
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'EMA',
                  child: Row(
                    children: [
                      Icon(
                        _showEMA ? Icons.check_box : Icons.check_box_outline_blank,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 8),
                      Text('EMA (20)', style: TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'SMA',
                  child: Row(
                    children: [
                      Icon(
                        _showSMA ? Icons.check_box : Icons.check_box_outline_blank,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 8),
                      Text('SMA (50)', style: TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'BB',
                  child: Row(
                    children: [
                      Icon(
                        _showBollingerBands ? Icons.check_box : Icons.check_box_outline_blank,
                        color: Colors.purple,
                      ),
                      SizedBox(width: 8),
                      Text('Bollinger Bands', style: TextStyle(color: Colors.black87)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildChartTypeButton(ChartType type, IconData icon) {
    bool isSelected = _selectedChartType == type;
    return InkWell(
      onTap: () => setState(() => _selectedChartType = type),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF387ADF) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? Color(0xFF387ADF) : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          size: 20,
          color: isSelected ? Colors.white : Colors.black54,
        ),
      ),
    );
  }
  
  Widget _buildTimeFrameButton(String label, TimeFrame timeFrame) {
    bool isSelected = _selectedTimeFrame == timeFrame;
    return InkWell(
      onTap: () => _changeTimeFrame(timeFrame),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF387ADF) : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? Color(0xFF387ADF) : Colors.grey[300]!,
            width: 1,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black54,
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
  
  Widget _buildMainChart() {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
        majorGridLines: MajorGridLines(color: Colors.grey.withOpacity(0.2)),
        axisLine: AxisLine(color: Colors.grey.withOpacity(0.3)),
        labelStyle: TextStyle(color: Colors.black54, fontSize: 10),
      ),
      primaryYAxis: NumericAxis(
        opposedPosition: true,
        majorGridLines: MajorGridLines(color: Colors.grey.withOpacity(0.2)),
        axisLine: AxisLine(color: Colors.grey.withOpacity(0.3)),
        labelStyle: TextStyle(color: Colors.black54, fontSize: 10),
      ),
      zoomPanBehavior: _zoomPanBehavior,
      crosshairBehavior: _crosshairBehavior,
      trackballBehavior: _trackballBehavior,
      series: _buildMainChartSeries(),
    );
  }
  
  List<CartesianSeries<dynamic, dynamic>> _buildMainChartSeries() {
    List<CartesianSeries<dynamic, dynamic>> series = [];
    
    if (_selectedChartType == ChartType.Line) {
      series.add(FastLineSeries<LineData, DateTime>(
        dataSource: _lineData,
        xValueMapper: (LineData data, _) => data.date,
        yValueMapper: (LineData data, _) => data.price,
        color: Color(0xFF2962FF),
        width: 2,
      ));
    } else if (_selectedChartType == ChartType.Candle) {
      series.add(CandleSeries<CandleData, DateTime>(
        dataSource: _candleData,
        xValueMapper: (CandleData data, _) => data.date,
        lowValueMapper: (CandleData data, _) => data.low,
        highValueMapper: (CandleData data, _) => data.high,
        openValueMapper: (CandleData data, _) => data.open,
        closeValueMapper: (CandleData data, _) => data.close,
        bullColor: Color(0xFF26A69A),
        bearColor: Color(0xFFEF5350),
        enableSolidCandles: true,
      ));
    } else if (_selectedChartType == ChartType.Area) {
      series.add(AreaSeries<LineData, DateTime>(
        dataSource: _lineData,
        xValueMapper: (LineData data, _) => data.date,
        yValueMapper: (LineData data, _) => data.price,
        color: Color(0xFF2962FF).withOpacity(0.3),
        borderColor: Color(0xFF2962FF),
        borderWidth: 2,
        gradient: LinearGradient(
          colors: [
            Color(0xFF2962FF).withOpacity(0.5),
            Color(0xFF2962FF).withOpacity(0.0)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ));
    }
    
    if (_showEMA) {
      List<LineData> emaData = _calculateEMA(_lineData, 20);
      series.add(FastLineSeries<LineData, DateTime>(
        dataSource: emaData,
        xValueMapper: (LineData data, _) => data.date,
        yValueMapper: (LineData data, _) => data.price,
        color: Colors.blue,
        width: 1.5,
        dashArray: [5, 5],
      ));
    }
    
    if (_showSMA) {
      List<LineData> smaData = _calculateSMA(_lineData, 50);
      series.add(FastLineSeries<LineData, DateTime>(
        dataSource: smaData,
        xValueMapper: (LineData data, _) => data.date,
        yValueMapper: (LineData data, _) => data.price,
        color: Colors.orange,
        width: 1.5,
        dashArray: [5, 5],
      ));
    }
    
    return series;
  }
  
  Widget _buildVolumeChart() {
    return SfCartesianChart(
      backgroundColor: Colors.white,
      plotAreaBorderWidth: 0,
      primaryXAxis: DateTimeAxis(
        isVisible: false,
      ),
      primaryYAxis: NumericAxis(
        opposedPosition: true,
        majorGridLines: MajorGridLines(color: Colors.grey.withOpacity(0.2)),
        axisLine: AxisLine(color: Colors.grey.withOpacity(0.3)),
        labelStyle: TextStyle(color: Colors.black54, fontSize: 10),
      ),
      series: <CartesianSeries<dynamic, dynamic>>[
        ColumnSeries<VolumeData, DateTime>(
          dataSource: _volumeData,
          xValueMapper: (VolumeData data, _) => data.date,
          yValueMapper: (VolumeData data, _) => data.volume,
          pointColorMapper: (VolumeData data, _) => 
            data.isPositive ? Color(0xFF26A69A).withOpacity(0.5) : Color(0xFFEF5350).withOpacity(0.5),
          borderWidth: 0,
        ),
      ],
    );
  }
  
  Widget _buildBottomPanel() {
    return Container(
      height: 60,
      color: Color(0xFFF5F5F5),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: _buildBottomIndicator('Open', '19,550.00', Colors.black54)),
          Expanded(child: _buildBottomIndicator('High', '19,780.50', Colors.green[700]!)),
          Expanded(child: _buildBottomIndicator('Low', '19,490.25', Colors.red[700]!)),
          Expanded(child: _buildBottomIndicator('Close', '19,674.25', Colors.black87)),
          Expanded(child: _buildBottomIndicator('Vol', '245M', Colors.blue[700]!)),
        ],
      ),
    );
  }
  
  Widget _buildBottomIndicator(String label, String value, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 10),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
  
  void _showSettingsPanel() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chart Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            SwitchListTile(
              title: Text('Show Volume', style: TextStyle(color: Colors.black87)),
              value: _showVolume,
              onChanged: (value) {
                Navigator.pop(context);
                setState(() => _showVolume = value);
              },
              activeColor: Color(0xFF387ADF),
            ),
            SwitchListTile(
              title: Text('Show EMA (20)', style: TextStyle(color: Colors.black87)),
              value: _showEMA,
              onChanged: (value) {
                Navigator.pop(context);
                setState(() => _showEMA = value);
              },
              activeColor: Color(0xFF387ADF),
            ),
            SwitchListTile(
              title: Text('Show SMA (50)', style: TextStyle(color: Colors.black87)),
              value: _showSMA,
              onChanged: (value) {
                Navigator.pop(context);
                setState(() => _showSMA = value);
              },
              activeColor: Color(0xFF387ADF),
            ),
          ],
        ),
      ),
    );
  }
  
  List<LineData> _calculateEMA(List<LineData> data, int period) {
    List<LineData> emaData = [];
    double multiplier = 2.0 / (period + 1);
    double ema = data.take(period).map((e) => e.price).reduce((a, b) => a + b) / period;
    
    for (int i = period; i < data.length; i++) {
      ema = (data[i].price - ema) * multiplier + ema;
      emaData.add(LineData(data[i].date, ema));
    }
    return emaData;
  }
  
  List<LineData> _calculateSMA(List<LineData> data, int period) {
    List<LineData> smaData = [];
    for (int i = period; i < data.length; i++) {
      double sum = 0;
      for (int j = 0; j < period; j++) {
        sum += data[i - j].price;
      }
      smaData.add(LineData(data[i].date, sum / period));
    }
    return smaData;
  }
}

enum ChartType { Line, Candle, Area }
enum TimeFrame { OneDay, OneWeek, OneMonth, ThreeMonths, OneYear }

class CandleData {
  final DateTime date;
  final double high;
  final double low;
  final double open;
  final double close;
  
  CandleData(this.date, this.high, this.low, this.open, this.close);
}

class LineData {
  final DateTime date;
  final double price;
  
  LineData(this.date, this.price);
}

class VolumeData {
  final DateTime date;
  final double volume;
  final bool isPositive;
  
  VolumeData(this.date, this.volume, this.isPositive);
}