import 'package:flutter/material.dart';

import 'banjir_materi.dart';
import 'gempa_materi.dart';
import 'kebakaran_materi.dart';
import 'longsor_materi.dart';

class MateriOptionPage extends StatefulWidget {
  final int userLevel;

  const MateriOptionPage({super.key, this.userLevel = 1});

  @override
  State<MateriOptionPage> createState() => _MateriOptionPageState();
}

class _MateriOptionPageState extends State<MateriOptionPage> {
  int _currentIndex = 0;
  late PageController _pageController;

  final List<Map<String, dynamic>> _materiItems = [
    {'title': 'Banjir', 'emoji': '🌊', 'requiredLevel': 1},
    {'title': 'Longsor', 'emoji': '⛰️', 'requiredLevel': 2},
    {'title': 'Kebakaran', 'emoji': '🔥', 'requiredLevel': 3},
    {'title': 'Gempa Bumi', 'emoji': '🏚️', 'requiredLevel': 4},
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.72);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToSelectedMateri() {
    Widget targetPage;

    switch (_currentIndex) {
      case 0:
        targetPage = BanjirMateriPage(userLevel: widget.userLevel);
        break;
      case 1:
        targetPage = LongsorMateriPage(userLevel: widget.userLevel);
        break;
      case 2:
        targetPage = KebakaranMateriPage(userLevel: widget.userLevel);
        break;
      case 3:
        targetPage = GempaMateriPage(
          userLevel: widget.userLevel,
        ); // Updated here!
        break;
      default:
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => targetPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int requiredLevel = _materiItems[_currentIndex]['requiredLevel'];
    final bool isUnlocked = widget.userLevel >= requiredLevel;

    return Container(
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
          padding: const EdgeInsets.only(top: 80, bottom: 90),
          child: Column(
            children: [
              // Page Title
              const Text(
                'Pilih Materi',
                style: TextStyle(
                  fontFamily: 'Titan One',
                  fontSize: 32,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(0, 3),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // Horizontal Card Slider
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _materiItems.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final item = _materiItems[index];
                    final bool cardUnlocked =
                        widget.userLevel >= item['requiredLevel'];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 12,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFB0F9FD),
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(color: Colors.white, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1B729F)
                                  .withValues(alpha: 0.4),
                              blurRadius: 10,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Emoji / Lock Icon
                            Text(
                              cardUnlocked ? item['emoji'] : '🔒',
                              style: const TextStyle(fontSize: 85),
                            ),
                            const SizedBox(height: 24),
                            // Title Text
                            Text(
                              item['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Titan One',
                                fontSize: 28,
                                color: cardUnlocked
                                    ? const Color(0xFF1E88E5)
                                    : Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 30),

              // "Lanjutkan" Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: isUnlocked ? _navigateToSelectedMateri : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFADA32),
                      disabledBackgroundColor: const Color(0xFFD9D9D9),
                      elevation: isUnlocked ? 6 : 0,
                      shadowColor: Colors.black45,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: Colors.white, width: 4),
                      ),
                    ),
                    child: Text(
                      'Lanjutkan',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 26,
                        color: isUnlocked ? Colors.black : Colors.black38,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
