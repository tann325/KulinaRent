import 'package:flutter/material.dart';
import 'alat1.dart';
import 'aktivitas1.dart';
import 'pengguna_screen.dart';
import 'profil_screen.dart';

// -------------------------------------------------------------------------
// HALAMAN: DASHBOARD (FOKUS UTAMA)
// -------------------------------------------------------------------------
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 2; // Home default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D3D6),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context, "KulinaRent", "Dashboard"),

            const SizedBox(height: 20),

            // Grid Statistik
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.2,
                children: [
                  _buildStatCard("Pengguna Aktif", "7"),
                  _buildStatCard("Jumlah Alat", "10"),
                  _buildStatCard("Alat Tersedia", "7"),
                  _buildStatCard("Alat Dipinjam", "7"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // Label Riwayat
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Riwayat Peminjaman:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // List Riwayat
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                children: [
                  _buildRiwayatItem("Peminjaman 02", "10.34 20 Januari 2026"),
                  _buildRiwayatItem("Peminjaman 01", "08.20 15 Januari 2026"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildSimpleBottomNav(),
    );
  }

  // --- Widget Header (Dengan Icon Profil) ---
  Widget _buildHeader(BuildContext context, String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 30),
      decoration: const BoxDecoration(
        color: Color(0xFFE7A9BD),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TEXT KIRI
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ],
          ),

          const Spacer(),

          // ICON PROFIL KANAN
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Color(0xFFE7A9BD),
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Kartu Statistik ---
  Widget _buildStatCard(String label, String value) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: Colors.pink,
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
          ),
        ],
      ),
    );
  }

  // --- Widget Item Riwayat ---
  Widget _buildRiwayatItem(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 30),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: Colors.pinkAccent, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Widget Navigasi Bawah (Static) ---
  Widget _buildSimpleBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.white,
      backgroundColor: const Color(0xFFE7A9BD),
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });

        switch (index) {
          case 0:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AlatScreen()),
            );
            break;
          case 1:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PenggunaScreen()),
            );
            break;
          case 2:
            // Dashboard (diam)
            break;
          case 3:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AktifitasScreen()),
            );
            break;
          case 4:
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AktifitasScreen()),
            );
            break;
        }
      },

      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen), label: 'Alat'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Pengguna'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Aktivitas',
        ),
      ],
    );
  }
}
