import 'package:flutter/material.dart';
import '../../shared/data_dummy.dart';

class AdminPeminjamanScreen extends StatelessWidget {
  const AdminPeminjamanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin - Peminjaman')),
      body: ListView.builder(
        itemCount: dataPeminjaman.length,
        itemBuilder: (context, index) {
          final item = dataPeminjaman[index];

          return Card(
            child: ListTile(
              title: Text(item.nama),
              subtitle: Text(item.alat),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      item.status = 'Ditolak';
                    },
                    child: const Text('Tolak'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      item.status = 'Disetujui';
                    },
                    child: const Text('Setuju'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
