import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/login_page.dart';
import 'package:kulinarent_2026/services/supabase_service.dart';
import 'package:kulinarent_2026/admin/screens/login_page.dart';

void main() async {
  // 1. Inisialisasi binding Flutter
  WidgetsFlutterBinding.ensureInitialized();
  
  // 2. Inisialisasi Supabase (PENTING: pakai await)
  await SupabaseService.init();
  
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
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7A1631)),
      ),
      // Aplikasi dimulai dari LoginScreen
      home: const LoginScreen(), 
    );
  }
}