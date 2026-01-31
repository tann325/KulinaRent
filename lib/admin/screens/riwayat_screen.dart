import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/dashboard.dart';
import 'package:kulinarent_2026/admin/screens/pengguna_screen.dart';
import 'package:kulinarent_2026/admin/screens/alat1.dart';
import 'package:kulinarent_2026/admin/screens/aktivitas1.dart';

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
              // ================= HEADER =================
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

              // ================= SEARCH =================
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Riwayat',
                  hintStyle: const TextStyle(color: Color(0xFFE7A9BD)),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0xFFE7A9BD)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // ================= FILTER =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterButton('Semua'),
                  _buildFilterButton('Peminjaman'),
                  _buildFilterButton('Pengembalian'),
                ],
              ),

              const SizedBox(height: 20),

              // ================= LIST =================
              Expanded(
                child: ListView(children: _getFilteredList()),
              ),
            ],
          ),
        ),
      ),

      // ================= BOTTOM NAV (FINAL & SAMA) =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3, // RIWAYAT
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 3) return;

          switch (index) {
            case 0:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => const AlatScreen()));
              break;
            case 1:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const PenggunaScreen()));
              break;
            case 2:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const DashboardScreen()));
              break;
            case 4:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const AktifitasScreen()));
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.soup_kitchen_outlined), label: 'Alat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people_outline), label: 'Pengguna'),
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined), label: 'Aktifitas'),
        ],
      ),
    );
  }

  // ================= FILTER LOGIC =================
  List<Widget> _getFilteredList() {
    if (filterAktif == 'Peminjaman') {
      return [
        _riwayatCard('Salsadila Ariza', 'Peminjaman', '20 Jan 2026'),
        _riwayatCard('Richo Ferdinan', 'Peminjaman', '19 Jan 2026'),
      ];
    } else if (filterAktif == 'Pengembalian') {
      return [
        _riwayatCard('Azzura Selly', 'Pengembalian', '18 Jan 2026'),
        _riwayatCard('Wafi Nazar', 'Pengembalian', '17 Jan 2026'),
      ];
    } else {
      return [
        _riwayatCard('Salsadila Ariza', 'Peminjaman', '20 Jan 2026'),
        _riwayatCard('Richo Ferdinan', 'Peminjaman', '19 Jan 2026'),
        _riwayatCard('Azzura Selly', 'Pengembalian', '18 Jan 2026'),
        _riwayatCard('Wafi Nazar', 'Pengembalian', '17 Jan 2026'),
      ];
    }
  }

  Widget _buildFilterButton(String label) {
    bool active = filterAktif == label;
    return GestureDetector(
      onTap: () => setState(() => filterAktif = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color:
              active ? const Color(0xFFE91E63) : const Color(0xFFE7A9BD),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(label,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _riwayatCard(String nama, String tipe, String tanggal) {
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
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(nama,
                style: const TextStyle(
                    color: Color(0xFFE91E63),
                    fontWeight: FontWeight.bold)),
            Text(tanggal,
                style: const TextStyle(fontSize: 11, color: Colors.grey)),
            const SizedBox(height: 6),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFF7B1530),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(tipe,
                  style:
                      const TextStyle(color: Colors.white, fontSize: 10)),
            ),
          ]),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}
