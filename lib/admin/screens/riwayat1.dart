import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/logout_page.dart';
import 'package:kulinarent_2026/admin/screens/dashboard.dart';
import 'package:kulinarent_2026/admin/screens/pengguna_screen.dart';
import 'package:kulinarent_2026/admin/screens/alat1.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  String filterAktif = 'Peminjaman'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C6CC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
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
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Riwayat & Aktivitas',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // SEARCH BAR
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Riwayat',
                  hintStyle: const TextStyle(color: Color(0xFFE7A9BD)),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: const Icon(Icons.search, color: Color(0xFFE7A9BD)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // FILTER BUTTONS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterButton('Semua'),
                  _buildFilterButton('Peminjaman'),
                  _buildFilterButton('Pengembalian'),
                ],
              ),

              const SizedBox(height: 20),

              // DAFTAR RIWAYAT
              Expanded(
                child: ListView(
                  children: _getFilteredList(),
                ),
              ),
            ],
          ),
        ),
      ),

      // BOTTOM NAVBAR - SUDAH AKTIF
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // Highlight Riwayat
        selectedItemColor: const Color(0xFF7B1530),
        unselectedItemColor: Colors.black54,
        iconSize: 26,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AlatScreen()));
          } else if (index == 1) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PenggunaScreen()));
          } else if (index == 2 || index == 3) {
            // Sudah di halaman ini (Riwayat/Aktivitas)
          } else if (index == 4) {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfilScreen()));
          }
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

  // Logika Filter List
  List<Widget> _getFilteredList() {
    if (filterAktif == 'Peminjaman') {
      return [
        _buildRiwayatCard('Salsadila Ariza', 'Peminjaman', '20 Jan 2026'),
        _buildRiwayatCard('Richo Ferdinan', 'Peminjaman', '19 Jan 2026'),
      ];
    } else if (filterAktif == 'Pengembalian') {
      return [
        _buildRiwayatCard('Azzura Selly', 'Pengembalian', '18 Jan 2026'),
        _buildRiwayatCard('Wafi Nazar', 'Pengembalian', '17 Jan 2026'),
      ];
    } else {
      return [
        _buildRiwayatCard('Salsadila Ariza', 'Peminjaman', '20 Jan 2026'),
        _buildRiwayatCard('Richo Ferdinan', 'Peminjaman', '19 Jan 2026'),
        _buildRiwayatCard('Azzura Selly', 'Pengembalian', '18 Jan 2026'),
        _buildRiwayatCard('Wafi Nazar', 'Pengembalian', '17 Jan 2026'),
      ];
    }
  }

  Widget _buildFilterButton(String label) {
    bool isActive = filterAktif == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          filterAktif = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFE91E63) : const Color(0xFFE7A9BD).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildRiwayatCard(String nama, String tipe, String tanggal) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nama,
                style: const TextStyle(
                  color: Color(0xFFE91E63),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(tanggal, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF7B1530),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  tipe,
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ],
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}