import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main_wrapper.dart';

class ScoringPage extends StatefulWidget {
  final int health;
  final int currentLevel;
  final bool isBanjirGame;
  final bool isKebakaranGame;
  final bool isLongsorGame;
  final bool isGempaGame;

  const ScoringPage({
    super.key,
    this.health = 3,
    this.currentLevel = 1,
    this.isBanjirGame = false,
    this.isKebakaranGame = false,
    this.isLongsorGame = false,
    this.isGempaGame = false,
  });

  @override
  State<ScoringPage> createState() => _ScoringPageState();
}

class _ScoringPageState extends State<ScoringPage> {
  late int _resolvedLevel;

  @override
  void initState() {
    super.initState();
    _resolvedLevel = widget.currentLevel;
    _saveGameStars();

    if (widget.health > 0) {
      if (widget.isBanjirGame) {
        if (_resolvedLevel < 2) _resolvedLevel = 2;
      } else if (widget.isLongsorGame) {
        if (_resolvedLevel < 3) _resolvedLevel = 3;
      } else if (widget.isKebakaranGame) {
        if (_resolvedLevel < 4) _resolvedLevel = 4;
      } else if (widget.isGempaGame) {
        if (_resolvedLevel < 4) _resolvedLevel = 4;
      }
    }
  }

  Future<void> _saveGameStars() async {
    final prefs = await SharedPreferences.getInstance();
    int earnedStars = widget.health > 0 ? widget.health : 0;

    if (widget.isBanjirGame) {
      int current = prefs.getInt('banjir_stars') ?? 0;
      if (earnedStars > current) prefs.setInt('banjir_stars', earnedStars);
    } else if (widget.isLongsorGame) {
      int current = prefs.getInt('longsor_stars') ?? 0;
      if (earnedStars > current) prefs.setInt('longsor_stars', earnedStars);
    } else if (widget.isKebakaranGame) {
      int current = prefs.getInt('kebakaran_stars') ?? 0;
      if (earnedStars > current) prefs.setInt('kebakaran_stars', earnedStars);
    } else if (widget.isGempaGame) {
      int current = prefs.getInt('gempa_stars') ?? 0;
      if (earnedStars > current) prefs.setInt('gempa_stars', earnedStars);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isFailed = widget.health <= 0;

    String bannerText;
    String messageText;

    if (widget.health >= 3) {
      bannerText = 'GENIUS!';
      messageText = 'Hebat! Kamu\nbenar semua!';
    } else if (widget.health == 2) {
      bannerText = 'GREAT!';
      messageText = 'Hebat! Kamu\nMenyelesaikannya!';
    } else if (widget.health == 1) {
      bannerText = 'GOOD JOB!';
      messageText = 'Kamu pasti bisa\nlebih baik!';
    } else {
      bannerText = 'FAILED';
      messageText = 'Jangan Menyerah!\nCoba Lagi!';
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/Background_Sub.png', fit: BoxFit.cover),
          ),
          if (isFailed)
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.6)),
            ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFADA32),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white, width: 3.5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      bannerText,
                      style: const TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 28,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                  if (isFailed)
                    Image.asset(
                      'assets/Earth_Mascot_Lose.png',
                      width: 180,
                      height: 180,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const Text('🌍', style: TextStyle(fontSize: 100)),
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.health >= 1) ...[
                          if (widget.health == 1)
                            const Icon(
                              Icons.star_rounded,
                              size: 76,
                              color: Color(0xFFFADA32),
                            )
                          else ...[
                            Transform.rotate(
                              angle: -0.15,
                              child: const Icon(
                                Icons.star_rounded,
                                size: 52,
                                color: Color(0xFFFADA32),
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                        ],
                        if (widget.health >= 2) ...[
                          const Icon(
                            Icons.star_rounded,
                            size: 76,
                            color: Color(0xFFFADA32),
                          ),
                          const SizedBox(width: 4),
                        ],
                        if (widget.health >= 3)
                          Transform.rotate(
                            angle: 0.15,
                            child: const Icon(
                              Icons.star_rounded,
                              size: 52,
                              color: Color(0xFFFADA32),
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(height: 36),
                  Text(
                    messageText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Titan One',
                      fontSize: 26,
                      height: 1.3,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black26,
                          offset: Offset(0, 3),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 3),
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => MainWrapper(
                                initialIndex: 0,
                                userLevel: _resolvedLevel,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFADA32),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: const BorderSide(
                              color: Colors.white,
                              width: 3.5,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Kembali',
                          style: TextStyle(
                            fontFamily: 'Titan One',
                            fontSize: 26,
                            color: Colors.black,
                          ),
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
    );
  }
}
