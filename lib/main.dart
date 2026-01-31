import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/login_page.dart';
import 'admin/screens/splash_screen.dart';
import 'services/supabase_service.dart';
import 'admin/screens/alat1.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SupabaseService.init();
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

