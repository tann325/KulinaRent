import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/dashboard.dart';
import 'package:kulinarent_2026/admin/screens/profil_screen.dart';
import 'petugas_dashboard.dart';
import 'profil_screen.dart'; // ganti kalau kamu punya halaman user lain

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // CONTROLLER
  static final TextEditingController emailController =
      TextEditingController();
  static final TextEditingController passwordController =
      TextEditingController();

  void handleLogin(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // VALIDASI KOSONG
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password wajib diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // LOGIN ADMIN
    if (email == 'petugas@gmail.com' && password == 'petugas') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    }
    // LOGIN USER BIASA
    else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfilScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color(0xFFF2C6CC),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // LOGO
                Image.asset(
                  'assets/images/logo_kulinarent.png',
                  width: 140,
                ),

                const SizedBox(height: 24),

                // BOX INPUT
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // EMAIL
                      _inputField(
                        controller: emailController,
                        hint: 'Email',
                        obscureText: false,
                      ),

                      const SizedBox(height: 12),

                      // PASSWORD
                      _inputField(
                        controller: passwordController,
                        hint: 'Password',
                        obscureText: true,
                      ),

                      const SizedBox(height: 16),

                      // TOMBOL LOGIN
                      SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: ElevatedButton(
                          onPressed: () => handleLogin(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B1530),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // INPUT FIELD
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required bool obscureText,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        color: Color(0xFF7B1530),
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFFE7A9BD),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      textAlign: TextAlign.center,
    );
  }
}
