import 'package:flutter/material.dart';
import 'alat1.dart';
import 'aktivitas1.dart';

// -------------------------------------------------------------------------
// REUSABLE WIDGETS
// -------------------------------------------------------------------------
class CommonWidgets {
  static Widget buildHeader(BuildContext context, String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      decoration: const BoxDecoration(
        color: Color(0xFFE7A9BD),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
            onPressed: () {
              // SOLUSI AMPUH: Hapus semua tumpukan halaman dan balik ke Dashboard
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AlatScreen()),
                (route) => false,
              );
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white)),
              Text(subtitle,
                  style: const TextStyle(color: Colors.white, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  static Widget buildSearchBar(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: const Icon(Icons.search, color: Color(0xFFE7A9BD)),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        ),
      ),
    );
  }

  static Widget buildBottomNav(BuildContext context, String active) {
    return BottomNavigationBar(
      currentIndex: _getSelectedIndex(active),
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == 0 && active != 'Alat') {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AlatScreen()), (route) => false);
        } else if (index == 1 && active != 'Pengguna') {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const PenggunaScreen()), (route) => false);
        } else if (index == 3 && active != 'Aktifitas') {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AktifitasScreen()), (route) => false);
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen), label: 'Alat'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Pengguna'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Aktifitas'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
      ],
    );
  }

  static int _getSelectedIndex(String active) {
    switch (active) {
      case 'Alat': return 0;
      case 'Pengguna': return 1;
      case 'Riwayat': return 2;
      case 'Aktifitas': return 3;
      case 'Profil': return 4;
      default: return 0;
    }
  }
}

// -------------------------------------------------------------------------
// HALAMAN: PENGGUNA
// -------------------------------------------------------------------------
class PenggunaScreen extends StatefulWidget {
  const PenggunaScreen({super.key});
  @override State<PenggunaScreen> createState() => _PenggunaScreenState();
}
class _PenggunaScreenState extends State<PenggunaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D3D6),
      body: SafeArea(
        child: Column(
          children: [
            CommonWidgets.buildHeader(context, "KulinaRent", "Pengguna"),
            const SizedBox(height: 25),
            CommonWidgets.buildSearchBar("Cari Pengguna"),
            const Expanded(child: Center(child: Text("Daftar Pengguna"))),
          ],
        ),
      ),
      bottomNavigationBar: CommonWidgets.buildBottomNav(context, 'Pengguna'),
    );
  }
}