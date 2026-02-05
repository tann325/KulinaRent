import 'package:flutter/material.dart';
import 'petugas_dashboard.dart';
import 'pengajuan_peminjaman_screen.dart';
import 'penggembalian_screen.dart' hide DashboardPetugas;

class LaporanScreen extends StatelessWidget {
  const LaporanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryMaroon = Color(0xFF7B1530);
    const Color softPink = Color(0xFFD18DA0); // Warna pink soft pengganti grey

    return Scaffold(
      backgroundColor: const Color(0xFFF5D1D1),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFFE4A5B8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Column( // IconButton sudah dihapus di sini
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('KulinaRent',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text('Laporan',
                      style: TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    // Icon laporan sekarang warna pink soft
                    Icon(Icons.description_outlined,
                        size: 80, color: softPink),
                    const SizedBox(height: 15),
                    const Text('Laporan Aktifitas',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFD81B60))),
                    const SizedBox(height: 8),
                    const Text('Rekapan Peminjaman &\nPengembalian Alat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 13, color: Colors.pinkAccent)),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryMaroon,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: const Text('Cetak Laporan',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryMaroon,
        unselectedItemColor: softPink, // Grey diganti pink soft
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPetugas()),
                (route) => false);
          }
          if (index == 1) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) => const PengajuanPeminjamanScreen()));
          }
          if (index == 2) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const PengembalianScreen()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), label: 'Peminjaman'),
          BottomNavigationBarItem(
              icon: Icon(Icons.swap_horiz), label: 'Pengembalian'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Laporan'),
        ],
      ),
    );
  }
}