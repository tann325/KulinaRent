import 'package:flutter/material.dart';
import 'package:kulinarent_2026/peminjaman/pengajuan_peminjaman_alat.dart';
import 'package:kulinarent_2026/peminjaman/pengembalian_peminjaman_alat.dart';

class DataKeranjang {
  static List<Map<String, String>> itemTerpilih = [];
  // Simulasi data untuk Pengajuan & Pengembalian
  static List<Map<String, dynamic>> daftarPengajuan = [
    {
      'noKr': 'Kr 2331',
      'nama': 'Rijaaa',
      'tanggal': '27-Januari-2026',
      'kelas': 'XII DKV 1',
      'barang': 'Oven 1, Mangkuk 1',
      'status': 'Menunggu persetujuan'
    }
  ];
}

class AlatPage extends StatefulWidget {
  const AlatPage({super.key});

  @override
  State<AlatPage> createState() => _AlatPageState();
}

class _AlatPageState extends State<AlatPage> {
  void tambahKeKeranjang(String namaAlat) {
    setState(() {
      DataKeranjang.itemTerpilih.add({'nama': namaAlat, 'jumlah': '1'});
    });
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$namaAlat ditambah!'), backgroundColor: const Color(0xFFE3A5BB)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D1D1),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildSearch(),
                    const SizedBox(height: 15),
                    _buildKategoriDropdown(),
                    const SizedBox(height: 20),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.65, 
                      children: [
                        _buildAlatCard('Oven', 'Spesifikasi'),
                        _buildAlatCard('Teflon', 'Spesifikasi'),
                        _buildAlatCard('Sutel', 'Spesifikasi'),
                        _buildAlatCard('Gelas', 'Spesifikasi'),
                        _buildAlatCard('Mangkuk', 'Spesifikasi'),
                        _buildAlatCard('Sendok/Garpu', 'Spesifikasi'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingCart(),
      bottomNavigationBar: _buildBottomNav(context, 1),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(color: const Color(0xFFE3A5BB), borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('KulinaRent', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('Alat', style: TextStyle(fontSize: 16, color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Cari Alat',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildKategoriDropdown() {
    return Align(
      alignment: Alignment.centerRight,
      child: PopupMenuButton<String>(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(color: const Color(0xFFE3A5BB), borderRadius: BorderRadius.circular(12)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.keyboard_arrow_down, color: Colors.white),
              SizedBox(width: 5),
              Text('Kategori', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        itemBuilder: (context) => [],
      ),
    );
  }

  Widget _buildAlatCard(String nama, String spek) {
    return GestureDetector(
      onTap: () => tambahKeKeranjang(nama),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Container(margin: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFF2C6CC), borderRadius: BorderRadius.circular(15)))),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 12), child: Text(nama, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE91E63)))),
            const Spacer(),
            const Padding(padding: EdgeInsets.all(10), child: Align(alignment: Alignment.bottomRight, child: Icon(Icons.add_circle_outline, color: Color(0xFFE3A5BB)))),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingCart() {
    return FloatingActionButton(
      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const KeranjangPage())),
      backgroundColor: const Color(0xFFE3A5BB),
      child: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
    );
  }

  Widget _buildBottomNav(BuildContext context, int index) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: index,
      onTap: (i) {
        if (i == 0) Navigator.popUntil(context, (route) => route.isFirst);
        if (i == 2) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PengajuanPage()));
        if (i == 3) Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PengembalianPage()));
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

// KeranjangPage tetap sama seperti kode sebelumnya milikmu
class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});
  @override
  Widget build(BuildContext context) { return Scaffold(body: Center(child: Text("Halaman Keranjang"))); }
}