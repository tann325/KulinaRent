import 'package:flutter/material.dart';
import '../../shared/data_dummy.dart';

class PetugasPeminjamanScreen extends StatelessWidget {
  const PetugasPeminjamanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Petugas - Peminjaman')),
      body: ListView.builder(
        itemCount: dataPeminjaman.length,
        itemBuilder: (context, index) {
          final item = dataPeminjaman[index];

          return ListTile(
            title: Text(item.nama),
            subtitle: Text(item.alat),
            trailing: Text(item.status),
          );
        },
      ),
    );
  }
}
