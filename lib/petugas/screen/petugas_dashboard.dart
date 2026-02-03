import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/logout_screen.dart';
import 'package:kulinarent_2026/petugas/screen/laporan_petugan_screen.dart';
import 'package:kulinarent_2026/petugas/screen/pengajuan_peminjaman_screen.dart';
import 'package:kulinarent_2026/petugas/screen/penggembalian_screen.dart';

class DashboardPetugas extends StatefulWidget {
  const DashboardPetugas({super.key});

  @override
  State<DashboardPetugas> createState() => _DashboardPetugasState();
}

class _DashboardPetugasState extends State<DashboardPetugas> {
  int _selectedIndex = 0;
  final Color softPink = const Color(0xFFD18DA0);

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
          // SEKARANG PINDAH KE HALAMAN LOGOUT SCREEN
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LogoutScreen()),
              );
            },
            child: const CircleAvatar(
              backgroundColor: Colors.white24, 
              child: Icon(Icons.person, color: Colors.white)
            ),
          )
        ],
      ),
    );
  }

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