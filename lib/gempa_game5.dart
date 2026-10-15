import 'dart:async';

import 'package:flutter/material.dart';

import 'pause_game.dart';
import 'scoring_page.dart';

class GempaGame5Page extends StatefulWidget {
  final int health;
  final int userLevel;

  const GempaGame5Page({
    super.key,
    required this.health,
    required this.userLevel,
  });

  @override
  State<GempaGame5Page> createState() => _GempaGame5PageState();
}

class _GempaGame5PageState extends State<GempaGame5Page> {
  late int _health;
  final List<String?> _placedLetters = List.filled(10, null);
  final List<String> _availableTiles = [
    'R',
    'D',
    'N',
    'L',
    'B',
    'U',
    'G',
    'I',
    'N',
    'E',
  ];
  final List<bool> _tileUsed = List.filled(10, false);

  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _health = widget.health;
  }

  void _onTileTap(int index) {
    if (_tileUsed[index]) return;

    int emptySlot = _placedLetters.indexOf(null);
    if (emptySlot != -1) {
      setState(() {
        _placedLetters[emptySlot] = _availableTiles[index];
        _tileUsed[index] = true;
      });

      if (!_placedLetters.contains(null)) {
        String currentWord = _placedLetters.join();
        if (currentWord == 'BERLINDUNG') {
          setState(() {
            _isFinished = true;
          });

          Timer(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ScoringPage(
                    health: _health,
                    currentLevel: widget.userLevel,
                    isGempaGame: true,
                  ),
                ),
              );
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Kata belum tepat, silakan ulangi!',
                style: TextStyle(fontFamily: 'Titan One'),
              ),
              duration: Duration(milliseconds: 1000),
              backgroundColor: Colors.redAccent,
            ),
          );
        }
      }
    }
  }

  void _resetWord() {
    setState(() {
      _placedLetters.fillRange(0, 10, null);
      _tileUsed.fillRange(0, 10, false);
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
                    'Soal – 5',
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Susun huruf acak ini menjadi tindakan yang harus dilakukan ketika terjadi gempa!',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 16,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(10, (index) {
                        return Container(
                          width: 26,
                          height: 40,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white,
                                width: 3.5,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _placedLetters[index] ?? '',
                            style: const TextStyle(
                              fontFamily: 'Titan One',
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 14,
                        alignment: WrapAlignment.center,
                        children: List.generate(10, (index) {
                          if (_tileUsed[index]) {
                            return const SizedBox(width: 35, height: 35);
                          }
                          return GestureDetector(
                            onTap: () => _onTileTap(index),
                            child: Text(
                              _availableTiles[index],
                              style: const TextStyle(
                                fontFamily: 'Titan One',
                                fontSize: 34,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black38,
                                    offset: Offset(0, 3),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        TextButton(
                          onPressed: _resetWord,
                          child: const Text(
                            'Ulangi',
                            style: TextStyle(
                              fontFamily: 'Titan One',
                              fontSize: 18,
                              color: Color(0xFFFADA32),
                            ),
                          ),
                        ),
                      ],
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
