import 'package:flutter/material.dart';
import 'package:kulinarent_2026/peminjaman/pengajuan_peminjaman_alat.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kulinarent_2026/peminjaman/dasboard_peminjaman.dart';
import 'package:kulinarent_2026/peminjaman/pengajuan_peminjaman_alat.dart'; 
import 'package:kulinarent_2026/peminjaman/pengembalian_peminjaman_alat.dart';

class AlatPage extends StatefulWidget {
  const AlatPage({super.key});

  @override
  State<AlatPage> createState() => _AlatPageState();
}

class _AlatPageState extends State<AlatPage> {
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> daftarAlat = [];
  bool isLoading = true;

  final String projectUrl = "https://URL_PROJECT_KAMU.supabase.co"; 
  final String bucketName = "alat"; 

  @override
  void initState() {
    super.initState();
    _muatDataAlat();
  }

  Future<void> _muatDataAlat() async {
    try {
      setState(() => isLoading = true);
      final data = await supabase
          .from('alat')
          .select('*')
          .order('nama_alat', ascending: true);
      
      setState(() {
        daftarAlat = List<Map<String, dynamic>>.from(data);
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Error Load Alat: $e");
      if (mounted) setState(() => isLoading = false);
    }
  }

  void tambahKeKeranjang(String namaAlat) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$namaAlat ditambah ke keranjang!'), 
        backgroundColor: const Color(0xFFE3A5BB),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D1D1),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator(color: Colors.pink))
                  : RefreshIndicator(
                      onRefresh: _muatDataAlat,
                      color: Colors.pink,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            _buildSearch(),
                            const SizedBox(height: 15),
                            _buildKategoriDropdown(),
                            const SizedBox(height: 20),
                            GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 0.72, 
                              ),
                              itemCount: daftarAlat.length,
                              itemBuilder: (context, index) => _buildAlatCard(daftarAlat[index]),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context, 1),
    );
  }

  Widget _buildAlatCard(Map<String, dynamic> item) {
    final String imagePath = item['gambar'] ?? '';

    return GestureDetector(
      onTap: () => tambahKeKeranjang(item['nama_alat'] ?? 'Alat'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, 
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2C6CC),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: _buildImageLogic(imagePath),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                item['nama_alat'] ?? '-', 
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE91E63), fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              child: Text("Stok: ${item['stok'] ?? 0}", style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 12, bottom: 8), 
              child: Align(alignment: Alignment.bottomRight, child: Icon(Icons.add_circle, color: Color(0xFFE3A5BB), size: 30))
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageLogic(String path) {
    if (path.isEmpty) return const Center(child: Icon(Icons.image_not_supported, color: Colors.white, size: 30));
    if (path.startsWith('http')) {
      return Image.network(path, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white));
    }
    return Image.asset(
      'assets/images/$path',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        String fallbackUrl = "$projectUrl/storage/v1/object/public/$bucketName/$path";
        return Image.network(fallbackUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.white));
      },
    );
  }

  // HEADER SUDAH DIHAPUS ICON BACK-NYA
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
      decoration: BoxDecoration(color: const Color(0xFFE3A5BB), borderRadius: BorderRadius.circular(30)),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('KulinaRent', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
          Text('Daftar Alat', style: TextStyle(fontSize: 14, color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)]),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Cari Alat...',
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget _buildKategoriDropdown() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(color: const Color(0xFFE3A5BB), borderRadius: BorderRadius.circular(12)),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.filter_list, color: Colors.white, size: 18),
            SizedBox(width: 5),
            Text('Kategori', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  // BOTTOM NAV SUDAH BISA PINDAH LANGSUNG
  Widget _buildBottomNav(BuildContext context, int index) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      currentIndex: index,
      onTap: (i) {
        if (i == index) return; // Kalau klik menu yang sama, abaikan
        
        Widget page;
        switch (i) {
          case 0: page = const DashboardPeminjam(); break;
          case 1: page = const AlatPage(); break;
          case 2: page = const PengajuanPage(); break;
          case 3: page = const PengembalianPage(); break;
          default: page = const DashboardPeminjam();
        }

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
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