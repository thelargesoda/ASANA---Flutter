import 'dart:async';

import 'package:flutter/material.dart';

import 'longsor_game3.dart';
import 'pause_game.dart';
import 'scoring_page.dart';

class LongsorGame2Page extends StatefulWidget {
  final int health;
  final int userLevel;

  const LongsorGame2Page({
    super.key,
    required this.health,
    required this.userLevel,
  });

  @override
  State<LongsorGame2Page> createState() => _LongsorGame2PageState();
}

class _LongsorGame2PageState extends State<LongsorGame2Page> {
  late int _health;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _health = widget.health;
  }

  void _handleChoice(bool isCorrect) {
    if (isCorrect) {
      setState(() {
        _isFinished = true;
      });

      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LongsorGame3Page(
                health: _health,
                userLevel: widget.userLevel,
              ),
            ),
          );
        }
      });
    } else {
      setState(() {
        _health--;
      });

      if (_health <= 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScoringPage(
              health: 0,
              currentLevel: widget.userLevel,
              isLongsorGame: true,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Pilihan kurang tepat! Coba lagi.',
              style: TextStyle(fontFamily: 'Titan One'),
            ),
            duration: Duration(milliseconds: 1000),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFinished) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Background_Sub.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: const Center(
            child: Text(
              'GOOD\nJOB!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Titan One',
                fontSize: 52,
                height: 1.1,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 6,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E88E5),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: const BoxDecoration(
                color: Color(0xFFB0F9FD),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Soal – 2',
                    style: TextStyle(
                      fontFamily: 'Titan One',
                      fontSize: 28,
                      color: Color(0xFF1E88E5),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      _health,
                      (index) => Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Image.asset(
                          'assets/Health.png',
                          width: 32,
                          height: 32,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 30,
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Kamu mendengar suara gemuruh keras dari atas bukit! Ke arah mana kamu harus lari?',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Scenario Image matching ratio
                            Image.asset(
                              'assets/Longsor_Game/Longsor_Scenario_Image.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text(
                                    '🖼️ Scenario Image',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Titan One',
                                    ),
                                  ),
                            ),
                            // Invisible clickable area for Left Road (Correct)
                            Positioned(
                              left: 0,
                              top: 200,
                              width: 100,
                              height: 60,
                              child: GestureDetector(
                                onTap: () => _handleChoice(true),
                                child: Container(color: Colors.transparent),
                              ),
                            ),
                            // Invisible clickable area for Right Road (Correct)
                            Positioned(
                              right: 0,
                              top: 200,
                              width: 100,
                              height: 60,
                              child: GestureDetector(
                                onTap: () => _handleChoice(true),
                                child: Container(color: Colors.transparent),
                              ),
                            ),
                            // Invisible clickable area for South/Below Road (Incorrect)
                            Positioned(
                              bottom: 0,
                              left: 120,
                              width: 100,
                              height: 120,
                              child: GestureDetector(
                                onTap: () => _handleChoice(false),
                                child: Container(color: Colors.transparent),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PauseGamePage(userLevel: widget.userLevel),
                          ),
                        );
                      },
                      child: Container(
                        width: 54,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFADA32),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white, width: 3),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.format_list_bulleted_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
