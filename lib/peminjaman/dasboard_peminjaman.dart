import 'package:flutter/material.dart';
import 'package:kulinarent_2026/admin/screens/login_page.dart'; 
import 'package:kulinarent_2026/peminjaman/alat_peminjam.dart';
import 'package:kulinarent_2026/peminjaman/pengajuan_peminjaman_alat.dart';
import 'package:kulinarent_2026/peminjaman/pengembalian_peminjaman_alat.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardPeminjam extends StatelessWidget {
  const DashboardPeminjam({super.key});

  static List<Map<String, String>> keranjangPilihan = [];

  void _showLogoutDialog(BuildContext context) {
    final TextEditingController userController = TextEditingController();
    final TextEditingController roleController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent, 
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
            ),
            child: SingleChildScrollView( 
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2C6CC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      "KulinaRent\nPeminjam",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7B1530), fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildInputPopup("UserName :", "Masukkan username", userController),
                  const SizedBox(height: 12),
                  _buildInputPopup("Role :", "Masukkan role", roleController),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade200), borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(color: const Color(0xFFF2C6CC), borderRadius: BorderRadius.circular(12)),
                          child: const Text("Keluar aplikasi", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 12),
                        const Text("Anda harus mengisi data dengan benar untuk logout!", textAlign: TextAlign.center, style: TextStyle(fontSize: 11, color: Colors.black54)),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text("Batal", style: TextStyle(color: Colors.grey)))),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (userController.text.isNotEmpty && roleController.text.toLowerCase() == "peminjam") {
                                    keranjangPilihan.clear();
                                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data tidak sesuai!"), backgroundColor: Colors.redAccent));
                                  }
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFF5A5A), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                                child: const Text("Logout", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputPopup(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.only(left: 4, bottom: 4), child: Text(label, style: const TextStyle(fontSize: 12, color: Colors.black54))),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFE7A9BD))),
          ),
          style: const TextStyle(color: Color(0xFFE7A9BD), fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D1D1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: const Color(0xFFE3A5BB), borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('KulinaRent', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                          Text('Dashboard', style: TextStyle(fontSize: 16, color: Colors.white70)),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => _showLogoutDialog(context),
                        child: const CircleAvatar(backgroundColor: Colors.white, radius: 20, child: Icon(Icons.person, color: Color(0xFFE3A5BB))),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1.2,
                  children: [
                    _buildStatCard('Pengguna Aktif', '7'),
                    _buildStatCard('Jumlah Alat', '10'),
                    _buildStatCard('Alat Tersedia', '7'),
                    _buildStatCard('Alat Dipinjam', '7'),
                  ],
                ),
                const SizedBox(height: 25),
                const Text('Riwayat Peminjaman:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 15),
                _buildHistoryItem('Peminjaman 02', '10.34 20 Januari 2026'),
                _buildHistoryItem('Peminjaman 01', '08.20 15 Januari 2026'),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: const TextStyle(color: Color(0xFFE91E63), fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 10),
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFFE91E63))),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const Icon(Icons.check_circle_outline, color: Colors.green, size: 35),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFFE91E63))),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      onTap: (index) {
        if (index == 1) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const AlatPage()));
        } else if (index == 2) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PengajuanPage()));
        } else if (index == 3) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PengembalianPage()));
        }
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