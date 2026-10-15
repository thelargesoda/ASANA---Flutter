import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'hadiah_page.dart';

class AboutPage extends StatefulWidget {
  final int currentLevel;
  final ValueChanged<int>? onLevelChanged;

  const AboutPage({super.key, this.currentLevel = 1, this.onLevelChanged});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  int _banjirStars = 0;
  int _longsorStars = 0;
  int _kebakaranStars = 0;
  int _gempaStars = 0;

  bool _banjirClaimed = false;
  bool _longsorClaimed = false;
  bool _kebakaranClaimed = false;
  bool _gempaClaimed = false;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _banjirStars = prefs.getInt('banjir_stars') ?? 0;
      _longsorStars = prefs.getInt('longsor_stars') ?? 0;
      _kebakaranStars = prefs.getInt('kebakaran_stars') ?? 0;
      _gempaStars = prefs.getInt('gempa_stars') ?? 0;

      _banjirClaimed = prefs.getBool('banjir_claimed') ?? false;
      _longsorClaimed = prefs.getBool('longsor_claimed') ?? false;
      _kebakaranClaimed = prefs.getBool('kebakaran_claimed') ?? false;
      _gempaClaimed = prefs.getBool('gempa_claimed') ?? false;
    });
  }

  Future<void> _claimLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (level == 1) {
        _banjirClaimed = true;
        prefs.setBool('banjir_claimed', true);
        widget.onLevelChanged?.call(2);
      } else if (level == 2) {
        _longsorClaimed = true;
        prefs.setBool('longsor_claimed', true);
        widget.onLevelChanged?.call(3);
      } else if (level == 3) {
        _kebakaranClaimed = true;
        prefs.setBool('kebakaran_claimed', true);
        widget.onLevelChanged?.call(4);
      } else if (level == 4) {
        _gempaClaimed = true;
        prefs.setBool('gempa_claimed', true);
        widget.onLevelChanged?.call(5);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final int totalStars =
        _banjirStars + _longsorStars + _kebakaranStars + _gempaStars;

    return Container(
      width: double.infinity,
      height: 1347,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Background_About.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 80, 20, 110),
          child: Column(
            children: [
              // STATISTIK BINTANG TERKUMPUL
              Text(
                'Terkumpul sebanyak :  $totalStars ⭐',
                style: const TextStyle(
                  fontFamily: 'Titan One',
                  fontSize: 18,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // BADGE 1: BANJIR
              _buildBadgeCard(
                levelNum: 1,
                emoji: '🌊',
                stars: _banjirStars,
                isUnlocked: true,
                isClaimed: _banjirClaimed,
                canClaim: _banjirStars > 0 && !_banjirClaimed,
                onClaim: () => _claimLevel(1),
              ),

              const SizedBox(height: 14),

              // BADGE 2: LONGSOR
              _buildBadgeCard(
                levelNum: 2,
                emoji: '⛰️',
                stars: _longsorStars,
                isUnlocked: _banjirClaimed,
                isClaimed: _longsorClaimed,
                canClaim:
                    _banjirClaimed && _longsorStars > 0 && !_longsorClaimed,
                onClaim: () => _claimLevel(2),
              ),

              const SizedBox(height: 14),

              // BADGE 3: KEBAKARAN
              _buildBadgeCard(
                levelNum: 3,
                emoji: '🔥',
                stars: _kebakaranStars,
                isUnlocked: _longsorClaimed,
                isClaimed: _kebakaranClaimed,
                canClaim:
                    _longsorClaimed &&
                    _kebakaranStars > 0 &&
                    !_kebakaranClaimed,
                onClaim: () => _claimLevel(3),
              ),

              const SizedBox(height: 14),

              // BADGE 4: GEMPA BUMI
              _buildBadgeCard(
                levelNum: 4,
                emoji: '🏚️',
                stars: _gempaStars,
                isUnlocked: _kebakaranClaimed,
                isClaimed: _gempaClaimed,
                canClaim:
                    _kebakaranClaimed && _gempaStars > 0 && !_gempaClaimed,
                onClaim: () => _claimLevel(4),
              ),

              const SizedBox(height: 20),

              // TOMBOL HADIAH
              GestureDetector(
                onTap: _gempaClaimed
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HadiahPage(),
                          ),
                        );
                      }
                    : null,
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: _gempaClaimed
                        ? const Color(0xFFFADA32)
                        : const Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.white, width: 3.5),
                    boxShadow: _gempaClaimed
                        ? const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 6,
                              offset: Offset(0, 3),
                            ),
                          ]
                        : [],
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('⭐ ', style: TextStyle(fontSize: 20)),
                      Text(
                        'Hadiah',
                        style: TextStyle(
                          fontFamily: 'Titan One',
                          fontSize: 22,
                          color: _gempaClaimed ? Colors.black : Colors.black38,
                        ),
                      ),
                      const Text(' ⭐', style: TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // TOMBOL KEMBALI
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFADA32),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                      side: const BorderSide(color: Colors.white, width: 3.5),
                    ),
                  ),
                  child: const Text(
                    'Kembali',
                    style: TextStyle(
                      fontFamily: 'Titan One',
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadgeCard({
    required int levelNum,
    required String emoji,
    required int stars,
    required bool isUnlocked,
    required bool isClaimed,
    required bool canClaim,
    required VoidCallback onClaim,
  }) {
    String titleText = 'level $levelNum';
    String descText;
    if (levelNum == 1) {
      descText = stars >= 3
          ? 'Asana paham cara melakukan mitigasi banjir'
          : 'Pemahaman mitigasi banjir masih kurang';
    } else if (levelNum == 2) {
      descText = stars >= 3
          ? 'Asana paham cara melakukan mitigasi longsor'
          : 'Pemahaman mitigasi longsor masih kurang';
    } else if (levelNum == 3) {
      descText = stars >= 3
          ? 'Asana paham cara melakukan mitigasi kebakaran'
          : 'Pemahaman mitigasi kebakaran masih kurang';
    } else {
      descText = stars >= 3
          ? 'Asana paham cara melakukan mitigasi gempa'
          : 'Pemahaman mitigasi gempa bumi masih kurang';
    }

    Color bgColor = isUnlocked
        ? const Color(0xFFB0F9FD)
        : const Color(0xFFD9D9D9);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: Text(
              isUnlocked ? emoji : '🔒',
              style: TextStyle(fontSize: isUnlocked ? 28 : 22),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      titleText,
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 16,
                        color: isUnlocked
                            ? const Color(0xFF1E88E5)
                            : Colors.grey[700],
                      ),
                    ),
                    Text(
                      '$stars/3 ⭐',
                      style: TextStyle(
                        fontFamily: 'Titan One',
                        fontSize: 14,
                        color: isUnlocked ? Colors.black87 : Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  isUnlocked ? descText : 'Belum terbuka',
                  style: TextStyle(
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w600,
                    fontSize: 11.5,
                    color: isUnlocked ? Colors.black87 : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: 28,
                    child: ElevatedButton(
                      onPressed: canClaim ? onClaim : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: canClaim
                            ? const Color(0xFFFADA32)
                            : const Color(0xFFE0E0E0),
                        disabledBackgroundColor: const Color(0xFFE0E0E0),
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        isClaimed ? 'Claimed' : 'Claim',
                        style: TextStyle(
                          fontFamily: 'Titan One',
                          fontSize: 11,
                          color: canClaim ? Colors.black : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
