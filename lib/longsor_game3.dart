import 'dart:async';

import 'package:flutter/material.dart';

import 'longsor_game4.dart';
import 'pause_game.dart';
import 'scoring_page.dart';

class LongsorGame3Page extends StatefulWidget {
  final int health;
  final int userLevel;

  const LongsorGame3Page({
    super.key,
    required this.health,
    required this.userLevel,
  });

  @override
  State<LongsorGame3Page> createState() => _LongsorGame3PageState();
}

class _LongsorGame3PageState extends State<LongsorGame3Page> {
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
              builder: (context) => LongsorGame4Page(
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
                    'Soal – 3',
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
                      'Tanaman apa yang bisa membantu menahan tanah di bukit agar tidak mudah longsor?',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 17,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildPlantOption(
                                'assets/Longsor_Game/Pohon.png',
                                true,
                                110,
                                110,
                              ),
                              _buildPlantOption(
                                'assets/Longsor_Game/Bunga.png',
                                false,
                                90,
                                90,
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _buildPlantOption(
                            'assets/Longsor_Game/Cabe.png',
                            false,
                            100,
                            100,
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

  Widget _buildPlantOption(
    String assetPath,
    bool isCorrect,
    double width,
    double height,
  ) {
    return GestureDetector(
      onTap: () => _handleChoice(isCorrect),
      child: Image.asset(
        assetPath,
        width: width,
        height: height,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) =>
            const Text('🌿', style: TextStyle(fontSize: 40)),
      ),
    );
  }
}
