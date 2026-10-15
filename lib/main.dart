import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ASANA',
      theme: ThemeData(
        // Changes default page transitions globally across all screens (Mobile, Web, Desktop)
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Main_Background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              const SizedBox(height: 40),

              // Title: ASANA
              const Text(
                'ASANA',
                style: TextStyle(
                  fontFamily: 'Titan One',
                  fontSize: 68,
                  color: Color(0xFFFDD835),
                  shadows: [
                    Shadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),

              // Subtitle
              const Text(
                'Mitigasi Bencana\nAnak-anak',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Titan One',
                  fontSize: 18,
                  color: Color(0xFFFDD835),
                  height: 1.2,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 2),
                      blurRadius: 2,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),

              // Mascot with Ground Shadow
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // 1. SHADOW (Drawn first = Behind)
                      Transform.translate(
                        offset: const Offset(0, 160), // Align with mascot feet
                        child: Transform.scale(
                          scaleX: 7.0,
                          scaleY: 0.6,
                          child: Container(
                            width: 200,
                            height: 50,
                            decoration: BoxDecoration(
                              gradient: RadialGradient(
                                colors: [
                                  Colors.black.withValues(alpha: 0.45),
                                  Colors.black.withValues(alpha: 0.0),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // 2. MASCOT IMAGE (Drawn second = In Front)
                      Transform.translate(
                        offset: const Offset(0, 20),
                        child: Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(math.pi),
                          child: Image.asset(
                            'assets/Mascot_Pose1.png',
                            height: 400,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom Container with "Mulai" Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFFB2F2FB),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(36)),
                ),
                child: SafeArea(
                  top: false,
                  child: SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFDD835),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.white, width: 4),
                        ),
                      ),
                      child: const Text(
                        'Mulai',
                        style: TextStyle(
                          fontFamily: 'Titan One',
                          fontSize: 26,
                          color: Colors.black,
                        ),
                      ),
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
}
