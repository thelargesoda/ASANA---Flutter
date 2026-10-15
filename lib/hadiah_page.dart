import 'package:flutter/material.dart';

class HadiahPage extends StatelessWidget {
  const HadiahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background_About.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const Text(
                  '✨ CONGRATULATION ✨',
                  style: TextStyle(
                    fontFamily: 'Titan One',
                    fontSize: 26,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black38,
                        offset: Offset(0, 3),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Certificate Container Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB0F9FD),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: Colors.white, width: 4),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'SERTIFIKAT KELULUSAN',
                        style: TextStyle(
                          fontFamily: 'Titan One',
                          fontSize: 20,
                          color: Color(0xFF1E88E5),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'SUMA MITIGASI',
                        style: TextStyle(
                          fontFamily: 'Titan One',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        'assets/Earth_Mascot_Lose.png',
                        width: 120,
                        height: 120,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) =>
                            const Text('📜', style: TextStyle(fontSize: 80)),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Selamat Asana,\nKamu telah berhasil menyelesaikan semua tantangan mitigasi bersama SUMA !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Titan One',
                          fontSize: 14,
                          height: 1.4,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // KEMBALI BUTTON
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
      ),
    );
  }
}
