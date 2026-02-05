import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kulinarent_2026/admin/screens/dashboard.dart';
import 'package:kulinarent_2026/peminjaman/dasboard_peminjaman.dart';
import 'package:kulinarent_2026/petugas/screen/petugas_dashboard.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  // Controller static agar data tidak hilang saat rebuild
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();

  void handleLogin(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // 1. Validasi Input Kosong
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar(context, 'Email dan password wajib diisi');
      return;
    }

    // 2. Logika Login Admin
    if (email == 'admin@gmail.com' && password == 'admin') {
      _navigateTo(context, const DashboardScreen());
    } 
    // 3. Logika Login Petugas
    else if (email == 'petugas@gmail.com' && password == 'petugas') {
      _navigateTo(context, const DashboardPetugas());
    } 
    // 4. Logika Login Peminjam (User Umum)
    // Cek apakah ada '@' dan password minimal 4 karakter
    else if (email.contains('@') && password.length >= 4) {
      // Mengarahkan ke class DashboardPeminjam yang kita perbaiki tadi
      _navigateTo(context, const DashboardPeminjam());
    } 
    // 5. Jika Tidak Ada yang Cocok
    else {
      _showSnackBar(context, 'Email salah atau password terlalu pendek (min 4)');
    }
  }

  // Helper navigasi agar kode lebih ringkas
  void _navigateTo(BuildContext context, Widget target) {
    // Reset form setelah login sukses
    emailController.clear();
    passwordController.clear();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => target),
    );
  }

  // Helper pesan error
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF7B1530),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF2C6CC), // Pink Muda
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo KulinaRent
                  Image.asset(
                    'assets/images/logo_kulinarent.png',
                    width: 140,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.restaurant_menu, size: 80, color: Color(0xFF7B1530)),
                  ),
                  const SizedBox(height: 24),

                  // Form Input
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

                        // Tombol Login
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            onPressed: () => handleLogin(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7B1530), // Maroon
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 0,
                            ),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
        fillColor: const Color(0xFFE7A9BD), // Pink Tua Input
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}