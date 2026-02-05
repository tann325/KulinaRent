import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
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
  final supabase = Supabase.instance.client;
  List<Map<String, dynamic>> daftarAlat = [];
  List<Map<String, dynamic>> alatFiltered = [];
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ambilDataAlat();
  }

  // AMBIL DATA DARI SUPABASE
  Future<void> _ambilDataAlat() async {
    try {
      if (!mounted) return;
      setState(() => isLoading = true); 
      
      final data = await supabase
          .from('alat')
          .select()
          .order('nama_alat', ascending: true);
      
      if (mounted) {
        setState(() {
          daftarAlat = List<Map<String, dynamic>>.from(data);
          alatFiltered = daftarAlat;
          isLoading = false;
        });
      }
    } catch (e) {
      _showSnackBar("Gagal memuat data: $e", isError: true);
      if (mounted) setState(() => isLoading = false);
    }
  }

  // EDIT STOK DI DATABASE
  Future<void> _editStok(int index) async {
    final alat = alatFiltered[index];
    TextEditingController editController = TextEditingController(text: alat['stok'].toString());
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text("Update Stok ${alat['nama_alat']}"),
        content: TextField(
          controller: editController,
          autofocus: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: "Jumlah Stok Baru"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE7A9BD),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
            ),
            onPressed: () async {
              final newStok = int.tryParse(editController.text) ?? alat['stok'];
              try {
                await supabase
                    .from('alat')
                    .update({'stok': newStok})
                    .eq('id_alat', alat['id_alat']);

                if (!mounted) return;
                Navigator.pop(context);
                _ambilDataAlat(); 
                _showSnackBar("Stok ${alat['nama_alat']} diperbarui!");
              } catch (e) {
                _showSnackBar("Gagal update: $e", isError: true);
              }
            },
            child: const Text("Simpan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // HAPUS ALAT DARI DATABASE
  Future<void> _hapusAlat(int index) async {
    final alat = alatFiltered[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Hapus Alat?"),
        content: Text("Yakin ingin menghapus ${alat['nama_alat']}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal")),
          TextButton(
            onPressed: () async {
              try {
                await supabase.from('alat').delete().eq('id_alat', alat['id_alat']);
                if (!mounted) return;
                Navigator.pop(context);
                _ambilDataAlat();
                _showSnackBar("Alat berhasil dihapus!");
              } catch (e) {
                _showSnackBar("Gagal menghapus: $e", isError: true);
              }
            },
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _filterAlat(String query) {
    setState(() {
      alatFiltered = daftarAlat
          .where((alat) => 
            alat['nama_alat'].toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
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
              child: _buildSearchAndActionRow(),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading 
                ? const Center(child: CircularProgressIndicator(color: Colors.pink))
                : RefreshIndicator(
                    onRefresh: _ambilDataAlat,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: alatFiltered.isEmpty 
                        ? const Center(child: Text("Data tidak ditemukan", style: TextStyle(color: Colors.pink)))
                        : GridView.builder(
                            itemCount: alatFiltered.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 0.75, 
                            ),
                            itemBuilder: (context, index) {
                              final item = alatFiltered[index];
                              return _AlatCard(
                                title: item['nama_alat'] ?? 'Tanpa Nama',
                                stok: item['stok'] ?? 0,
                                imagePath: item['gambar'] ?? '', 
                                onEdit: () => _editStok(index),
                                onDelete: () => _hapusAlat(index),
                              );
                            },
                          ),
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
      padding: const EdgeInsets.fromLTRB(25, 20, 20, 30),
      decoration: const BoxDecoration(
        color: Color(0xFFE7A9BD),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(45), bottomRight: Radius.circular(45)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("KulinaRent", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white)),
          SizedBox(height: 4),
          Text("Manajemen Alat", style: TextStyle(color: Colors.white70, fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildSearchAndActionRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 45,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
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
        const SizedBox(width: 8),
        _buildSmallIconButton(Icons.add, () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => const TambahAlatScreen()));
          _ambilDataAlat(); 
        }),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const KategoriScreen())),
          child: Container(
            height: 45, padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: const Color(0xFFE7A9BD), borderRadius: BorderRadius.circular(12)),
            child: const Center(child: Text("Kategori", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
          ),
        ),
      ],
    );
  }

  Widget _buildSmallIconButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45, width: 45,
        decoration: BoxDecoration(color: const Color(0xFFE7A9BD), borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) return;
        Widget nextScreen;
        switch (index) {
          case 1: nextScreen = const PenggunaScreen(); break;
          case 2: nextScreen = const DashboardScreen(); break;
          case 3: nextScreen = const RiwayatScreen(); break;
          case 4: nextScreen = const AktifitasScreen(); break;
          default: return;
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => nextScreen));
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen_outlined), label: 'Alat'),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Pengguna'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Aktivitas'),
      ],
    );
  }
}

class _AlatCard extends StatelessWidget {
  final String title;
  final int stok;
  final String imagePath;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _AlatCard({required this.title, required this.stok, required this.imagePath, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4, offset: const Offset(0, 2))]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(color: const Color(0xFFF1D3D6), borderRadius: BorderRadius.circular(15)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: _buildImage(imagePath),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pink, fontSize: 13), overflow: TextOverflow.ellipsis)),
              IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.edit, color: Colors.blue, size: 18),
                onPressed: onEdit,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Stok: $stok", style: const TextStyle(color: Color(0xFFE7A9BD), fontSize: 11, fontWeight: FontWeight.bold)),
              IconButton(
                constraints: const BoxConstraints(),
                padding: EdgeInsets.zero,
                icon: const Icon(Icons.delete_outline, color: Colors.red, size: 18),
                onPressed: onDelete,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String path) {
    if (path.isEmpty) {
      return const Center(child: Icon(Icons.image_not_supported, color: Colors.pink, size: 30));
    }

    if (path.startsWith('http')) {
      return Image.network(
        path, 
        fit: BoxFit.cover, 
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.red),
      );
    }

    // Memanggil dari folder assets
    return Image.asset(
      'assets/images/$path', 
      fit: BoxFit.cover, 
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[200],
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 24),
                const SizedBox(height: 4),
                Text(path, style: const TextStyle(fontSize: 8, color: Colors.black54), textAlign: TextAlign.center),
              ],
            ),
          ),
        );
      },
    );
  }
}