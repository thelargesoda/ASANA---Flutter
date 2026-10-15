import 'dart:async';

import 'package:flutter/material.dart';

import 'longsor_game5.dart';
import 'pause_game.dart';
import 'scoring_page.dart';

class LongsorGame4Page extends StatefulWidget {
  final int health;
  final int userLevel;

  const LongsorGame4Page({
    super.key,
    required this.health,
    required this.userLevel,
  });

  @override
  State<LongsorGame4Page> createState() => _LongsorGame4PageState();
}

class _LongsorGame4PageState extends State<LongsorGame4Page> {
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
              builder: (context) => LongsorGame5Page(
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
                    'Soal – 4',
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
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hujan turun terus-menerus. Mana tanda alam yang menunjukkan tanah mau longsor?',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildRoadOption(
                            'assets/Longsor_Game/Jalan_Pelangi.png',
                            true,
                          ),
                          const SizedBox(height: 24),
                          _buildRoadOption(
                            'assets/Longsor_Game/Jalan_Broken.png',
                            false,
                          ),
                        ],
                      ),
                    ),
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

  Widget _buildRoadOption(String assetPath, bool isCorrect) {
    return GestureDetector(
      onTap: () => _handleChoice(isCorrect),
      child: Image.asset(
        assetPath,
        width: double.infinity,
        height: 115,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Text('🛣️', style: TextStyle(fontSize: 50)),
      ),
    );
  }
}
