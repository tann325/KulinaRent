import 'package:flutter/material.dart';

class FormPengembalianPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const FormPengembalianPage({super.key, required this.data});

  @override
  State<FormPengembalianPage> createState() => _FormPengembalianPageState();
}

class _FormPengembalianPageState extends State<FormPengembalianPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D1D1),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDataPeminjam(),
                    const SizedBox(height: 15),
                    _buildLabelSection("Daftar Barang"),
                    const SizedBox(height: 10),
                    _buildItemBarangCard(),
                    const SizedBox(height: 10),
                    _buildItemBarangCard(),
                    const SizedBox(height: 15),
                    _buildDendaSection(),
                    const SizedBox(height: 20),
                    _buildConfirmButton(context),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: const BoxDecoration(
        color: Color(0xFFE3A5BB),
        borderRadius: BorderRadius.all(Radius.circular(35)),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TiveStuff', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('Pengembalian', style: TextStyle(fontSize: 16, color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDataPeminjam() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Warna Grey diganti ke Colors.pink atau shade pink
          _rowInfo("Nama", ": ${widget.data['nama']}"),
          _rowInfo("Email", ": ${widget.data['nama'].toString().toLowerCase()}@gmail.com"),
          _rowInfo("Kelas", ": ${widget.data['kelas']}"),
          const SizedBox(height: 10),
          const Text("Keterangan pengembalian :", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 13)),
          _rowInfo("Tanggal Peminjaman", ": ${widget.data['tanggal']}", isPinkStrong: true),
          _rowInfo("Tanggal Pengembalian", ": 28-Januari-2026", isPinkStrong: true),
        ],
      ),
    );
  }

  Widget _buildLabelSection(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFE3A5BB),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildItemBarangCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(color: const Color(0xFFE3A5BB).withOpacity(0.3), borderRadius: BorderRadius.circular(20)),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Nama Barang :", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 12)),
                _buildRoundedField("nama barang"),
                const SizedBox(height: 5),
                const Text("Keterangan Barang :", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 12)),
                _buildRoundedField("BAIK/RUSAK/KURANG"),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDendaSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.pink, width: 2),
      ),
      child: Column(
        children: [
          _rowInputDenda("Status pengembalian", "Terlambat/Tepat"),
          _rowInputDenda("Terlambat (hari)", "0"),
          _rowInputDenda("Denda Kerusakan", "0"),
          _rowInputDenda("Denda Terlambat", "0"),
          _rowInputDenda("TOTAL SELURUH", "0"),
        ],
      ),
    );
  }

  Widget _buildConfirmButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => Navigator.pop(context),
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          side: const BorderSide(color: Colors.pink, width: 2),
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        child: const Text("Konfirmasi Pengembalian", style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  // Helper untuk baris informasi dengan warna Pink
  Widget _rowInfo(String label, String value, {bool isPinkStrong = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 130, 
            child: Text(label, style: TextStyle(color: isPinkStrong ? Colors.pink : const Color(0xFFD81B60), fontSize: 13))
          ),
          Text(value, style: TextStyle(color: isPinkStrong ? Colors.pink : const Color(0xFFE3A5BB), fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildRoundedField(String hint) {
    return SizedBox(
      height: 35,
      child: TextField(
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 11, color: Colors.pink),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.pink.withOpacity(0.5)),
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.pink)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.pink)),
        ),
      ),
    );
  }

  Widget _rowInputDenda(String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.pink, fontWeight: FontWeight.bold, fontSize: 11)),
          SizedBox(
            width: 140, height: 35,
            child: TextField(
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: Colors.pink),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(color: Colors.pink.withOpacity(0.5)),
                contentPadding: EdgeInsets.zero,
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.pink)),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: const BorderSide(color: Colors.pink)),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.pink, // Ikon terpilih jadi pink
      unselectedItemColor: const Color(0xFFE3A5BB),
      currentIndex: 3,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
        BottomNavigationBarItem(icon: Icon(Icons.build), label: 'Alat'),
        BottomNavigationBarItem(icon: Icon(Icons.assignment), label: 'Pengajuan'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Pengembalian'),
      ],
    );
  }
}