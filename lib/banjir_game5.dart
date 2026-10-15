import 'dart:async';

import 'package:flutter/material.dart';

import 'pause_game.dart';
import 'scoring_page.dart';

class BanjirGame5Page extends StatefulWidget {
  final int health;
  final int userLevel;

  const BanjirGame5Page({super.key, required this.health, this.userLevel = 1});

  @override
  State<BanjirGame5Page> createState() => _BanjirGame5PageState();
}

class _BanjirGame5PageState extends State<BanjirGame5Page> {
  late int _currentHealth;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _currentHealth = widget.health;
  }

  void _onOptionSelected(bool isCorrect) {
    if (isCorrect) {
      setState(() {
        _isFinished = true;
      });

      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ScoringPage(
                health: _currentHealth,
                currentLevel: widget.userLevel,
                isBanjirGame: true,
              ),
            ),
          );
        }
      });
    } else {
      setState(() {
        _currentHealth--;
      });

      if (_currentHealth <= 0) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ScoringPage(
              health: 0,
              currentLevel: widget.userLevel,
              isBanjirGame: true,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Jawaban kurang tepat. Coba lagi!',
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
                    'Soal – 5',
                    style: TextStyle(
                      fontFamily: 'Titan One',
                      fontSize: 28,
                      color: Color(0xFF1E88E5),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      _currentHealth,
                      (index) => Padding(
                        padding: const EdgeInsets.only(left: 6),
                        child: Image.asset(
                          'assets/Health.png',
                          width: 32,
                          height: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hujan turun sangat deras selama 3 hari tanpa henti. Apa tanda bahaya yang harus kamu waspadai?',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 18,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildOptionCard('A', 'Air sungai keruh dan meluap', true),
                    const SizedBox(height: 16),
                    _buildOptionCard('B', 'Langit cerah', false),
                    const SizedBox(height: 16),
                    _buildOptionCard('C', 'Angin sepoi-sepoi', false),
                    const Spacer(),
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

  Widget _buildOptionCard(String letter, String text, bool isCorrect) {
    return GestureDetector(
      onTap: () => _onOptionSelected(isCorrect),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFB0F9FD),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.white, width: 3),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white,
              child: Text(
                letter,
                style: const TextStyle(
                  fontFamily: 'Titan One',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Titan One',
                  fontSize: 13.5,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
