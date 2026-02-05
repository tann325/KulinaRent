import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kulinarent_2026/admin/screens/dashboard.dart';
import 'package:kulinarent_2026/admin/screens/pengguna_screen.dart';
import 'package:kulinarent_2026/admin/screens/alat1.dart';
import 'package:kulinarent_2026/admin/screens/aktivitas1.dart';

class RiwayatScreen extends StatefulWidget {
  const RiwayatScreen({super.key});

  @override
  State<RiwayatScreen> createState() => _RiwayatScreenState();
}

class _RiwayatScreenState extends State<RiwayatScreen> {
  String filterAktif = 'Semua';
  final SupabaseClient supabase = Supabase.instance.client;

  // --- CRUD: DELETE DATA ---
  Future<void> _deleteRiwayat(int id) async {
    try {
      await supabase.from('peminjaman').delete().eq('id_peminjaman', id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data berhasil dihapus"), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal menghapus! Cek RLS Database"), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2C6CC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // HEADER
              _buildHeader(),
              const SizedBox(height: 15),

              // FILTER CHIPS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildFilterButton('Semua'),
                  _buildFilterButton('Peminjaman'),
                  _buildFilterButton('Pengembalian'),
                ],
              ),
              const SizedBox(height: 20),

              // LIST DATA (READ REALTIME)
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  // Mengambil data dari tabel peminjaman secara realtime
                  stream: supabase
                      .from('peminjaman')
                      .stream(primaryKey: ['id_peminjaman'])
                      .order('tanggal_pinjam', ascending: false),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("Data kosong. Pastikan RLS Disable & Realtime ON!"),
                      );
                    }

                    var listData = snapshot.data!;

                    // Logika Filter berdasarkan status
                    if (filterAktif == 'Peminjaman') {
                      listData = listData.where((d) => d['status'] == 'menunggu').toList();
                    } else if (filterAktif == 'Pengembalian') {
                      listData = listData.where((d) => d['status'] == 'selesai').toList();
                    }

                    return ListView.builder(
                      itemCount: listData.length,
                      itemBuilder: (context, index) {
                        final item = listData[index];
                        return _riwayatCard(
                          item['id_peminjaman'], // Kolom id_peminjaman
                          item['status'].toString(),
                          item['tanggal_pinjam'].toString(),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFFE7A9BD),
        borderRadius: BorderRadius.circular(25),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('KulinaRent', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
          Text('Riwayat & Aktivitas', style: TextStyle(fontSize: 18, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    bool active = filterAktif == label;
    return GestureDetector(
      onTap: () => setState(() => filterAktif = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFFE91E63) : const Color(0xFFE7A9BD),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _riwayatCard(int id, String tipe, String tanggal) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text("Order ID: #$id", style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE91E63))),
        subtitle: Text("Tanggal: ${tanggal.split('T')[0]}"),
        trailing: Wrap(
          spacing: 12,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFF7B1530), borderRadius: BorderRadius.circular(10)),
              child: Text(tipe, style: const TextStyle(color: Colors.white, fontSize: 10)),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.redAccent),
              onPressed: () => _deleteRiwayat(id),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: 3,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == 0) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AlatScreen()));
        if (index == 1) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PenggunaScreen()));
        if (index == 2) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
        if (index == 4) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AktifitasScreen()));
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen_outlined), label: 'Alat'),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Pengguna'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Aktifitas'),
      ],
    );
  }
}