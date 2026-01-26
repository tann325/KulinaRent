import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const KulinaRentApp());
}

class KulinaRentApp extends StatelessWidget {
  const KulinaRentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KulinaRent',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7A1631), // maroon
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
