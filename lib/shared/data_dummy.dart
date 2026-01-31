class Peminjaman {
  final String nama;
  final String alat;
  final String tanggal;
  String status;

  Peminjaman({
    required this.nama,
    required this.alat,
    required this.tanggal,
    this.status = 'Menunggu',
  });
}

List<Peminjaman> dataPeminjaman = [
  Peminjaman(
    nama: 'Rija',
    alat: 'X DKV 1',
    tanggal: '27 Januari 2026',
  ),
];
