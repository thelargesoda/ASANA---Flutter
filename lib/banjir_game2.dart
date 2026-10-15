import 'dart:async';

import 'package:flutter/material.dart';

import 'banjir_game3.dart';
import 'pause_game.dart';
import 'scoring_page.dart';

class BanjirGame2Page extends StatefulWidget {
  final int health;
  final int userLevel;

  const BanjirGame2Page({super.key, required this.health, this.userLevel = 1});

  @override
  State<BanjirGame2Page> createState() => _BanjirGame2PageState();
}

class _BanjirGame2PageState extends State<BanjirGame2Page> {
  late int _health;
  bool _isFinished = false;

  final List<String> _actions = [
    'Berjalan mengungsi ke tempat tinggi/posko.',
    'Mematikan aliran listrik.',
    'Mengambil Tas Siaga.',
  ];

  @override
  void initState() {
    super.initState();
    _health = widget.health;
  }

  void _submitAnswer() {
    bool isCorrect =
        _actions[0] == 'Mengambil Tas Siaga.' &&
        _actions[1] == 'Mematikan aliran listrik.' &&
        _actions[2] == 'Berjalan mengungsi ke tempat tinggi/posko.';

    if (isCorrect) {
      setState(() {
        _isFinished = true;
      });

      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  BanjirGame3Page(health: _health, userLevel: widget.userLevel),
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
              isBanjirGame: true,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Urutan tindakan kurang tepat! Coba lagi.',
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
                      'Susun urutan tindakan yang benar saat air mulai masuk ke rumah!',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 20,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                      child: ReorderableListView.builder(
                        itemCount: _actions.length,
                        onReorder: (oldIndex, newIndex) {
                          setState(() {
                            if (newIndex > oldIndex) newIndex -= 1;
                            final item = _actions.removeAt(oldIndex);
                            _actions.insert(newIndex, item);
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            key: ValueKey(_actions[index]),
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
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
                                  radius: 14,
                                  backgroundColor: Colors.white,
                                  child: Text(
                                    '${index + 1}.',
                                    style: const TextStyle(
                                      fontFamily: 'Titan One',
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _actions[index],
                                    style: const TextStyle(
                                      fontFamily: 'Titan One',
                                      fontSize: 13,
                                      color: Colors.black,
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
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
                        const SizedBox(width: 14),
                        Expanded(
                          child: SizedBox(
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _submitAnswer,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFADA32),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(28),
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 3.5,
                                  ),
                                ),
                                elevation: 4,
                              ),
                              child: const Text(
                                'Selesai',
                                style: TextStyle(
                                  fontFamily: 'Titan One',
                                  fontSize: 22,
                                  color: Colors.black,
                                ),
                              ),
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
