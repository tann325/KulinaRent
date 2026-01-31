import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/login_page.dart';
import 'dashboard.dart';

class LogoutScreen extends StatefulWidget {
  const LogoutScreen({super.key});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  // CONTROLLER KOSONG (AGAR HINT AUTO HILANG)
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController roleController = TextEditingController();

  void handleLogout(BuildContext context) {
    if (usernameController.text.trim().isEmpty ||
        roleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username dan Role wajib diisi!'),
          backgroundColor: Color(0xFFE85C5C),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: Color(0xFFE91E63),
        fontWeight: FontWeight.bold,
      ),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE91E63), width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE91E63), width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C6CC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7A9BD),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [
                    IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
        Navigator.pop(context);
      },
    ),

                    const SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'KulinaRent',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Admin',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // USERNAME
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: usernameController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: Color.fromARGB(255, 234, 145, 175),
                  fontWeight: FontWeight.bold,
                ),
                decoration: inputDecoration('masukkan username'),
              ),

              const SizedBox(height: 16),

              // ROLE
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Role',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: roleController,
                style: const TextStyle(
                  color: Color.fromARGB(255, 242, 123, 163),
                  fontWeight: FontWeight.bold,
                ),
                decoration: inputDecoration('masukkan role'),
              ),

              const SizedBox(height: 20),

              // LOGOUT CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2C6CC),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Keluar aplikasi !',
                        style: TextStyle(
                          color: Color(0xFFE91E63),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Anda akan keluar dari aplikasi ini, jika mau\nmasuk maka perlu akses login kembali!',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: 140,
                      height: 36,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE85C5C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () => handleLogout(context),
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
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
    );
  }
}
