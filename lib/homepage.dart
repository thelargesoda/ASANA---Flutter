import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final VoidCallback? onMateriPressed;
  final int userLevel;

  const HomePage({super.key, this.onMateriPressed, this.userLevel = 1});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. SCROLLABLE BACKGROUND & CONTENT (Total Height: 1172px)
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              width: double.infinity,
              height: 1172,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Main_Background2Long.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 70), // Spacing for Fixed Top Bar
                      // Title Text
                      const Text(
                        "Lets' Play\nwith BUMA",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Titan One',
                          fontSize: 42,
                          height: 1.1,
                          color: Color(0xFFC5F8FF),
                          shadows: [
                            Shadow(
                              color: Color(0xFF1E88E5),
                              offset: Offset(2, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Mascot Image & Ground Shadow Stack
                      SizedBox(
                        height: 270,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Ground Shadow
                            Positioned(
                              bottom: 15,
                              child: Transform.scale(
                                scaleX: 9.0,
                                scaleY: 0.5,
                                child: Container(
                                  width: 50,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                      colors: [
                                        Colors.black.withValues(alpha: 0.5),
                                        Colors.black.withValues(alpha: 0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            // Mascot
                            Image.asset(
                              'assets/Mascot_Pose1.png',
                              height: 400,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Info Text Box Container
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFB0F9FD),
                          borderRadius: BorderRadius.circular(28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo teman-teman jagoan!\nPerkenalkan, aku BUMA!',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                height: 1.3,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              'Siapa itu BUMA? Aku adalah Sahabat Siaga Bencana kalian! Tugas utamaku adalah menemani dan melatih anak-anak hebat seperti kalian supaya bisa jadi pahlawan keselamatan untuk diri sendiri dan orang-orang tersayang.',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                                height: 1.35,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // "Materi" Button
                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton(
                          onPressed: () {
                            // Switches tab inside MainWrapper without unmounting the navbars
                            onMateriPressed?.call();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFADA32),
                            elevation: 6,
                            shadowColor: Colors.black45,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 4,
                              ),
                            ),
                          ),
                          child: const Text(
                            'Materi',
                            style: TextStyle(
                              fontFamily: 'Titan One',
                              fontSize: 28,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
