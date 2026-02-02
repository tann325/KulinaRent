import 'package:flutter/material.dart';
import 'package:kulinarent_2026/petugas/screen/laporan_petugan_screen.dart';
import 'petugas_dashboard.dart';
import 'penggembalian_screen.dart';
import 'laporan_screen.dart';

class PengajuanPeminjamanScreen extends StatelessWidget {
  const PengajuanPeminjamanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color headerPink = Color(0xFFE4A5B8);
    const Color bodyPink = Color(0xFFF5D1D1);
    const Color primaryMaroon = Color(0xFF7B1530);
    // Warna pink soft pengganti grey
    const Color softPinkText = Color(0xFFD18DA0);

    return Scaffold(
      backgroundColor: bodyPink,
      body: SafeArea(
        child: Column(
          children: [
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
                  Text('KulinaRent',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  Text('Pengajuan Peminjaman',
                      style: TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari',
                    // Hint cari pakai pink soft
                    hintStyle: TextStyle(color: softPinkText),
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.pink, size: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  PengajuanCard(
                    kode: '2331',
                    nama: 'Rijaa',
                    kelas: 'X DKV 1',
                    barang: 'Oven 1, Mangkuk 1',
                    tanggal: '27-Januari-2026',
                    softColor: softPinkText,
                  ),
                  PengajuanCard(
                    kode: '2330',
                    nama: 'Richo',
                    kelas: 'XII RPL 1',
                    barang: 'sendok garpu 1, wajan 1',
                    tanggal: '25-Januari-2026',
                    softColor: softPinkText,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryMaroon,
        // Navigasi yang tidak terpilih pakai pink soft
        unselectedItemColor: softPinkText,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPetugas()),
                (route) => false);
          }
          if (index == 2) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const PengembalianScreen()));
          }
          if (index == 3) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LaporanScreen()));
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

class PengajuanCard extends StatefulWidget {
  final String kode, nama, kelas, barang, tanggal;
  final Color softColor; // Tambah parameter warna
  const PengajuanCard(
      {super.key,
      required this.kode,
      required this.nama,
      required this.kelas,
      required this.barang,
      required this.tanggal,
      required this.softColor});

  @override
  State<PengajuanCard> createState() => _PengajuanCardState();
}

class _PengajuanCardState extends State<PengajuanCard> {
  String currentStatus = 'pending';
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Kode & Tanggal ganti pink soft
              Text('Kr ${widget.kode}',
                  style: TextStyle(fontSize: 11, color: widget.softColor)),
              Text(widget.tanggal,
                  style: TextStyle(fontSize: 11, color: widget.softColor)),
            ],
          ),
          const SizedBox(height: 5),
          Text(widget.nama,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFFD81B60))),
          Text(widget.kelas,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
          Text(widget.barang,
              style: const TextStyle(fontSize: 12, color: Colors.pinkAccent)),
          const SizedBox(height: 12),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    if (currentStatus == 'setuju') {
      return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: const Color(0xFF7B1530),
              borderRadius: BorderRadius.circular(20)),
          child: const Text('Peminjaman Disetujui',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)));
    } else if (currentStatus == 'tolak') {
      return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: const Color(0xFFF6D3DB),
              borderRadius: BorderRadius.circular(20)),
          child: const Text('Peminjaman Ditolak',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xFFD81B60),
                  fontSize: 12,
                  fontWeight: FontWeight.bold)));
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        _btnAction(
            'Tolak',
            const Color(0xFFF6D3DB),
            const Color(0xFFD81B60),
            () => setState(() => currentStatus = 'tolak')),
        const SizedBox(width: 8),
        _btnAction(
            'Setuju',
            const Color(0xFF7B1530),
            Colors.white,
            () => setState(() => currentStatus = 'setuju')),
      ]);
    }
  }

  Widget _btnAction(String label, Color bg, Color text, VoidCallback press) {
    return GestureDetector(
        onTap: press,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration:
                BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
            child: Text(label,
                style: TextStyle(
                    color: text, fontWeight: FontWeight.bold, fontSize: 12))));
  }
}