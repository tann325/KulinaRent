import 'package:flutter/material.dart';
// Pastikan import ini sesuai dengan struktur folder proyek Anda
import 'package:kulinarent_2026/admin/screens/riwayat1.dart';
import 'package:kulinarent_2026/admin/screens/dashboard.dart'; 
import 'package:kulinarent_2026/admin/screens/pengguna_screen.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  // FUNGSI UNTUK MENAMPILKAN POP-UP LOGOUT
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2C6CC),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Text(
                    'Keluar aplikasi !',
                    style: TextStyle(
                      color: Color(0xFFE91E63),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Anda akan keluar dari aplikasi ini, jika mau masuk maka perlu akses login kembali!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Batal"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Tambahkan logika logout sesungguhnya di sini (misal: hapus session)
                          Navigator.pop(context); // Tutup dialog
                          print("Logout Berhasil");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF5252),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Logout', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C6CC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // HEADER
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7A9BD),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'KulinaRent',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'Admin',
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // USERNAME FIELD
                const Text(
                  ' UserName :',
                  style: TextStyle(color: Color(0xFF7B1530), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildInfoField('petugas2@gmail.com'),

                const SizedBox(height: 20),

                // ROLE FIELD
                const Text(
                  ' Role :',
                  style: TextStyle(color: Color(0xFF7B1530), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                _buildInfoField('petugas2'),

                const SizedBox(height: 40),

                // TOMBOL LOGOUT
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _showLogoutDialog(context),
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text("Keluar Aplikasi", 
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B1530),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      
      // BOTTOM NAVIGATION BAR (Disesuaikan)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 4, // Index Profil adalah 4
        selectedItemColor: const Color(0xFF7B1530),
        unselectedItemColor: Colors.black54,
        onTap: (index) {
          if (index == 0) {
            // Index 0 sekarang mengarah ke Dashboard (Alat)
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
          } else if (index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PenggunaScreen()));
          } else if (index == 2 || index == 3) {
            // Mengarah ke Riwayat untuk index Riwayat dan Aktivitas
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RiwayatScreen()));
          }
          // Jika index 4 (Profil), tidak perlu pindah karena sudah di halaman profil
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen), label: 'Alat'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Pengguna'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Aktifitas'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  Widget _buildInfoField(String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        value,
        style: const TextStyle(color: Color(0xFFE91E63), fontWeight: FontWeight.bold),
      ),
    );
  }
}