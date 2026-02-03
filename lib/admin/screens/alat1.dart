import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/riwayat_screen.dart';
import 'package:kulinarent_2026/admin/screens/tambah_alat.dart';
import 'package:kulinarent_2026/admin/screens/tambah_kategori.dart';
import 'package:kulinarent_2026/admin/screens/dashboard.dart';
import 'package:kulinarent_2026/admin/screens/aktivitas1.dart'; 
import 'package:kulinarent_2026/admin/screens/pengguna_screen.dart';

class AlatScreen extends StatefulWidget {
  const AlatScreen({super.key});

  @override 
  State<AlatScreen> createState() => _AlatScreenState();
}

class _AlatScreenState extends State<AlatScreen> {
  final List<Map<String, String>> daftarAlat = [
    {'nama': 'Oven', 'spek': 'Spesifikasi', 'gambar': 'oven.png'},
    {'nama': 'Teflon', 'spek': 'Spesifikasi', 'gambar': 'teflon.png'},
    {'nama': 'Sutel', 'spek': 'Spesifikasi', 'gambar': 'sutel.png'},
    {'nama': 'Gelas', 'spek': 'Spesifikasi', 'gambar': 'gelas.png'},
    {'nama': 'Mangkok', 'spek': 'Spesifikasi', 'gambar': 'mangkok.png'},
    {'nama': 'Sendok/Garpu', 'spek': 'Spesifikasi', 'gambar': 'sendok.png'},
  ];

  List<Map<String, String>> alatFiltered = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    alatFiltered = daftarAlat;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterAlat(String query) {
    setState(() {
      alatFiltered = query.isEmpty
          ? daftarAlat
          : daftarAlat
              .where((alat) =>
                  alat['nama']!.toLowerCase().contains(query.toLowerCase()))
              .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D3D6),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildSearchAndFilter(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: alatFiltered.isEmpty
                    ? const Center(
                        child: Text(
                          "Alat tidak ditemukan",
                          style: TextStyle(color: Colors.pink),
                        ),
                      )
                    : GridView.builder(
                        itemCount: alatFiltered.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (context, index) {
                          return _AlatCard(
                            title: alatFiltered[index]['nama']!,
                            subtitle: alatFiltered[index]['spek']!,
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 25, right: 20, top: 20, bottom: 30),
      decoration: const BoxDecoration(
        color: Color(0xFFE7A9BD),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "KulinaRent",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.white),
          ),
          SizedBox(height: 4),
          Text(
            "Alat",
            style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterAlat,
              decoration: const InputDecoration(
                hintText: 'Cari Alat',
                prefixIcon: Icon(Icons.search, color: Color(0xFFE7A9BD)),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const TambahAlatScreen())),
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: const Color(0xFFE7A9BD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const KategoriScreen())),
          child: Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFE7A9BD),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                "Kategori",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      onTap: (index) {
        if (index == 0) return;
        final pages = [
          null,
          const PenggunaScreen(),
          const DashboardScreen(),
          const RiwayatScreen(),
          const AktifitasScreen(),
        ];
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => pages[index]!));
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.soup_kitchen_outlined), label: 'Alat'),
        BottomNavigationBarItem(
            icon: Icon(Icons.people_outline), label: 'Pengguna'),
        BottomNavigationBarItem(
            icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(
            icon: Icon(Icons.history), label: 'Riwayat'),
        BottomNavigationBarItem(
            icon: Icon(Icons.assignment_outlined), label: 'Aktivitas'),
      ],
    );
  }
}

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
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF1D3D6),
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Center(
                child: Icon(Icons.image, color: Colors.white, size: 40),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.pink)),
          Text(subtitle,
              style:
                  const TextStyle(color: Color(0xFFE7A9BD), fontSize: 12)),
        ],
      ),
    );
  }
}