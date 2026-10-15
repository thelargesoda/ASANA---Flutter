import 'package:flutter/material.dart';

import 'level_info.dart';
import 'main.dart';

// =============================================================================
// FIXED TOP NAVBAR
// =============================================================================
class CustomTopNavBar extends StatelessWidget {
  final int userLevel;
  final String userName;

  const CustomTopNavBar({
    super.key,
    this.userLevel = 1,
    this.userName = 'Asana',
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Align(
          alignment: Alignment.topCenter,
          child: FractionallySizedBox(
            widthFactor: 0.70,
            child: Container(
              height: 58,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: const Color(0xFFB0F9FD),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white, width: 3.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // --- LEFT SIDE: Avatar with Logout Popup + Username ---
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PopupMenuButton<String>(
                        offset: const Offset(0, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: const BorderSide(color: Colors.white, width: 3),
                        ),
                        color: const Color(0xFFB0F9FD),
                        elevation: 8,
                        onSelected: (value) {
                          if (value == 'logout') {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const WelcomePage(),
                              ),
                              (route) => false,
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem<String>(
                            value: 'logout',
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Keluar Akun',
                                  style: TextStyle(
                                    fontFamily: 'Titan One',
                                    fontSize: 15,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            '🐼',
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),

                      // Username Text
                      Text(
                        userName,
                        style: const TextStyle(
                          fontFamily: 'Titan One',
                          fontSize: 20,
                          color: Color(0xFF1E88E5),
                        ),
                      ),
                    ],
                  ),

                  // --- RIGHT SIDE: Level Badge ---
                  GestureDetector(
                    onTap: () {
                      // Prevent route stacking if already inside LevelInfoPage
                      if (context
                              .findAncestorWidgetOfExactType<LevelInfoPage>() !=
                          null) {
                        return;
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LevelInfoPage(
                            userLevel: userLevel,
                            userName: userName,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFADA32),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Text(
                        'Level $userLevel',
                        style: const TextStyle(
                          fontFamily: 'Titan One',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// FIXED BOTTOM NAVBAR
// =============================================================================
class CustomBottomNavBar extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int> onTabSelected;

  const CustomBottomNavBar({
    super.key,
    required this.activeIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFB0F9FD),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              index: 0,
              activeIcon: 'assets/icon/HomePageIconOn.png',
              inactiveIcon: 'assets/icon/HomePageIconOff.png',
            ),
            _buildNavItem(
              index: 1,
              activeIcon: 'assets/icon/MateriIconOn.png',
              inactiveIcon: 'assets/icon/MateriIconOff.png',
            ),
            _buildNavItem(
              index: 2,
              activeIcon: 'assets/icon/AboutIconOn.png',
              inactiveIcon: 'assets/icon/AboutIconOff.png',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String activeIcon,
    required String inactiveIcon,
  }) {
    final bool isActive = activeIndex == index;

    return GestureDetector(
      onTap: () {
        // Only trigger tab selection if not already on the selected tab
        if (!isActive) {
          onTabSelected(index);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Image.asset(
        isActive ? activeIcon : inactiveIcon,
        width: 56,
        height: 56,
        errorBuilder: (context, error, stackTrace) => Icon(
          isActive ? Icons.stars : Icons.stars_outlined,
          size: 40,
          color: Colors.black54,
        ),
      ),
    );
  }
}
