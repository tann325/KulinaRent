import 'package:flutter/material.dart';

// Menggunakan StatefulWidget agar data list bisa diupdate secara realtime
class KategoriScreen extends StatefulWidget {
  const KategoriScreen({super.key});

  @override
  State<KategoriScreen> createState() => _KategoriScreenState();
}

class _KategoriScreenState extends State<KategoriScreen> {
  // 1. DATA SOURCE: List kategori awal
  List<String> daftarKategori = ["Alat Memasak", "Alat Menyajikan"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D3D6),
      
      // Tombol Tambah
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 50.0),
        child: FloatingActionButton(
          onPressed: () async {
            // 2. ALUR: Menunggu data balik dari halaman TambahKategori
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TambahKategoriScreen()),
            );

            // 3. LOGIC: Jika ada data baru yang dikirim balik, tambahkan ke list
            if (result != null && result is String && result.isNotEmpty) {
              setState(() {
                daftarKategori.add(result);
              });
            }
          },
          backgroundColor: const Color(0xFFE7A9BD),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: const Icon(Icons.add, color: Colors.black, size: 30),
        ),
      ),
      
      body: SafeArea(
        child: Column(
          children: [
            // HEADER CUSTOM (Sesuai Gambar KulinaRent)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              decoration: const BoxDecoration(
                color: Color(0xFFE7A9BD),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
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
                      Text('KulinaRent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
                      Text('Kategori', style: TextStyle(color: Colors.white, fontSize: 16, height: 0.9)),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // SEARCH BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: TextField(
                style: const TextStyle(color: Colors.pink),
                decoration: InputDecoration(
                  hintText: 'Cari Kategori',
                  hintStyle: const TextStyle(color: Color(0xFFE7A9BD), fontSize: 14),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFE7A9BD), width: 1.5),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // LIST KATEGORI DINAMIS
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                itemCount: daftarKategori.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: _buildKategoriItem(daftarKategori[index], index),
                  );
                },
              ),
            ),

            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildKategoriItem(String title, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, offset: const Offset(0, 2)),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.w500, fontSize: 16)),
          Row(
            children: [
              const Icon(Icons.edit_note, color: Colors.black54, size: 22),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  setState(() {
                    daftarKategori.removeAt(index);
                  });
                },
                child: const Icon(Icons.delete_outline, color: Colors.black54, size: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: const Color(0xFFF1D3D6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(Icons.soup_kitchen, "Alat", isActive: true),
          _navItem(Icons.people_outline, "Pengguna"),
          _navItem(Icons.history, "Riwayat"),
          _navItem(Icons.assignment_outlined, "Aktifitas"),
          _navItem(Icons.person_outline, "Profil"),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, {bool isActive = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: isActive ? Colors.black : Colors.white, size: 24),
        Text(label, style: TextStyle(color: isActive ? Colors.black : Colors.white, fontSize: 10)),
      ],
    );
  }
}

// --- HALAMAN TAMBAH KATEGORI ---
class TambahKategoriScreen extends StatefulWidget {
  const TambahKategoriScreen({super.key});

  @override
  State<TambahKategoriScreen> createState() => _TambahKategoriScreenState();
}

class _TambahKategoriScreenState extends State<TambahKategoriScreen> {
  // Controller untuk mengambil teks yang diketik
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D3D6),
      body: SafeArea(
        child: Column(
          children: [
            // Header (Sesuai Gambar)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              decoration: const BoxDecoration(
                color: Color(0xFFE7A9BD),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
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
                      Text('KulinaRent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
                      Text('Tambah Kategori', style: TextStyle(color: Colors.white, fontSize: 16, height: 0.9)),
                    ],
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 40),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nama Kategori:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _controller,
                    style: const TextStyle(color: Colors.pink),
                    decoration: InputDecoration(
                      hintText: 'Tambah Kategori',
                      hintStyle: const TextStyle(color: Colors.pinkAccent),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),

                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // MENGIRIM DATA BALIK ke KategoriScreen
                        Navigator.pop(context, _controller.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7A1B30),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Tambah", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
            
            const Spacer(),
            _buildStaticBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildStaticBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: const Color(0xFFF1D3D6),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.soup_kitchen, color: Colors.black, size: 24),
          Icon(Icons.people_outline, color: Colors.white, size: 24),
          Icon(Icons.history, color: Colors.white, size: 24),
          Icon(Icons.assignment_outlined, color: Colors.white, size: 24),
          Icon(Icons.person_outline, color: Colors.white, size: 24),
        ],
      ),
    );
  }
}