import 'dart:async';

import 'package:flutter/material.dart';

import 'gempa_game3.dart';
import 'pause_game.dart';

class GempaGame2Page extends StatefulWidget {
  final int health;
  final int userLevel;

  const GempaGame2Page({
    super.key,
    required this.health,
    required this.userLevel,
  });

  @override
  State<GempaGame2Page> createState() => _GempaGame2PageState();
}

class _GempaGame2PageState extends State<GempaGame2Page> {
  late int _health;
  bool _isFinished = false;

  final Map<String, bool> _vasePlaced = {
    'yellow': false,
    'blue': false,
    'pink': false,
  };

  @override
  void initState() {
    super.initState();
    _health = widget.health;
  }

  void _onVaseDropped(String vaseKey) {
    setState(() {
      _vasePlaced[vaseKey] = true;
    });

    if (_vasePlaced.values.every((placed) => placed)) {
      setState(() {
        _isFinished = true;
      });

      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  GempaGame3Page(health: _health, userLevel: widget.userLevel),
            ),
          );
        }
      });
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Gempa akan datang! Seret vas bunga kaca menjauh dari tepi meja ke lantai yang aman.',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 15,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final double playWidth = constraints.maxWidth;
                          final double playHeight = constraints.maxHeight;

                          return Stack(
                            children: [
                              // Background Environment
                              Positioned.fill(
                                child: Image.asset(
                                  'assets/Gempa_Game/Environtment_1.png',
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(color: Colors.black12),
                                ),
                              ),

                              // Red Dashed Drop Area on Floor
                              Positioned(
                                left: playWidth * 0.05,
                                bottom: playHeight * 0.15,
                                width: playWidth * 0.55,
                                height: playHeight * 0.32,
                                child: DragTarget<String>(
                                  onAcceptWithDetails: (details) =>
                                      _onVaseDropped(details.data),
                                  builder: (context, candidateData, rejectedData) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.redAccent.withOpacity(
                                            0.7,
                                          ),
                                          width: 2.5,
                                        ),
                                        color: candidateData.isNotEmpty
                                            ? Colors.red.withOpacity(0.15)
                                            : Colors.transparent,
                                      ),
                                      child: Wrap(
                                        spacing: 10,
                                        alignment: WrapAlignment.center,
                                        runAlignment: WrapAlignment.center,
                                        children: [
                                          if (_vasePlaced['yellow']!)
                                            Image.asset(
                                              'assets/Gempa_Game/Yellow_Vase.png',
                                              width: 45,
                                              height: 45,
                                            ),
                                          if (_vasePlaced['blue']!)
                                            Image.asset(
                                              'assets/Gempa_Game/Blue_Vase.png',
                                              width: 45,
                                              height: 45,
                                            ),
                                          if (_vasePlaced['pink']!)
                                            Image.asset(
                                              'assets/Gempa_Game/Pink_Vase.png',
                                              width: 45,
                                              height: 45,
                                            ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),

                              // Yellow Vase (on desk)
                              if (!_vasePlaced['yellow']!)
                                Positioned(
                                  left: playWidth * 0.15,
                                  top: playHeight * 0.33,
                                  child: Draggable<String>(
                                    data: 'yellow',
                                    feedback: Image.asset(
                                      'assets/Gempa_Game/Yellow_Vase.png',
                                      width: 55,
                                      height: 55,
                                    ),
                                    childWhenDragging: const SizedBox.shrink(),
                                    child: Image.asset(
                                      'assets/Gempa_Game/Yellow_Vase.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                ),

                              // Blue Vase (on cupboard top)
                              if (!_vasePlaced['blue']!)
                                Positioned(
                                  right: playWidth * 0.22,
                                  top: playHeight * 0.22,
                                  child: Draggable<String>(
                                    data: 'blue',
                                    feedback: Image.asset(
                                      'assets/Gempa_Game/Blue_Vase.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                    childWhenDragging: const SizedBox.shrink(),
                                    child: Image.asset(
                                      'assets/Gempa_Game/Blue_Vase.png',
                                      width: 45,
                                      height: 45,
                                    ),
                                  ),
                                ),

                              // Pink Vase (on cupboard top)
                              if (!_vasePlaced['pink']!)
                                Positioned(
                                  right: playWidth * 0.10,
                                  top: playHeight * 0.25,
                                  child: Draggable<String>(
                                    data: 'pink',
                                    feedback: Image.asset(
                                      'assets/Gempa_Game/Pink_Vase.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                    childWhenDragging: const SizedBox.shrink(),
                                    child: Image.asset(
                                      'assets/Gempa_Game/Pink_Vase.png',
                                      width: 45,
                                      height: 45,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
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
