import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/aktivitas1.dart';
import 'package:kulinarent_2026/admin/screens/dashboard.dart';
import 'package:kulinarent_2026/admin/screens/pengguna_screen.dart';

void main() {
  runApp(const MaterialApp(
    home: AlatScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

// -------------------------------------------------------------------------
// HALAMAN: ALAT (SESUAI GAMBAR)
// -------------------------------------------------------------------------
class AlatScreen extends StatefulWidget {
  const AlatScreen({super.key});
  @override
  State<AlatScreen> createState() => _AlatScreenState();
}

class _AlatScreenState extends State<AlatScreen> {
  // Data dummy untuk list alat
  final List<Map<String, String>> daftarAlat = [
    {'nama': 'Oven', 'spek': 'Spesifikasi'},
    {'nama': 'Teflon', 'spek': 'Spesifikasi'},
    {'nama': 'Sutel', 'spek': 'Spesifikasi'},
    {'nama': 'Gelas', 'spek': 'Spesifikasi'},
    {'nama': 'Mangkok', 'spek': 'Spesifikasi'},
    {'nama': 'Sendok/Garpu', 'spek': 'Spesifikasi'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan warna latar belakang pink muda di seluruh layar
      backgroundColor: const Color(0xFFF1D3D6), 
      body: SafeArea(
        child: Column(
          children: [
            // Header melengkung
            _buildHeader(context),
            
            const SizedBox(height: 20),
            
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: _buildSearchBar(),
            ),
            
            const SizedBox(height: 15),

            // Tombol Tambah (+) dan Dropdown Kategori
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
               mainAxisAlignment: MainAxisAlignment.start, // <<< PINDAH KE KIRI
               children: [
               _buildAddButton(),
                const SizedBox(width: 12),
               _buildDropdownKategori(),
                  ],
                ),
              ),
            ),

             
            const SizedBox(height: 20),

            // Grid Alat
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 0.72, // Menyesuaikan tinggi kartu agar pas
                ),
                itemCount: daftarAlat.length,
                itemBuilder: (context, index) => _AlatCard(
                  title: daftarAlat[index]['nama']!,
                  subtitle: daftarAlat[index]['spek']!,
                ),
              ),
            ),
          ],
        ),
      ),
      // Navigasi bawah custom
      bottomNavigationBar: _buildBottomNav(),
    );
  }

 Widget _buildHeader(BuildContext context) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
    decoration: const BoxDecoration(
      color: Color(0xFFE7A9BD),
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(45),
        bottomRight: Radius.circular(45),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ICON BACK
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 22),
        ),

        const SizedBox(width: 12),

        // TEXT (NAIK & KE KANAN)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "KulinaRent",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Alat",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Cari Alat',
          hintStyle: TextStyle(color: Color(0xFFE7A9BD)),
          prefixIcon: Icon(Icons.search, color: Color(0xFFE7A9BD)),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
Widget _buildAddButton() {
  return GestureDetector(
    onTap: () {
      // TODO: navigasi ke halaman tambah alat
    },
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE7A9BD),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: const Icon(
        Icons.add,
        color: Colors.white, // <<< DIGANTI PUTIH BIAR KELIATAN
        size: 26,
      ),
    ),
  );
}


  Widget _buildDropdownKategori() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE7A9BD),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        children: [
          Icon(Icons.keyboard_arrow_down, color: Colors.white),
          SizedBox(width: 8),
          Text(
            'Kategori',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

 Widget _buildBottomNav() {
  return BottomNavigationBar(
    currentIndex: 0, // Alat aktif
    selectedItemColor: Colors.pink,
    unselectedItemColor: Colors.white,
    backgroundColor: const Color(0xFFE7A9BD),
    type: BottomNavigationBarType.fixed,
    onTap: (index) {
      switch (index) {
        case 0:
          break; // Alat (diam)
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PenggunaScreen()),
          );
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DashboardScreen()),
          );
          break;
        case 3:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AktifitasScreen()),
          );
          break;
        case 4:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AktifitasScreen()),
          );
          break;
      }
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen), label: 'Alat'),
      BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Pengguna'),
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Dashboard'),
      BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
      BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Aktivitas'),
    ],
  );
}


  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: isActive ? Colors.pink : Colors.white, size: 26),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.pink : Colors.white,
            fontSize: 11,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

// -------------------------------------------------------------------------
// KOMPONEN KARTU ALAT
// -------------------------------------------------------------------------
class _AlatCard extends StatelessWidget {
  final String title;
  final String subtitle;
  const _AlatCard({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Area Gambar (Kotak Pink Muda)
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFF1D3D6),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Judul Alat
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pink, fontSize: 15),
          ),
          // Subtitle Spesifikasi
          Text(
            subtitle,
            style: const TextStyle(color: Color(0xFFE7A9BD), fontSize: 12),
          ),
          // Icon Edit & Hapus
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.edit_note_rounded, size: 24, color: Colors.black.withOpacity(0.5)),
              const SizedBox(width: 5),
              Icon(Icons.delete_outline_rounded, size: 22, color: Colors.black.withOpacity(0.5)),
            ],
          )
        ],
      ),
    );
  }
}