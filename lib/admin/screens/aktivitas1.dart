import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/detail_aktivitas.dart';
// Pastikan import ini sesuai dengan lokasi file DetailAktifitasScreen Anda
import 'package:kulinarent_2026/screens/detail_aktifitas_screen.dart';

class AktifitasScreen extends StatelessWidget {
  const AktifitasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C6CC), // Background Pink Lembut
      body: SafeArea(
        child: Column( // Disederhanakan agar padding tidak memotong header
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Color(0xFFE7A9BD),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KulinaRent',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Text(
                    'Aktifitas',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            // SEARCH BAR & LIST (Dibungkus Padding agar rapi)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Cari Aktifitas',
                        hintStyle: const TextStyle(color: Color(0xFFE7A9BD)),
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildAktifitasCard(context, 'Penambahan Pengguna', 'Petugas : Intan', 'Pengguna : Richo'),
                          _buildAktifitasCard(context, 'Pengajuan Peminjaman', 'Petugas : Intan', 'Peminjam : Rijaa'),
                          _buildAktifitasCard(context, 'Pengembalian', 'Petugas : Intan', 'Peminjam : Selly'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      
      // FLOATING ACTION BUTTON
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        // Hapus 'const' di sini karena Colors.magenta bukan constant
        child: const Icon(Icons.add, color: Colors.pink, size: 30), 
      ),

      // BOTTOM NAVBAR
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3, 
        selectedItemColor: Colors.pink,
        unselectedItemColor: Colors.black54,
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

  Widget _buildAktifitasCard(BuildContext context, String title, String petugas, String target) {
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
              Text(title, style: const TextStyle(color: Color(0xFFE91E63), fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(petugas, style: const TextStyle(color: Color(0xFFE7A9BD), fontSize: 13)),
              Text(target, style: const TextStyle(color: Color(0xFFE7A9BD), fontSize: 13)),
            ],
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (_) => const DetailAktifitasScreen())
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7B1530), 
              minimumSize: const Size(60, 30),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text('Detail', style: TextStyle(color: Colors.white, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}