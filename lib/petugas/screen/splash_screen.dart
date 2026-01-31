import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // pindah ke login setelah 2 detik
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C6CC), // pink lembut
      body: Center(
        child: Image.asset(
          'assets/images/logo_kulinarent.png',
          width: 250, // logo diperbesar
        ),
      ),
    );
  }
}
