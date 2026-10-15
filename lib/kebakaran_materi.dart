import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import 'kebakaran_game.dart';

class KebakaranMateriPage extends StatefulWidget {
  final int userLevel; // Added userLevel

  const KebakaranMateriPage({super.key, this.userLevel = 1});

  @override
  State<KebakaranMateriPage> createState() => _KebakaranMateriPageState();
}

class _KebakaranMateriPageState extends State<KebakaranMateriPage> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: '8knSch3wOoI',
      autoPlay: false,
      params: const YoutubePlayerParams(
        showFullscreenButton: true,
        mute: false,
        loop: false,
        strictRelatedVideos: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  void _goBackToMain() {
    _controller.pauseVideo();
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Main_Background2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 10),

              // YOUTUBE VIDEO PLAYER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.9),
                      width: 2.5,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 8,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(13),
                    child: YoutubePlayer(controller: _controller),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // MAIN CONTENT CARD
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFB0F9FD),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(36),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.fromLTRB(22, 20, 22, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: Text(
                                  'Kebakaran',
                                  style: TextStyle(
                                    fontFamily: 'Titan One',
                                    fontSize: 32,
                                    color: Color(0xFF1E88E5),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Kebakaran adalah api yang membesar di luar kendali dan membakar bangunan. Selain api yang panas, kebakaran menghasilkan asap tebal yang sangat hitam dan beracun. Bagi anak-anak, mitigasi kebakaran BUKAN berarti kamu harus memadamkan api seperti petugas pemadam kebakaran, melainkan bagaimana caramu bisa keluar dari ruangan secepat mungkin tanpa menghirup asap.',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.5,
                                  height: 1.45,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Apa yang harus dilakukan?',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildBulletItem(
                                boldPrefix: 'Merangkak di Bawah Asap: ',
                                text: 'Jalan merangkak dekat lantai karena udara bersih ada di bawah, sedangkan asap beracun naik ke atas.',
                              ),
                              _buildBulletItem(
                                boldPrefix: 'Cek Pintu Dulu: ',
                                text: 'Sentuh pintu dengan punggung tangan. Jika terasa panas, jangan dibuka dan cari jalan lain.',
                              ),
                              _buildBulletItem(
                                boldPrefix: 'Berhenti, Rebah, Berguling: ',
                                text: 'Jangan lari jika baju terbakar. Segera jatuhkan badan ke lantai dan berguling sampai api padam.',
                              ),
                              _buildBulletItem(
                                boldPrefix: 'Tinggalkan Barangmu: ',
                                text: 'Utamakan nyawa, jangan pernah kembali ke dalam ruangan hanya untuk mengambil barang.',
                              ),
                            ],
                          ),
                        ),
                      ),

                      // BOTTOM BUTTONS
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(28),
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _controller.pauseVideo();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => KebakaranGamePage(
                                          userLevel: widget.userLevel, // Forward userLevel here!
                                        ),
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFADA32),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(28),
                                      side: const BorderSide(
                                        color: Colors.white,
                                        width: 3.5,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Quiz',
                                    style: TextStyle(
                                      fontFamily: 'Titan One',
                                      fontSize: 24,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: _goBackToMain,
                              child: Image.asset(
                                'assets/icon/HomePageIconOn.png',
                                width: 56,
                                height: 56,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      width: 56,
                                      height: 56,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFADA32),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 3.5,
                                        ),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 6,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.home_rounded,
                                        size: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _buildBulletItem({
    required String boldPrefix,
    required String text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '•  ',
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  height: 1.4,
                  color: Colors.black87,
                ),
                children: [
                  TextSpan(
                    text: boldPrefix,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(text: text),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
