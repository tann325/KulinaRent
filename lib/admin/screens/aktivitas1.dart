import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Import Screens (Pastikan file-file ini ada di project kamu)
import 'package:kulinarent_2026/admin/screens/alat1.dart';
import 'package:kulinarent_2026/admin/screens/pengguna_screen.dart';
import 'package:kulinarent_2026/admin/screens/dashboard.dart';
import 'package:kulinarent_2026/admin/screens/riwayat_screen.dart';
import 'package:kulinarent_2026/admin/screens/detail_aktivitas.dart';

class AktifitasScreen extends StatefulWidget {
  const AktifitasScreen({super.key});

  @override
  State<AktifitasScreen> createState() => _AktifitasScreenState();
}

class _AktifitasScreenState extends State<AktifitasScreen> {
  final SupabaseClient supabase = Supabase.instance.client;

  // Real-time Stream: Mengambil data dari tabel log_aktivitas
  Stream<List<Map<String, dynamic>>> get _aktifitasStream {
    return supabase
        .from('log_aktivitas')
        .stream(primaryKey: ['id_log'])
        .order('waktu', ascending: false);
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
              // ================= HEADER =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: const Color(0xFFE7A9BD),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'KulinaRent',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Log Aktifitas Sistem',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ================= LIST DATA REALTIME =================
              Expanded(
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: _aktifitasStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Color(0xFFE91E63)));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("Belum ada aktifitas tercatat", style: TextStyle(color: Color(0xFF7B1530))),
                      );
                    }

                    final logs = snapshot.data!;

                    return ListView.builder(
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final log = logs[index];
                        
                        // FutureBuilder digunakan untuk mencari nama user berdasarkan id_user (UUID)
                        return FutureBuilder(
                          future: supabase
                              .from('users')
                              .select('nama')
                              .eq('id_user', log['id_user'])
                              .single(),
                          builder: (context, userSnapshot) {
                            String namaUser = userSnapshot.hasData 
                                ? userSnapshot.data!['nama'] 
                                : "Memuat nama...";
                            
                            return AktifitasCard(
                              judul: log['aktivitas'] ?? 'Aktifitas Tanpa Judul',
                              petugas: namaUser,
                              waktu: log['waktu'] ?? '-',
                              onTapDetail: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailAktifitasScreen(
                                      judul: log['aktivitas'],
                                      petugas: namaUser,
                                      peminjam: "-", // Sesuaikan jika ada relasi peminjam
                                    ),
                                  ),
                                );
                              },
                            );
                          },
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
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  Widget _buildBottomNav(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: 4,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color(0xFFE91E63),
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 4) return;
        Widget target;
        switch (index) {
          case 0: target = const AlatScreen(); break;
          case 1: target = const PenggunaScreen(); break;
          case 2: target = const DashboardScreen(); break;
          case 3: target = const RiwayatScreen(); break;
          default: return;
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => target));
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.soup_kitchen_outlined), label: 'Alat'),
        BottomNavigationBarItem(icon: Icon(Icons.people_outline), label: 'Pengguna'),
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.history_outlined), label: 'Riwayat'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment_outlined), label: 'Aktifitas'),
      ],
    );
  }
}

// ================= CARD COMPONENT =================
class AktifitasCard extends StatelessWidget {
  final String judul;
  final String petugas;
  final String waktu;
  final VoidCallback onTapDetail;

  const AktifitasCard({
    super.key,
    required this.judul,
    required this.petugas,
    required this.waktu,
    required this.onTapDetail,
  });

  @override
  Widget build(BuildContext context) {
    // Memformat string waktu agar lebih enak dibaca (opsional)
    String formattedTime = waktu.length > 16 ? waktu.substring(0, 16).replaceAll('T', ' ') : waktu;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE91E63), fontSize: 15),
                ),
                const SizedBox(height: 6),
                Text('Oleh: $petugas', style: const TextStyle(fontSize: 13, color: Colors.black87)),
                const SizedBox(height: 2),
                Text(formattedTime, style: const TextStyle(fontSize: 11, color: Colors.grey)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: onTapDetail,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF7B1530),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'Detail',
                style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}