import 'package:flutter/material.dart';

import 'main_wrapper.dart';
import 'navbar.dart';

class LevelInfoPage extends StatelessWidget {
  final int userLevel;
  final String userName;

  const LevelInfoPage({super.key, this.userLevel = 1, this.userName = 'Asana'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background & Content
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Main_Background2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    const Spacer(),

                    // Level 1 & Level 2 Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildLevelCard(
                          levelNumber: 1,
                          emoji: '🌊',
                          isUnlocked: userLevel >= 1,
                        ),
                        _buildLevelCard(
                          levelNumber: 2,
                          emoji: '⛰️',
                          isUnlocked: userLevel >= 2,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Level 3 & Level 4 Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildLevelCard(
                          levelNumber: 3,
                          emoji: '🔥',
                          isUnlocked: userLevel >= 3,
                        ),
                        _buildLevelCard(
                          levelNumber: 4,
                          emoji: '🏚️',
                          isUnlocked: userLevel >= 4,
                        ),
                      ],
                    ),

                    const Spacer(),

                    // "KEMBALI" BUTTON (SHIFTED UPWARDS)
                    Transform.translate(
                      offset: const Offset(
                        0,
                        -12,
                      ), // Adjust this negative number to shift higher or lower
                      child: SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8,
                                offset: Offset(0, 4),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(28),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              } else {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MainWrapper(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFADA32),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 3.5,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Kembali',
                              style: TextStyle(
                                fontFamily: 'Titan One',
                                fontSize: 24,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 70),
                  ],
                ),
              ),
            ),
          ),

          // Persistent Top Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomTopNavBar(userLevel: userLevel, userName: userName),
          ),

          // Persistent Bottom Navbar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavBar(
              activeIndex: -1,
              onTabSelected: (index) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainWrapper(
                      userName: userName,
                      userLevel: userLevel,
                      initialIndex: index,
                    ),
                  ),
                  (route) => false,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard({
    required int levelNumber,
    required String emoji,
    required bool isUnlocked,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            color: isUnlocked
                ? const Color(0xFFB0F9FD)
                : const Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white, width: 3.5),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(emoji, style: const TextStyle(fontSize: 50)),
        ),
        const SizedBox(height: 8),
        Text(
          'level $levelNumber',
          style: const TextStyle(
            fontFamily: 'Titan One',
            fontSize: 22,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black38,
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
