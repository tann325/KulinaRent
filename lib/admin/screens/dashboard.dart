import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kulinarent_2026/admin/screens/aktivitas1.dart';
import 'package:kulinarent_2026/admin/screens/alat1.dart';
import 'package:kulinarent_2026/admin/screens/logout_screen.dart';
import 'package:kulinarent_2026/admin/screens/pengguna_screen.dart';
import 'package:kulinarent_2026/admin/screens/riwayat_screen.dart';
import 'package:kulinarent_2026/admin/screens/logout_screen.dart';


class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 2; // Dashboard index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D3D6),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, "KulinaRent", "Dashboard"),
            const SizedBox(height: 20),

            // ================= STATISTIK =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.2,
                children: const [
                  _StatCard(label: "Pengguna Aktif", value: "7"),
                  _StatCard(label: "Jumlah Alat", value: "10"),
                  _StatCard(label: "Alat Tersedia", value: "7"),
                  _StatCard(label: "Alat Dipinjam", value: "7"),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ================= RIWAYAT =================
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

            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                children: const [
                  _RiwayatItem(
                    title: "Peminjaman 02",
                    subtitle: "10.34 20 Januari 2026",
                  ),
                  _RiwayatItem(
                    title: "Peminjaman 01",
                    subtitle: "08.20 15 Januari 2026",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(BuildContext context, String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
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

          // ===== ICON PROFIL → LOGOUT =====
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LogoutScreen()),
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

  // ================= BOTTOM NAV =================
  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == _currentIndex) return;

        switch (index) {
          case 0:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const AlatScreen()));
            break;
          case 1:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const PenggunaScreen()));
            break;
          case 3:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const RiwayatScreen()));
            break;
          case 4:
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const AktifitasScreen()));
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen_outlined), label: 'Alat'),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Pengguna'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Aktifitas'),
      ],
    );
  }
}

// ================= WIDGET KECIL =================
class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 5),
          Text(value,
              style: const TextStyle(
                  color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 32)),
        ],
      ),
    );
  }
}

class _RiwayatItem extends StatelessWidget {
  final String title;
  final String subtitle;

  const _RiwayatItem({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.pink, fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style:
                      const TextStyle(color: Colors.pinkAccent, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}
