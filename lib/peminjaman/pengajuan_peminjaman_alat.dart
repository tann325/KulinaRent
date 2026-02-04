import 'package:flutter/material.dart';
import 'package:kulinarent_2026/peminjaman/alat_peminjam.dart';
import 'package:kulinarent_2026/peminjaman/dasboard_peminjaman.dart';
import 'package:kulinarent_2026/peminjaman/pengembalian_peminjaman_alat.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PengajuanPage extends StatelessWidget {
  const PengajuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D1D1),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: DataKeranjang.daftarPengajuan.isEmpty
                  ? const Center(
                      child: Text(
                        "Belum ada pengajuan.",
                        style: TextStyle(color: Color(0xFF7B1530), fontWeight: FontWeight.bold),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: DataKeranjang.daftarPengajuan.length,
                      itemBuilder: (context, index) {
                        final data = DataKeranjang.daftarPengajuan[index];
                        return _buildCardPengajuan(
                          noKr: data['noKr'] ?? '-',
                          nama: data['nama'] ?? '-',
                          tanggal: data['tanggal'] ?? '-',
                          kelas: data['kelas'] ?? '-',
                          daftarBarang: data['barang'] ?? '-',
                          status: data['status'] ?? 'Pending',
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFE3A5BB), 
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context), 
                child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
              ),
              const SizedBox(width: 8),
              const Text(
                'KulinaRent', 
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 26), 
            child: Text('Pengajuan Peminjaman', style: TextStyle(fontSize: 16, color: Colors.white70)),
          ),
        ],
      ),
    );
  }

  Widget _buildCardPengajuan({
    required String noKr, 
    required String nama, 
    required String tanggal, 
    required String kelas, 
    required String daftarBarang, 
    required String status
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, 
            children: [
              Text(noKr, style: const TextStyle(color: Color(0xFFE3A5BB), fontSize: 12)), 
              Text(tanggal, style: const TextStyle(color: Color(0xFFE3A5BB), fontSize: 12))
            ],
          ),
          const SizedBox(height: 8),
          Text(nama, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFD81B60))),
          Text(kelas, style: const TextStyle(color: Color(0xFFE3A5BB))),
          const SizedBox(height: 4),
          Text(daftarBarang, style: const TextStyle(color: Color(0xFFE3A5BB), fontSize: 13)),
          const SizedBox(height: 20),
          Container(
            width: double.infinity, 
            padding: const EdgeInsets.symmetric(vertical: 10), 
            decoration: BoxDecoration(color: const Color(0xFF7B1530), borderRadius: BorderRadius.circular(20)), 
            child: Center(
              child: Text(status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: 2, 
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DashboardPeminjam()));
        } else if (index == 1) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AlatPage()));
        } else if (index == 3) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PengembalianPage()));
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Alat'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Pengajuan'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Pengembalian'),
      ],
    );
  }
}

// INI BAGIAN YANG DIPERBAIKI: Tidak lagi null, tapi List kosong []
class DataKeranjang {
  static List<Map<String, dynamic>> daftarPengajuan = [];
}