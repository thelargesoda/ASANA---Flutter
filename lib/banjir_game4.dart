import 'dart:async';

import 'package:flutter/material.dart';

import 'banjir_game5.dart';
import 'pause_game.dart';

class BanjirGame4Page extends StatefulWidget {
  final int health;
  final int userLevel;

  const BanjirGame4Page({super.key, required this.health, this.userLevel = 1});

  @override
  State<BanjirGame4Page> createState() => _BanjirGame4PageState();
}

class _BanjirGame4PageState extends State<BanjirGame4Page> {
  late int _health;
  final List<String?> _placedLetters = List.filled(6, null);
  final List<String> _availableTiles = ['S', 'M', 'A', 'H', 'A', 'P'];
  final List<bool> _tileUsed = List.filled(6, false);

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
        if (currentWord == 'SAMPAH') {
          setState(() {
            _isFinished = true;
          });

          Timer(const Duration(seconds: 2), () {
            if (mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BanjirGame5Page(
                    health: _health,
                    userLevel: widget.userLevel,
                  ),
                ),
              );
            }
          });
        }
      }
    }
  }

  void _resetWord() {
    setState(() {
      _placedLetters.fillRange(0, 6, null);
      _tileUsed.fillRange(0, 6, false);
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
                      'Salah satu penyebab terjadinya banjir',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 42,
                          height: 52,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.white, width: 4),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            _placedLetters[index] ?? '',
                            style: const TextStyle(
                              fontFamily: 'Titan One',
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: List.generate(6, (index) {
                          if (_tileUsed[index]) {
                            return const SizedBox(width: 50, height: 50);
                          }
                          return GestureDetector(
                            onTap: () => _onTileTap(index),
                            child: Text(
                              _availableTiles[index],
                              style: const TextStyle(
                                fontFamily: 'Titan One',
                                fontSize: 44,
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
