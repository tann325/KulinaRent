import 'package:flutter/material.dart';
import 'package:kulinarent_2026/petugas/screen/laporan_petugan_screen.dart';
import 'petugas_dashboard.dart';
import 'pengajuan_peminjaman_screen.dart';
import 'laporan_screen.dart';

class PengembalianScreen extends StatelessWidget {
  const PengembalianScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color headerPink = Color(0xFFE4A5B8);
    const Color bodyPink = Color(0xFFF5D1D1);
    // Warna pink soft untuk menggantikan grey
    const Color softPinkText = Color(0xFFD18DA0); 

    return Scaffold(
      backgroundColor: bodyPink,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: headerPink,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "KulinaRent",
                    style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Pengembalian",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari',
                    // Hint text sekarang warna pink soft
                    hintStyle: TextStyle(color: softPinkText),
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.pink, size: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // LIST DATA
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  _buildCard(
                    context,
                    id: "Kr 2331",
                    date: "27-Januari-2026",
                    name: "Rijaa",
                    classRoom: "X DKV 1",
                    items: "Oven 1, Mangkuk 1",
                    returnDate: "28-Januari-2026",
                    isLate: false,
                    softColor: softPinkText,
                  ),
                  _buildCard(
                    context,
                    id: "Kr 2330",
                    date: "25-Januari-2026",
                    name: "Richo",
                    classRoom: "XII RPL 1",
                    items: "sendok garpu 1, wajan 1",
                    returnDate: "28-Januari-2026",
                    isLate: true,
                    softColor: softPinkText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  static Widget _buildCard(BuildContext context,
      {required String id,
      required String date,
      required String name,
      required String classRoom,
      required String items,
      required String returnDate,
      required bool isLate,
      required Color softColor}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Warna ID dan Tanggal ganti ke pink soft
              Text(id, style: TextStyle(color: softColor, fontSize: 11)),
              Text(date, style: TextStyle(color: softColor, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 5),
          Text(name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFD81B60))),
          Text(classRoom,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
          Text(items,
              style: const TextStyle(fontSize: 12, color: Colors.pinkAccent)),
          const SizedBox(height: 8),
          // Warna teks pengembalian ganti ke pink soft
          Text("Pengembalian : $returnDate",
              style: TextStyle(color: softColor, fontSize: 11)),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: isLate ? const Color(0xFFFAD9E2) : const Color(0xFF7B1530),
                foregroundColor: isLate ? const Color(0xFFD81B60) : Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                side: isLate ? const BorderSide(color: Color(0xFFD81B60)) : null,
              ),
              child: Text(
                  isLate
                      ? "Konfirmasi Pengembalian Terlambat"
                      : "Konfirmasi Pengembalian",
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 2,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFF7B1530),
      // Icon yang tidak terpilih sekarang warna pink soft, bukan grey
      unselectedItemColor: const Color(0xFFD18DA0), 
      onTap: (index) {
        if (index == 0) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashboardPetugas()), (route) => false);
        } else if (index == 1) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PengajuanPeminjamanScreen()));
        } else if (index == 3) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LaporanScreen()));
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Peminjaman'),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Pengembalian'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Laporan'),
      ],
    );
  }
}