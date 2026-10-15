import 'dart:async';

import 'package:flutter/material.dart';

import 'banjir_game4.dart';
import 'pause_game.dart';
import 'scoring_page.dart';

class BanjirGame3Page extends StatefulWidget {
  final int health;
  final int userLevel;

  const BanjirGame3Page({super.key, required this.health, this.userLevel = 1});

  @override
  State<BanjirGame3Page> createState() => _BanjirGame3PageState();
}

class _BanjirGame3PageState extends State<BanjirGame3Page> {
  late int _currentHealth;
  int _correctItemsInBag = 0;
  bool _isFinished = false;

  final Map<String, bool> _itemState = {
    'Peluit': true,
    'Eskrim': true,
    'Robot': true,
    'Senter': true,
  };

  @override
  void initState() {
    super.initState();
    _currentHealth = widget.health;
  }

  void _handleItemSelect(String itemName, bool isCorrect) {
    if (!_itemState[itemName]!) return;

    if (isCorrect) {
      setState(() {
        _itemState[itemName] = false;
        _correctItemsInBag++;
      });

      if (_correctItemsInBag >= 2) {
        setState(() {
          _isFinished = true;
        });

        Timer(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => BanjirGame4Page(
                  health: _currentHealth,
                  userLevel: widget.userLevel,
                ),
              ),
            );
          }
        });
      }
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
              'Barang ini tidak wajib di Tas Siaga Bencana!',
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
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Pilih 2 barang wajib dimasukkan ke dalam Tas Siaga Bencana!',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 20,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 1.3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        children: [
                          _buildItemTile('Peluit', 'assets/Peluit.png', true),
                          _buildItemTile('Eskrim', 'assets/Eskrim.png', false),
                          _buildItemTile('Robot', 'assets/Robot.png', false),
                          _buildItemTile('Senter', 'assets/Senter.png', true),
                        ],
                      ),
                    ),
                    DragTarget<String>(
                      onAcceptWithDetails: (details) {
                        final bool isCorrect =
                            details.data == 'Peluit' ||
                            details.data == 'Senter';
                        _handleItemSelect(details.data, isCorrect);
                      },
                      builder: (context, candidateData, rejectedData) {
                        return Image.asset(
                          'assets/Tas.png',
                          width: 130,
                          height: 130,
                          fit: BoxFit.contain,
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemTile(String name, String assetPath, bool isCorrect) {
    if (!_itemState[name]!) {
      return const SizedBox.shrink();
    }

    return Draggable<String>(
      data: name,
      feedback: Image.asset(assetPath, width: 90, height: 90),
      childWhenDragging: const SizedBox.shrink(),
      child: GestureDetector(
        onTap: () => _handleItemSelect(name, isCorrect),
        child: Image.asset(assetPath, fit: BoxFit.contain),
      ),
    );
  }
}
