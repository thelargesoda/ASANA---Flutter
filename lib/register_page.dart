import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum RegisterStatus { idle, loading, success }

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterStatus _status = RegisterStatus.idle;

  void _handleRegister() async {
    setState(() {
      _status = RegisterStatus.loading;
    });

    // 1. Show loading screen for 3 seconds
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    // 2. Show success state
    setState(() {
      _status = RegisterStatus.success;
    });

    // 3. Show "Daftar akun berhasil" message for 2 seconds
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // 4. Automatically navigate back to LoginPage
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
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
          child: Stack(
            children: [
              // ===============================================================
              // TOP LEFT BACK BUTTON (<)
              // ===============================================================
              Positioned(
                top: 10,
                left: 20,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFB0F9FD),
                      shape: BoxShape.circle,
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
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black,
                      size: 22,
                    ),
                  ),
                ),
              ),

              // ===============================================================
              // MAIN CONTENT
              // ===============================================================
              Column(
                children: [
                  const Spacer(),

                  // Register Card Box
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 32,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFB0F9FD),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 14,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: _buildCardContent(),
                    ),
                  ),

                  const Spacer(),

                  // Bottom Container with "Buat Akun" Button
                  if (_status == RegisterStatus.idle)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 24,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFB0F9FD),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(32),
                        ),
                      ),
                      child: SafeArea(
                        top: false,
                        child: SizedBox(
                          width: double.infinity,
                          height: 58,
                          child: ElevatedButton(
                            onPressed: _handleRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFADA32),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 4,
                                ),
                              ),
                            ),
                            child: const Text(
                              'Buat Akun',
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
            ],
          ),
        ),
      ),
    );
  }

  // Card Content Switcher based on Register Status
  Widget _buildCardContent() {
    // 1. Loading Screen State
    if (_status == RegisterStatus.loading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 36.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1E88E5)),
                strokeWidth: 5,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Membuat Akun...',
              style: TextStyle(
                fontFamily: 'Titan One',
                fontSize: 20,
                color: Color(0xFF1E88E5),
              ),
            ),
          ],
        ),
      );
    }

    // 2. Success Screen State
    if (_status == RegisterStatus.success) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 36.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Color(0xFF5AFA32),
              size: 64,
            ),
            SizedBox(height: 16),
            Text(
              'Daftar akun berhasil',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Titan One',
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }

    // 3. Normal Form State
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title Text Header
        const Text(
          'Register',
          style: TextStyle(
            fontFamily: 'Titan One',
            fontSize: 32,
            color: Color(0xFF1E88E5),
          ),
        ),
        const SizedBox(height: 24),

        // Email Input Field
        _buildTextField(
          controller: _emailController,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),

        const SizedBox(height: 16),

        // Username Input Field (Max 15 Characters)
        _buildTextField(
          controller: _usernameController,
          hintText: 'Username',
          maxLength: 15,
        ),

        const SizedBox(height: 16),

        // Password Input Field
        _buildTextField(
          controller: _passwordController,
          hintText: 'Password',
          obscureText: true,
        ),
      ],
    );
  }

  // Reusable TextField Builder Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int? maxLength,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        inputFormatters: maxLength != null
            ? [LengthLimitingTextInputFormatter(maxLength)]
            : null,
        style: const TextStyle(
          fontFamily: 'Titan One',
          fontSize: 18,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          counterText: '', // Hide character counter text
          hintStyle: const TextStyle(
            fontFamily: 'Titan One',
            fontSize: 18,
            color: Color(0xFFA0A0A0),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
