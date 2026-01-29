import 'package:flutter/material.dart';

class TambahAlatScreen extends StatefulWidget {
  const TambahAlatScreen({super.key});

  @override
  State<TambahAlatScreen> createState() => _TambahAlatScreenState();
}

class _TambahAlatScreenState extends State<TambahAlatScreen> {
  // CONTROLLER untuk mengambil input teks
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();
  final TextEditingController _fotoController = TextEditingController();
  
  String? _selectedKategori;
  String? _selectedKondisi;

  @override
  void dispose() {
    _namaController.dispose();
    _stokController.dispose();
    _fotoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1D3D6),
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFE7A9BD),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('KulinaRent', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
                      Text('Tambah Alat', style: TextStyle(color: Colors.white, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Nama Alat:"),
                    _buildTextField("Nama Alat . . .", _namaController),

                    _buildLabel("Kategori Alat:"),
                    _buildDropdownField(
                      hint: "Kategori Alat . . .",
                      value: _selectedKategori,
                      items: ["Alat Memasak", "Alat Menyajikan"],
                      onChanged: (val) => setState(() => _selectedKategori = val),
                    ),

                    _buildLabel("Stok Alat:"),
                    _buildTextField("Stok Alat . . .", _stokController, isNumber: true),

                    _buildLabel("Kondisi Alat:"),
                    _buildDropdownField(
                      hint: "Kondisi Alat . . .",
                      value: _selectedKondisi,
                      items: ["Baik", "Rusak"],
                      onChanged: (val) => setState(() => _selectedKondisi = val),
                    ),

                    _buildLabel("Foto Alat (URL):"),
                    _buildTextField("Foto Alat . . .", _fotoController),

                    const SizedBox(height: 40),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7A1C33),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
                        ),
                        onPressed: () {
                          // LOGIKA KIRIM DATA BALIK
                          if (_namaController.text.isNotEmpty) {
                            Navigator.pop(context, _namaController.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Nama alat tidak boleh kosong!")),
                            );
                          }
                        },
                        child: const Text("Tambah", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15)),
    );
  }

  // UPDATE: Menerima Controller
  Widget _buildTextField(String hint, TextEditingController controller, {bool isNumber = false}) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFE7A9BD).withOpacity(0.9), borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Color(0xFF7A1C33), fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFF2C6CC), fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildDropdownField({required String hint, required String? value, required List<String> items, required Function(String?) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: const Color(0xFFE7A9BD).withOpacity(0.9), borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(color: Color(0xFFF2C6CC), fontSize: 14)),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          dropdownColor: const Color(0xFFE7A9BD),
          items: items.map((String item) => DropdownMenuItem(value: item, child: Text(item, style: const TextStyle(color: Colors.white)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}