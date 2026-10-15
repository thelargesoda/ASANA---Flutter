import 'package:flutter/material.dart';

import 'about.dart';
import 'homepage.dart';
import 'materi_option.dart';
import 'navbar.dart';

class MainWrapper extends StatefulWidget {
  final String userName;
  final int userLevel;
  final int initialIndex;

  const MainWrapper({
    super.key,
    this.userName = 'Asana',
    this.userLevel = 1,
    this.initialIndex = 0,
  });

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  late int _selectedIndex;
  late int _userLevel;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _userLevel = widget.userLevel;
  }

  @override
  void didUpdateWidget(covariant MainWrapper oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Automatically sync state when user level changes (e.g., returning from ScoringPage)
    if (widget.userLevel != oldWidget.userLevel) {
      setState(() {
        _userLevel = widget.userLevel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(
        userLevel: _userLevel,
        onMateriPressed: () {
          setState(() {
            _selectedIndex = 1; // Switches tab to Materi Option
          });
        },
      ),
      MateriOptionPage(userLevel: _userLevel),
      AboutPage(
        currentLevel: _userLevel,
        onLevelChanged: (newLevel) {
          setState(() {
            _userLevel =
                newLevel; // Updates level state globally across navbar & app
          });
        },
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // 1. ACTIVE PAGE CONTENT
          IndexedStack(index: _selectedIndex, children: pages),

          // 2. PERSISTENT TOP NAVBAR
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomTopNavBar(
              userName: widget.userName,
              userLevel: _userLevel,
            ),
          ),

          // 3. PERSISTENT BOTTOM NAVBAR
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavBar(
              activeIndex: _selectedIndex,
              onTabSelected: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
