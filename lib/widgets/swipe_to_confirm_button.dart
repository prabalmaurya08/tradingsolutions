// lib/widgets/swipe_to_confirm_button.dart

import 'package:flutter/material.dart';

class SwipeToConfirmButton extends StatefulWidget {
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final IconData icon;
  final VoidCallback onConfirm;

  const SwipeToConfirmButton({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.icon,
    required this.onConfirm,
  });

  @override
  State<SwipeToConfirmButton> createState() => _SwipeToConfirmButtonState();
}

class _SwipeToConfirmButtonState extends State<SwipeToConfirmButton> {
  double _dragPosition = 0.0;
  bool _isConfirmed = false;
  final double _sliderWidth = 60.0;

  void _onDragUpdate(DragUpdateDetails details, double trackWidth) {
    if (_isConfirmed) return;

    setState(() {
      _dragPosition += details.delta.dx;
      // Clamp position
      _dragPosition = _dragPosition.clamp(0.0, trackWidth - _sliderWidth);
    });
  }

  void _onDragEnd(DragEndDetails details, double trackWidth) {
    if (_isConfirmed) return;

    final double endPosition = trackWidth - _sliderWidth;

    if (_dragPosition > endPosition * 0.9) {
      // Confirmed
      setState(() {
        _dragPosition = endPosition;
        _isConfirmed = true;
      });
      widget.onConfirm();
    } else {
      // Reset
      setState(() {
        _dragPosition = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final double trackWidth = constraints.maxWidth;
      final double trackHeight = 60.0;

      return Container(
        width: trackWidth,
        height: trackHeight,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(trackHeight / 2),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. The text
            Text(
              widget.text,
              style: TextStyle(
                color: widget.foregroundColor.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            // 2. The draggable slider
            Positioned(
              left: _dragPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (details) =>
                    _onDragUpdate(details, trackWidth),
                onHorizontalDragEnd: (details) =>
                    _onDragEnd(details, trackWidth),
                child: Container(
                  width: _sliderWidth,
                  height: trackHeight,
                  decoration: BoxDecoration(
                    color: widget.foregroundColor,
                    borderRadius: BorderRadius.circular(trackHeight / 2),
                  ),
                  child: Icon(
                    widget.icon,
                    color: widget.backgroundColor,
                    size: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}