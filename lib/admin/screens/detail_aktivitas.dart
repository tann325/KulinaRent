import 'package:flutter/material.dart';

class DetailAktifitasScreen extends StatelessWidget {
  const DetailAktifitasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C6CC), // Background Pink Lembut
      body: SafeArea(
        child: Column(
          children: [
            // HEADER (Sama dengan AktifitasScreen tapi ganti subtitle)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: const BoxDecoration(
                color: Color(0xFFE7A9BD),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'KulinaRent',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Detail Aktifitas',
                      style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // CARD DETAIL (Putih Tengah)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row untuk Kode & Tanggal
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Kr 2331', style: TextStyle(color: Color(0xFFE7A9BD), fontSize: 13)),
                        Text('27-Januari-2026', style: TextStyle(color: Color(0xFFE7A9BD), fontSize: 13)),
                      ],
                    ),
                    const SizedBox(height: 10),
                    
                    // Nama Peminjam
                    const Text(
                      'Rijaa',
                      style: TextStyle(color: Color(0xFFE91E63), fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    
                    // Kelas/Detail
                    const Text(
                      'X DKV 1',
                      style: TextStyle(color: Color(0xFFE7A9BD), fontSize: 14),
                    ),
                    
                    const SizedBox(height: 15),

                    // Badge Disetujui Oleh
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7B1530), // Warna Merah Marun
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Disetujui Oleh : Intan',
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 15),

                    // Item yang dipinjam
                    const Text(
                      'Oven 1, Mangkuk 1',
                      style: TextStyle(color: Color(0xFFE7A9BD), fontSize: 14),
                    ),
                    
                    // Tanggal Pengembalian
                    const Text(
                      'Pengembalian : 28-Januari-2026',
                      style: TextStyle(color: Color(0xFFE7A9BD), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // BOTTOM NAVBAR (Sama dengan AktifitasScreen agar konsisten)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.black54,
        backgroundColor: Colors.white, // Menambah BG putih agar icon terlihat jelas
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
}