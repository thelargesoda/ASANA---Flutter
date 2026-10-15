import 'dart:async';

import 'package:flutter/material.dart';

import 'banjir_game2.dart';
import 'pause_game.dart';

class BanjirGamePage extends StatefulWidget {
  final int initialHealth;
  final int userLevel;

  const BanjirGamePage({super.key, this.initialHealth = 3, this.userLevel = 1});

  @override
  State<BanjirGamePage> createState() => _BanjirGamePageState();
}

class _BanjirGamePageState extends State<BanjirGamePage> {
  late int _health;
  final List<bool> _trashVisible = [true, true, true, true, true];
  int _remainingTrash = 5;
  bool _isFinished = false;

  final List<String> _trashAssets = [
    'assets/Botol.png',
    'assets/Trashed_Apple.png',
    'assets/Kaleng.png',
    'assets/Kaleng2.png',
    'assets/Plastik.png',
  ];

  @override
  void initState() {
    super.initState();
    _health = widget.initialHealth;
  }

  void _onTrashDropped(int index) {
    if (_trashVisible[index]) {
      setState(() {
        _trashVisible[index] = false;
        _remainingTrash--;
      });

      if (_remainingTrash == 0) {
        setState(() {
          _isFinished = true;
        });

        Timer(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BanjirGame2Page(
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

    final List<Offset> trashPositions = [
      const Offset(0.38, 0.22),
      const Offset(0.72, 0.22),
      const Offset(0.30, 0.38),
      const Offset(0.68, 0.40),
      const Offset(0.40, 0.54),
    ];

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
                    'Soal – 1',
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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double playWidth = constraints.maxWidth;
                  final double playHeight = constraints.maxHeight;

                  return Stack(
                    children: [
                      const Positioned(
                        top: 24,
                        left: 20,
                        right: 20,
                        child: Text(
                          'Masukkan sampah ke\ntempat yang seharusnya!',
                          style: TextStyle(
                            fontFamily: 'Titan One',
                            fontSize: 22,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                      ),
                      for (int i = 0; i < 5; i++)
                        if (_trashVisible[i])
                          Positioned(
                            left: trashPositions[i].dx * playWidth,
                            top: trashPositions[i].dy * playHeight,
                            child: Draggable<int>(
                              data: i,
                              feedback: Image.asset(
                                _trashAssets[i],
                                width: 70,
                                height: 70,
                              ),
                              childWhenDragging: const SizedBox.shrink(),
                              child: Image.asset(
                                _trashAssets[i],
                                width: 65,
                                height: 65,
                              ),
                            ),
                          ),
                      Positioned(
                        left: 20,
                        bottom: 24,
                        child: GestureDetector(
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
                            height: 60,
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
                      ),
                      Positioned(
                        right: 20,
                        bottom: 20,
                        child: DragTarget<int>(
                          onAcceptWithDetails: (details) =>
                              _onTrashDropped(details.data),
                          builder: (context, candidateData, rejectedData) {
                            return Image.asset(
                              'assets/TrashBin.png',
                              width: 140,
                              height: 160,
                              fit: BoxFit.contain,
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
