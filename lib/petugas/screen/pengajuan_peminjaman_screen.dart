import 'package:flutter/material.dart';
import 'package:kulinarent_2026/petugas/screen/laporan_petugan_screen.dart';
import 'package:kulinarent_2026/petugas/screen/laporan_petugas_screen.dart';
import 'petugas_dashboard.dart';
import 'penggembalian_screen.dart' hide DashboardPetugas;
import 'laporan_petugas_screen.dart';

class PengajuanPeminjamanScreen extends StatelessWidget {
  const PengajuanPeminjamanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color headerPink = Color(0xFFE4A5B8);
    const Color bodyPink = Color(0xFFF5D1D1);
    const Color primaryMaroon = Color(0xFF7B1530);
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
            // SEARCH BAR
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
                    hintStyle: TextStyle(color: softPinkText),
                    border: InputBorder.none,
                    icon: Icon(Icons.search, color: Colors.pink, size: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // LIST PENGAJUAN
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  PengajuanCard(
                    kode: '2331',
                    nama: 'Rijaa',
                    kelas: 'X DKV 1',
                    barang: 'Oven 1x, Mangkuk 1x',
                    tanggal: '27-Januari-2026',
                    softColor: softPinkText,
                  ),
                  PengajuanCard(
                    kode: '2330',
                    nama: 'Richo',
                    kelas: 'XII RPL 1',
                    barang: 'Sendok Garpu 1x, Wajan 1x',
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
        unselectedItemColor: softPinkText,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPetugas()),
                (route) => false);
          } else if (index == 2) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const PengembalianScreen()));
          } else if (index == 3) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (_) => const LaporanScreen()));
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Peminjaman'),
          BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: 'Pengembalian'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Laporan'),
        ],
      ),
    );
  }
}

class PengajuanCard extends StatefulWidget {
  final String kode, nama, kelas, barang, tanggal;
  final Color softColor;
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

  // FUNGSI UNTUK MENAMPILKAN STRUK (MODAL BOTTOM SHEET)
  void _showStruk(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.88,
          decoration: const BoxDecoration(
            color: Color(0xFFF5D1D1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Column(
            children: [
              // Header Modal
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFFE4A5B8),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('KulinaRent', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                        Text('Detail Aktifitas', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // AREA STRUK PUTIH
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: Column(
                    children: [
                      const Text('KulinaRent', style: TextStyle(color: Color(0xFFD81B60), fontWeight: FontWeight.bold, fontSize: 20)),
                      const Text('JURUSAN TATA BOGA', style: TextStyle(color: Color(0xFFD18DA0), fontSize: 12, fontWeight: FontWeight.bold)),
                      const Text('SMK BRANTAS KARANGKATES', style: TextStyle(color: Color(0xFFD18DA0), fontSize: 12)),
                      const SizedBox(height: 25),
                      _rowStruk('Kode Peminjaman', widget.kode),
                      _rowStruk('Peminjaman', widget.nama),
                      _rowStruk('Tanggal Peminjaman', widget.tanggal),
                      _rowStruk('Tanggal Pengembalian', '29-Januari-2026'),
                      _rowStruk('Petugas', 'Intan'),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Daftar Alat', style: TextStyle(color: Color(0xFFD81B60), fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(widget.barang.replaceAll(', ', '\n'), 
                          style: const TextStyle(color: Color(0xFFD18DA0), fontSize: 13, height: 1.5)),
                      ),
                      const Divider(height: 40, thickness: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(color: Color(0xFFD81B60), fontWeight: FontWeight.bold)),
                          Text('${widget.barang.split(',').length} Alat', 
                            style: const TextStyle(color: Color(0xFFD81B60), fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // TOMBOL CETAK
              Padding(
                padding: const EdgeInsets.all(30),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF7B1530),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: const Text('Cetak Struk', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _rowStruk(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFFD18DA0), fontSize: 12)),
          Text(value, style: const TextStyle(color: Color(0xFFD18DA0), fontSize: 12)),
        ],
      ),
    );
  }

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
      return Column(
        children: [
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: const Color(0xFF7B1530),
                  borderRadius: BorderRadius.circular(20)),
              child: const Text('Peminjaman Disetujui',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold))),
          TextButton(
            onPressed: () => _showStruk(context),
            child: const Text('Lihat Struk', style: TextStyle(color: Color(0xFFD81B60), fontSize: 12)),
          )
        ],
      );
    } else if (currentStatus == 'tolak') {
      return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
              color: const Color(0xFFF6D3DB),
              borderRadius: BorderRadius.circular(20)),
          child: const Text('Peminjaman Ditolak',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFFD81B60), fontSize: 12, fontWeight: FontWeight.bold)));
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
        _btnAction('Tolak', const Color(0xFFF6D3DB), const Color(0xFFD81B60),
            () => setState(() => currentStatus = 'tolak')),
        const SizedBox(width: 8),
        _btnAction('Setuju', const Color(0xFF7B1530), Colors.white, () {
          setState(() => currentStatus = 'setuju');
          _showStruk(context); // Langsung muncul struk
        }),
      ]);
    }
  }

  Widget _btnAction(String label, Color bg, Color text, VoidCallback press) {
    return GestureDetector(
        onTap: press,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
            child: Text(label, style: TextStyle(color: text, fontWeight: FontWeight.bold, fontSize: 12))));
  }
}