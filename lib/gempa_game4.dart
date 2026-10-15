import 'dart:async';

import 'package:flutter/material.dart';

import 'gempa_game5.dart';
import 'pause_game.dart';
import 'scoring_page.dart';

class GempaGame4Page extends StatefulWidget {
  final int health;
  final int userLevel;

  const GempaGame4Page({
    super.key,
    required this.health,
    required this.userLevel,
  });

  @override
  State<GempaGame4Page> createState() => _GempaGame4PageState();
}

class _GempaGame4PageState extends State<GempaGame4Page> {
  late int _health;
  bool _isSwitchOff = false;
  bool _isTvOn = true;
  bool _isFinished = false;
  Timer? _tvTimer;

  @override
  void initState() {
    super.initState();
    _health = widget.health;
  }

  @override
  void dispose() {
    _tvTimer?.cancel();
    super.dispose();
  }

  void _onSaklarPressed() {
    if (_isSwitchOff || _isFinished) return;

    setState(() {
      _isSwitchOff = true;
      _isTvOn = false;
    });

    _tvTimer?.cancel();
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        setState(() {
          _isFinished = true;
        });

        Timer(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => GempaGame5Page(
                  health: _health,
                  userLevel: widget.userLevel,
                ),
              ),
            );
          }
        });
      }
    });
  }

  void _onTvPressed() {
    if (_isSwitchOff || !_isTvOn || _isFinished) return;

    setState(() {
      _isTvOn = false;
    });

    _tvTimer?.cancel();
    _tvTimer = Timer(const Duration(seconds: 3), () {
      if (mounted && !_isSwitchOff) {
        setState(() {
          _isTvOn = true;
          _health--;
        });

        if (_health <= 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ScoringPage(
                health: 0,
                currentLevel: widget.userLevel,
                isGempaGame: true,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Langkah tidak tepat! Matikan dari saklar listrik utama.',
                style: TextStyle(fontFamily: 'Titan One', fontSize: 12),
              ),
              duration: Duration(milliseconds: 1200),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    });
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
                      'Gempa sudah mereda. Tutup saklar agar tidak terjadi korsleting listrik!',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 17,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SAKLAR
                          GestureDetector(
                            onTap: _onSaklarPressed,
                            child: Transform.rotate(
                              angle: _isSwitchOff ? 3.14159 : 0,
                              child: Image.asset(
                                'assets/Gempa_Game/Saklar.png',
                                width: 70,
                                height: 130,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Text(
                                      '🔌',
                                      style: TextStyle(fontSize: 60),
                                    ),
                              ),
                            ),
                          ),

                          // TV
                          GestureDetector(
                            onTap: _onTvPressed,
                            child: Image.asset(
                              _isTvOn
                                  ? 'assets/Gempa_Game/TV_ON.png'
                                  : 'assets/Gempa_Game/TV_OFF.png',
                              width: 170,
                              height: 130,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Text(
                                    '📺',
                                    style: TextStyle(fontSize: 70),
                                  ),
                            ),
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
}
