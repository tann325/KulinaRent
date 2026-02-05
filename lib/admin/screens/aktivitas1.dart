import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kulinarent_2026/admin/screens/alat1.dart';
import 'package:kulinarent_2026/admin/screens/detail_aktivitas.dart';
import 'package:kulinarent_2026/admin/screens/pengguna_screen.dart';
import 'package:kulinarent_2026/admin/screens/dashboard.dart';
import 'package:kulinarent_2026/admin/screens/riwayat_screen.dart';
import 'package:kulinarent_2026/admin/screens/riwayat_screen.dart';

class AktifitasScreen extends StatefulWidget {
  const AktifitasScreen({super.key});

  @override
  State<AktifitasScreen> createState() => _AktifitasScreenState();
}

class _AktifitasScreenState extends State<AktifitasScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C6CC), // ✅ TANPA MAROON
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // ================= HEADER =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
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
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Aktifitas',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // ================= SEARCH =================
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Aktifitas',
                  hintStyle: const TextStyle(color: Color(0xFFE91E63)),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon:
                      const Icon(Icons.search, color: Color(0xFFE91E63)),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        const BorderSide(color: Color(0xFFE91E63)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        const BorderSide(color: Color(0xFFE91E63)),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ================= LIST =================
              Expanded(
                child: ListView(
                  children: const [
                    AktifitasCard(
                      judul: 'Penambahan Pengguna',
                      petugas: 'Intan',
                      peminjam: 'Richo',
                    ),
                    AktifitasCard(
                      judul: 'Pengajuan Peminjaman',
                      petugas: 'Intan',
                      peminjam: 'Rija',
                    ),
                    AktifitasCard(
                      judul: 'Pengembalian',
                      petugas: 'Intan',
                      peminjam: 'Selly',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFE91E63),
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 4) return;
          switch (index) {
            case 0:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const AlatScreen()),
              );
              break;
            case 1:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PenggunaScreen()),
              );
              break;
            case 2:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const DashboardScreen()),
              );
              break;
            case 3:
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const RiwayatScreen()),
              );
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.soup_kitchen_outlined),
            label: 'Alat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Pengguna',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined),
            label: 'Aktifitas',
          ),
        ],
      ),
    );
  }
}

// ================= CARD =================
class AktifitasCard extends StatelessWidget {
  final String judul;
  final String petugas;
  final String peminjam;

  const AktifitasCard({
    super.key,
    required this.judul,
    required this.petugas,
    required this.peminjam,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                judul,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE91E63),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Petugas : $petugas',
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                'Peminjam : $peminjam',
                style: const TextStyle(fontSize: 12),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
             context,
               MaterialPageRoute(
               builder: (_) => DetailAktifitasScreen(
                judul: judul,
                 petugas: petugas,
                  peminjam: peminjam,
                 ),
                ),
              );
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFF7B1530),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Detail',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
