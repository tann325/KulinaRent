import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:kulinarent_2026/admin/screens/riwayat_screen.dart';
import 'package:kulinarent_2026/admin/screens/alat1.dart';
import 'package:kulinarent_2026/admin/screens/aktivitas1.dart'; 
import 'package:kulinarent_2026/admin/screens/dashboard.dart';

class PenggunaScreen extends StatefulWidget {
  const PenggunaScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PenggunaScreenState();
}

class _PenggunaScreenState extends State<PenggunaScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  String searchQuery = "";

  // --- DELETE PENGGUNA ---
  Future<void> _hapusPengguna(String id) async {
    try {
      await supabase.from('users').delete().eq('id_user', id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pengguna berhasil dihapus"), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Gagal menghapus! Periksa koneksi/RLS"), backgroundColor: Colors.red),
        );
      }
    }
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
            _buildSearchBar("Cari Nama atau Username"),
            const SizedBox(height: 20),
            
            // --- READ REALTIME ---
            Expanded(
              child: StreamBuilder<List<Map<String, dynamic>>>(
                stream: supabase.from('users').stream(primaryKey: ['id_user']),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text("Data Pengguna Kosong"));
                  }

                  var data = snapshot.data!;
                  if (searchQuery.isNotEmpty) {
                    data = data.where((u) => 
                      u['nama'].toString().toLowerCase().contains(searchQuery.toLowerCase()) ||
                      u['username'].toString().toLowerCase().contains(searchQuery.toLowerCase())
                    ).toList();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final user = data[index];
                      return _buildUserCard(
                        user['id_user'].toString(),
                        user['nama'] ?? 'Tanpa Nama',
                        user['username'] ?? '-',
                        user['role'] ?? 'peminjam'
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TambahPenggunaScreen())),
        backgroundColor: Colors.white,
        elevation: 2,
        child: const Icon(Icons.person_add_alt_1, color: Colors.pink, size: 30),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildSearchBar(String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: TextField(
          onChanged: (val) => setState(() => searchQuery = val),
          style: const TextStyle(color: Color(0xFF7B1530), fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: const Icon(Icons.search, color: Color(0xFFE7A9BD)),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12),
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(String id, String name, String username, String role) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.pink, fontSize: 16)),
              Text("@$username | $role", style: const TextStyle(color: Colors.pinkAccent, fontSize: 13)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.grey, size: 20),
            onPressed: () => _hapusPengguna(id),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title, String subtitle) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
      decoration: const BoxDecoration(
        color: Color(0xFFE7A9BD),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26, color: Colors.white)),
          Text(subtitle, style: const TextStyle(color: Colors.white70, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 1,
      selectedItemColor: Colors.pink,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == 1) return;
        switch (index) {
          case 0: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AlatScreen())); break;
          case 2: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen())); break;
          case 3: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const RiwayatScreen())); break;
          case 4: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AktifitasScreen())); break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen_outlined), label: 'Alat'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Pengguna'),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Aktifitas'),
      ],
    );
  }
}

// --- SCREEN TAMBAH PENGGUNA ---
class TambahPenggunaScreen extends StatefulWidget {
  const TambahPenggunaScreen({super.key});
  @override
  State<TambahPenggunaScreen> createState() => _TambahPenggunaScreenState();
}

class _TambahPenggunaScreenState extends State<TambahPenggunaScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  Future<void> _simpanKeSupabase() async {
    // Validasi sederhana
    if (nameController.text.isEmpty || emailController.text.isEmpty || usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Lengkapi semua data!")));
      return;
    }
    
    setState(() => isLoading = true);
    try {
      final supabase = Supabase.instance.client;
      
      // 1. Buat Akun di Supabase Auth
      final res = await supabase.auth.signUp(
        email: emailController.text.trim(),
        password: 'Password123!', 
      );

      if (res.user != null) {
        // 2. Simpan data ke tabel public.users
        await supabase.from('users').insert({
          'id_user': res.user!.id,
          'nama': nameController.text.trim(),
          'username': usernameController.text.trim(),
          'role': 'peminjam',
          'status': true,
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Berhasil menambah pengguna!")));
          Navigator.pop(context);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Gagal: $e"), backgroundColor: Colors.red));
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D3D6),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeaderTambah(),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    _buildInputField(nameController, "Nama Lengkap"),
                    const SizedBox(height: 15),
                    _buildInputField(usernameController, "Username"),
                    const SizedBox(height: 15),
                    _buildInputField(emailController, "Email"),
                    const SizedBox(height: 30),
                    isLoading 
                      ? const CircularProgressIndicator(color: Color(0xFF7B1530))
                      : ElevatedButton(
                          onPressed: _simpanKeSupabase,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF7B1530),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                          ),
                          child: const Text("Konfirmasi", style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderTambah() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25),
      decoration: const BoxDecoration(
        color: Color(0xFFE7A9BD), 
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white), 
            onPressed: () => Navigator.pop(context)
          ),
          const Text("Tambah Pengguna", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
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
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          border: InputBorder.none,
        ),
      ),
    );
  }
}