import 'package:flutter/material.dart';

class CustomTabbedView extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> views;

  const CustomTabbedView({
    super.key,
    required this.tabs,
    required this.views,
  }) : assert(tabs.length == views.length,
            'tabs and views must have the same length');

  @override
  State<CustomTabbedView> createState() => _CustomTabbedViewState();
}

class _CustomTabbedViewState extends State<CustomTabbedView> {
  int _selectedIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
  color: Colors.grey[300],
  width: double.infinity,
  child: SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: ConstrainedBox(
      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final title = entry.value;
          final isActive = index == _selectedIndex;
          return GestureDetector(
            onTap: () => _onTabTapped(index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            isActive ? FontWeight.bold : FontWeight.normal,
                        color: isActive
                            ? Colors.blue
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 3,
                    width: 24,
                    decoration: BoxDecoration(
                      color:
                          isActive ? Colors.blue : Colors.transparent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ),
  ),
)
,


    

        // ---------- Swipeable Pages ----------
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: widget.views,
          ),
        ),
      ],
    );
  }
}
