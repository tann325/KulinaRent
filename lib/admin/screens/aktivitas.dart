import 'package:flutter/material.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  // Variabel untuk melacak filter mana yang aktif
  String filterAktif = 'Peminjaman'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C6CC), // Background Pink Lembut
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7A9BD), // Pink Header
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KulinaRent',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Riwayat',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // SEARCH BAR
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari Riwayat',
                  hintStyle: const TextStyle(color: Color(0xFFE7A9BD)),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // FILTER BUTTONS (Semua, Peminjaman, Pengembalian)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterButton('Semua'),
                  _buildFilterButton('Peminjaman'),
                  _buildFilterButton('Pengembalian'),
                ],
              ),

              const SizedBox(height: 20),

              // DAFTAR RIWAYAT
              Expanded(
                child: ListView(
                  children: filterAktif == 'Peminjaman' 
                  ? [
                      _buildRiwayatCard('Salsadila Ariza', 'Peminjaman'),
                      _buildRiwayatCard('Richo Ferdinan', 'Peminjaman'),
                    ]
                  : [
                      _buildRiwayatCard('Azzura Selly', 'Pengembalian'),
                      _buildRiwayatCard('Wafi Nazar', 'Pengembalian'),
                    ],
                ),
              ),
            ],
          ),
        ),
      ),

      // BOTTOM NAVBAR (Sama dengan Dashboard kamu)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 2, // Riwayat di index 2
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.black54,
        iconSize: 26,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen), label: 'Alat'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Pengguna'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Aktifitas'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  // Widget untuk tombol filter
  Widget _buildFilterButton(String label) {
    bool isActive = filterAktif == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          filterAktif = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFE91E63) : const Color(0xFFE7A9BD).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  // Widget untuk Kartu Riwayat
  Widget _buildRiwayatCard(String nama, String tipe) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            nama,
            style: const TextStyle(
              color: Color(0xFFE91E63), // Pink Tajam
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF7B1530), // Warna Maroon Badge
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              tipe,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}