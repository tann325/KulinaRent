import 'package:flutter/material.dart';
import 'package:kulinarent_2026/petugas/screen/petugas_dashboard.dart';
// Pastikan file-file ini ada di folder yang sama atau path-nya benar
import 'dashboard.dart'; 
import 'petugas_dashboard.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // CONTROLLER - Menggunakan static agar bisa diakses di handleLogin
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();

  void handleLogin(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // 1. VALIDASI INPUT KOSONG
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email dan password wajib diisi'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // 2. LOGIKA LOGIN ADMIN
    if (email == 'admin@gmail.com' && password == 'admin') {
      emailController.clear();
      passwordController.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardScreen()),
      );
    }
    // 3. LOGIKA LOGIN PETUGAS
    else if (email == 'petugas@gmail.com' && password == 'petugas') {
      emailController.clear();
      passwordController.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const DashboardPetugas()),
      );
    }
    // 4. GAGAL LOGIN
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Email atau password salah'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SingleChildScrollView mencegah error 'Pixel Overflow' saat keyboard muncul
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
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
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported,
                      size: 100,
                      color: Colors.white,
                    ),
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
                        _inputField(
                          controller: emailController,
                          hint: 'Email',
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 12),
                        _inputField(
                          controller: passwordController,
                          hint: 'Password',
                          obscureText: true,
                        ),
                        const SizedBox(height: 16),

                        // BUTTON LOGIN
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
      ),
    );
  }

  // WIDGET INPUT FIELD CUSTOM
  Widget _inputField({
    required TextEditingController controller,
    required String hint,
    required bool obscureText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      textAlign: TextAlign.center,
      keyboardType: keyboardType,
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
    );
  }
}