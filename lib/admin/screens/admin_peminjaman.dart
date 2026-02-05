import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminPeminjamanScreen extends StatefulWidget {
  const AdminPeminjamanScreen({super.key});

  @override
  State<AdminPeminjamanScreen> createState() => _AdminPeminjamanScreenState();
}

class _AdminPeminjamanScreenState extends State<AdminPeminjamanScreen> {
  final SupabaseClient supabase = Supabase.instance.client;

  // Mendapatkan aliran data peminjaman yang join dengan tabel users
  Stream<List<Map<String, dynamic>>> get _peminjamanStream {
    return supabase
        .from('peminjaman')
        .stream(primaryKey: ['id_peminjaman'])
        .order('created_at', ascending: false);
  }

  // Fungsi untuk update status peminjaman (CRUD - Update)
  Future<void> _updateStatus(int id, String status) async {
    try {
      await supabase
          .from('peminjaman')
          .update({'status': status})
          .eq('id_peminjaman', id);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status berhasil diubah menjadi $status')),
        );
      }
    } catch (e) {
      debugPrint('Error update: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5D1D1), // Warna pink background konsisten
      appBar: AppBar(
        title: const Text('Manajemen Peminjaman', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFE4A5B8),
        elevation: 0,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _peminjamanStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Tidak ada pengajuan peminjaman"));
          }

          final listPinjam = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: listPinjam.length,
            itemBuilder: (context, index) {
              final item = listPinjam[index];
              final int idPinjam = item['id_peminjaman'];
              final String status = item['status'];

              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: ListTile(
                    // Mengambil nama peminjam secara asinkron
                    title: FutureBuilder(
                      future: supabase.from('users').select('nama').eq('id_user', item['id_user']).single(),
                      builder: (context, userSnap) {
                        return Text(
                          userSnap.hasData ? userSnap.data!['nama'] : "Loading...",
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7B1530)),
                        );
                      },
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Status: $status", 
                             style: TextStyle(color: status == 'menunggu' ? Colors.orange : (status == 'disetujui' ? Colors.green : Colors.red))),
                        const SizedBox(height: 4),
                        // Menampilkan ID Peminjaman sebagai referensi
                        Text("ID Pinjam: #$idPinjam", style: const TextStyle(fontSize: 10)),
                      ],
                    ),
                    trailing: status == 'menunggu' 
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.cancel, color: Colors.red),
                            onPressed: () => _updateStatus(idPinjam, 'ditolak'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.check_circle, color: Colors.green),
                            onPressed: () => _updateStatus(idPinjam, 'disetujui'),
                          ),
                        ],
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: status == 'disetujui' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          status.toUpperCase(),
                          style: TextStyle(
                            fontSize: 10, 
                            fontWeight: FontWeight.bold,
                            color: status == 'disetujui' ? Colors.green : Colors.red
                          ),
                        ),
                      ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}