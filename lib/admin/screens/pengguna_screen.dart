import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/riwayat_screen.dart';
import 'alat1.dart';
import 'aktivitas1.dart'; // Jika file ini masih digunakan, pastikan path benar
import 'dashboard.dart';

// DATA GLOBAL UNTUK SIMULASI DATABASE
List<Map<String, String>> globalListPengguna = [
  {'nama': 'Salsadilla Ariza', 'email': 'salsadilla@gmail.com'},
  {'nama': 'Richo Ferdinan', 'email': 'richacho@gmail.com'},
];

class PenggunaScreen extends StatefulWidget {
  const PenggunaScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PenggunaScreenState();
}

class _PenggunaScreenState extends State<PenggunaScreen> {
  List<Map<String, String>> displayedPengguna = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    displayedPengguna = List.from(globalListPengguna);
  }

  void _onSearchChanged(String query) {
    setState(() {
      if (query.isEmpty) {
        displayedPengguna = List.from(globalListPengguna);
      } else {
        displayedPengguna = globalListPengguna
            .where((user) =>
                user['nama']!.toLowerCase().contains(query.toLowerCase()) ||
                user['email']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _hapusPengguna(int index) {
    setState(() {
      Map<String, String> userTerhapus = displayedPengguna[index];
      globalListPengguna.remove(userTerhapus);
      displayedPengguna.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D3D6),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader("KulinaRent", "Pengguna"),
            const SizedBox(height: 20),
            _buildSearchBar("Cari Pengguna"),
            const SizedBox(height: 20),
            Expanded(
              child: displayedPengguna.isEmpty
                  ? const Center(
                      child: Text("Pengguna tidak ditemukan", 
                      style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold)))
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      itemCount: displayedPengguna.length,
                      itemBuilder: (context, index) {
                        return _buildUserCard(
                          index,
                          displayedPengguna[index]['nama']!,
                          displayedPengguna[index]['email']!,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahPenggunaScreen()),
          );

          if (result != null && result is Map<String, String>) {
            setState(() {
              globalListPengguna.add(result);
              _onSearchChanged(_searchController.text); 
            });
          }
        },
        backgroundColor: Colors.white,
        elevation: 2,
        child: const Icon(Icons.person_add_alt_1, color: Colors.pink, size: 30),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 30),
      decoration: const BoxDecoration(
        color: Color(0xFFE7A9BD),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildSearchBar(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: _searchController,
          onChanged: _onSearchChanged,
          style: const TextStyle(color: Color(0xFF7B1530), fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Color(0xFFE7A9BD)),
            prefixIcon: const Icon(Icons.search, color: Color(0xFFE7A9BD)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(int index, String name, String email) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pink, fontSize: 16)),
              Text(email, style: const TextStyle(color: Colors.pinkAccent, fontSize: 13)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.grey, size: 20),
            onPressed: () => _hapusPengguna(index),
          ),
        ],
      ),
    );
  }

  // --- PERBAIKAN BOTTOM NAV DISINI ---
  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1, // Pengguna di Index 1
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == 1) return;
        switch (index) {
          case 0: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AlatScreen())); break;
          case 1: /* Sudah di Pengguna */ break;
          case 2: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen())); break;
          case 3: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RiwayatScreen())); break;
          case 4: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AktifitasScreen())); break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen_outlined), label: 'Alat'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Pengguna'), // Terpilih (People tebal)
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Aktifitas'),
      ],
    );
  }
}

// --- SCREEN TAMBAH PENGGUNA (TETAP SAMA) ---
class TambahPenggunaScreen extends StatefulWidget {
  const TambahPenggunaScreen({super.key});
  @override State<TambahPenggunaScreen> createState() => _TambahPenggunaScreenState();
}

class _TambahPenggunaScreenState extends State<TambahPenggunaScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D3D6),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeaderTambah(),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nama Pengguna:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildInputField(nameController, "Masukkan Nama"),
                  const SizedBox(height: 20),
                  const Text("Email Pengguna:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  _buildInputField(emailController, "Masukkan Email"),
                  const SizedBox(height: 40),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty && emailController.text.isNotEmpty) {
                          Navigator.pop(context, {
                            'nama': nameController.text,
                            'email': emailController.text,
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF7B1530),
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text("Konfirmasi", style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderTambah() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
      decoration: const BoxDecoration(
        color: Color(0xFFE7A9BD),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
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
              Text("KulinaRent", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
              Text("Tambah Pengguna", style: TextStyle(color: Colors.white70, fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: Color(0xFF7B1530), fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.pink.withOpacity(0.3)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        ),
      ),
    );
  }
}