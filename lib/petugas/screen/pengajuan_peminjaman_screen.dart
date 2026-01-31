import 'package:flutter/material.dart';

class PengajuanPeminjamanScreen extends StatelessWidget {
  const PengajuanPeminjamanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6D3DB), // pink muda (BUKAN maroon)
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7A9BD),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'KulinaRent',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Pengajuan Peminjaman',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            // SEARCH
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE91E63)),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Cari',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: Color(0xFFE91E63)),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // LIST
            Expanded(
              child: ListView(
                children: const [
                  PengajuanCard(
                    kode: 'Kr 2331',
                    nama: 'Rijaa',
                    kelas: 'X DKV 1',
                    status: 'Oven 1, Mengukir',
                    tanggal: '27 Januari 2026',
                  ),
                  PengajuanCard(
                    kode: 'Kr 2330',
                    nama: 'Richo',
                    kelas: 'XII RPL 1',
                    status: 'sendok capur, Loyang 1',
                    tanggal: '25 Januari 2026',
                  ),
                  PengajuanCard(
                    kode: 'Kr 2329',
                    nama: 'Selly',
                    kelas: 'XII TKR 6',
                    status: 'Teflon, Spatula',
                    tanggal: '23 Januari 2026',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ================= BOTTOM NAV =================
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: const Color(0xFF7B1530),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Peminjaman',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Pengembalian',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Laporan',
          ),
        ],
      ),
    );
  }
}

// ================= CARD =================
class PengajuanCard extends StatelessWidget {
  final String kode;
  final String nama;
  final String kelas;
  final String status;
  final String tanggal;

  const PengajuanCard({
    super.key,
    required this.kode,
    required this.nama,
    required this.kelas,
    required this.status,
    required this.tanggal,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                kode,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const Spacer(),
              Text(
                tanggal,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            nama,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFE91E63),
            ),
          ),
          Text(
            kelas,
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            status,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _actionButton('Tolak', Colors.grey.shade300, Colors.black),
              const SizedBox(width: 8),
              _actionButton(
                'Setuju',
                const Color(0xFF7B1530),
                Colors.white,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _actionButton(String text, Color bg, Color textColor) {
    return SizedBox(
      height: 30,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bg,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {},
        child: Text(
          text,
          style: TextStyle(fontSize: 12, color: textColor),
        ),
      ),
    );
  }
}
