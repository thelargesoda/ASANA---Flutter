import 'dart:async';

import 'package:flutter/material.dart';

import 'kebakaran_game5.dart';
import 'pause_game.dart';
import 'scoring_page.dart';

class KebakaranGame4Page extends StatefulWidget {
  final int health;
  final int userLevel;

  const KebakaranGame4Page({
    super.key,
    required this.health,
    required this.userLevel,
  });

  @override
  State<KebakaranGame4Page> createState() => _KebakaranGame4PageState();
}

class _KebakaranGame4PageState extends State<KebakaranGame4Page> {
  late int _health;
  bool _isBucketVisible = true;
  bool _isTowelWet = false;
  bool _isPanExtinguished = false;
  bool _isFinished = false;

  @override
  void initState() {
    super.initState();
    _health = widget.health;
  }

  void _wrongAction() {
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
            isKebakaranGame: true,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Langkah kurang tepat! Basahi handuk dengan air terlebih dahulu.',
            style: TextStyle(fontFamily: 'Titan One', fontSize: 12),
          ),
          duration: Duration(milliseconds: 1200),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  void _onTowelDroppedOnBucket() {
    setState(() {
      _isBucketVisible = false;
      _isTowelWet = true;
    });
  }

  void _onTowelDroppedOnPan() {
    if (_isTowelWet) {
      setState(() {
        _isPanExtinguished = true;
        _isFinished = true;
      });

      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => KebakaranGame5Page(
                health: _health,
                userLevel: widget.userLevel,
              ),
            ),
          );
        }
      });
    } else {
      _wrongAction();
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
                      'Wajan di dapur terbakar, lakukan langkah-langkah memadamkan api dengan benar!',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 17,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: DragTarget<String>(
                        onAccept: (data) => _onTowelDroppedOnPan(),
                        builder: (context, candidateData, rejectedData) {
                          return Image.asset(
                            _isPanExtinguished
                                ? 'assets/Kebakaran_Game/Pan_Normal.png'
                                : 'assets/Kebakaran_Game/Pan_Fire.png',
                            width: 140,
                            height: 120,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Text(
                                  '🍳',
                                  style: TextStyle(fontSize: 70),
                                ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (_isBucketVisible)
                          DragTarget<String>(
                            onAccept: (data) {
                              if (data == 'towel') _onTowelDroppedOnBucket();
                            },
                            builder: (context, candidateData, rejectedData) {
                              return Image.asset(
                                'assets/Kebakaran_Game/Water_Bucket.png',
                                width: 90,
                                height: 90,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Text(
                                      '🪣',
                                      style: TextStyle(fontSize: 50),
                                    ),
                              );
                            },
                          ),
                        Draggable<String>(
                          data: 'towel',
                          feedback: Image.asset(
                            'assets/Kebakaran_Game/Towel.png',
                            width: 80,
                            height: 80,
                          ),
                          childWhenDragging: const SizedBox(
                            width: 80,
                            height: 80,
                          ),
                          child: Image.asset(
                            'assets/Kebakaran_Game/Towel.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) =>
                                const Text(
                                  '🧺',
                                  style: TextStyle(fontSize: 50),
                                ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
