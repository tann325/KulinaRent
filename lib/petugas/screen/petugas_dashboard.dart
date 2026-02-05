import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/login_page.dart';
import 'package:kulinarent_2026/petugas/screen/laporan_petugan_screen.dart';
import 'pengajuan_peminjaman_screen.dart';
import 'penggembalian_screen.dart';
import 'laporan_petugas_screen.dart';

class DashboardPetugas extends StatefulWidget {
  const DashboardPetugas({super.key});

  @override
  State<DashboardPetugas> createState() => _DashboardPetugasState();
}

class _DashboardPetugasState extends State<DashboardPetugas> {
  int _selectedIndex = 0;
  
  // Warna Pink Soft untuk menggantikan Grey agar lebih estetik
  final Color softPink = const Color(0xFFD18DA0);

  // FUNGSI LOGOUT DIALOG DENGAN NAVIGASI KE LOGIN SCREEN
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
                // Header Label "Keluar aplikasi"
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5D1D1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Keluar aplikasi',
                    style: TextStyle(
                      color: Color(0xFFD81B60),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Teks Peringatan
                const Text(
                  'Anda akan keluar dari aplikasi ini, jika mau masuk maka perlu akses login kembali!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.black87),
                ),
                const SizedBox(height: 25),
                // Tombol Logout Merah
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // NAVIGASI BALIK KE LOGIN SCREEN
                      // Menggunakan pushAndRemoveUntil agar user tidak bisa tekan 'back' kembali ke dashboard
                      Navigator.pushAndRemoveUntil(
                        context, 
                        MaterialPageRoute(builder: (_) => const LoginScreen()), 
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6B6B),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
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
      backgroundColor: const Color(0xFFF5D1D1),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildMainContent(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  // HEADER DENGAN TOMBOL PROFIL
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFE4A5B8),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('KulinaRent', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('Dashboard Petugas', style: TextStyle(color: Colors.white70)),
            ],
          ),
          // Klik icon profil untuk Logout
          GestureDetector(
            onTap: () => _showLogoutDialog(context),
            child: const CircleAvatar(
              backgroundColor: Colors.white24, 
              child: Icon(Icons.person, color: Colors.white)
            ),
          )
        ],
      ),
    );
  }

  // ISI UTAMA DASHBOARD
  Widget _buildMainContent() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.2,
              children: const [
                _StatCard('Pengguna Aktif', '7'),
                _StatCard('Jumlah Alat', '10'),
                _StatCard('Alat Tersedia', '7'),
                _StatCard('Alat Dipinjam', '3'),
              ],
            ),
            const SizedBox(height: 25),
            const Text('Riwayat Peminjaman:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
            const SizedBox(height: 10),
            _riwayatItem('Peminjaman 02', '10.34 20 Januari 2026'),
            _riwayatItem('Peminjaman 01', '08.20 15 Januari 2026'),
          ],
        ),
      ),
    );
  }

  // NAVIGASI BAWAH
  Widget _buildBottomNavigation(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF7B1530),
      unselectedItemColor: softPink,
      onTap: (index) {
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PengajuanPeminjamanScreen()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PengembalianScreen()));
        } else if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const LaporanScreen()));
        } else {
          setState(() => _selectedIndex = index);
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Peminjaman'),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Pengembalian'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Laporan'),
      ],
    );
  }

  // ITEM RIWAYAT
  Widget _riwayatItem(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pink)),
              Text(subtitle, style: TextStyle(fontSize: 11, color: softPink)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  const _StatCard(this.title, this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.pink)),
        ],
      ),
    );
  }
}