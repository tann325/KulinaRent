import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailAktifitasScreen extends StatelessWidget {
  final String judul;
  final String petugas;
  final String peminjam;

  const DetailAktifitasScreen({
    super.key,
    required this.judul,
    required this.petugas,
    required this.peminjam,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C6CC),
      body: SafeArea(
        child: Column(
          children: [
            // ================= HEADER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
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
                      // BACK
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),

                      const SizedBox(width: 10),

                      const Text(
                        'KulinaRent',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  const Padding(
                    padding: EdgeInsets.only(left: 34),
                    child: Text(
                      'Detail Aktifitas',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // ================= CARD DETAIL =================
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
                    // Kode & Tanggal
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'KR-2331',
                          style: TextStyle(
                            color: Color(0xFFE7A9BD),
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '27 Januari 2026',
                          style: TextStyle(
                            color: Color(0xFFE7A9BD),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Nama Peminjam (DINAMIS)
                    Text(
                      peminjam,
                      style: const TextStyle(
                        color: Color(0xFFE91E63),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),

                    const SizedBox(height: 4),

                    // Judul Aktivitas
                    Text(
                      judul,
                      style: const TextStyle(
                        color: Color(0xFFE7A9BD),
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Badge Petugas
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7B1530),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Disetujui oleh : $petugas',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Item
                    const Text(
                      'Oven 1, Mangkuk 1',
                      style: TextStyle(
                        color: Color(0xFFE7A9BD),
                        fontSize: 14,
                      ),
                    ),

                    // Pengembalian
                    const Text(
                      'Pengembalian : 28 Januari 2026',
                      style: TextStyle(
                        color: Color(0xFFE7A9BD),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
