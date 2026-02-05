import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TambahAlatScreen extends StatefulWidget {
  const TambahAlatScreen({super.key});

  @override
  State<TambahAlatScreen> createState() => _TambahAlatScreenState();
}

class _TambahAlatScreenState extends State<TambahAlatScreen> {
  final SupabaseClient supabase = Supabase.instance.client;
  
  // Controller Input
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _stokController = TextEditingController();
  final TextEditingController _fotoController = TextEditingController();
  
  // State Variable
  int? _selectedKategoriId; 
  String? _selectedKondisi;
  List<Map<String, dynamic>> _kategoriList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchKategori(); 
  }

  // --- AMBIL KATEGORI DARI DB ---
  Future<void> _fetchKategori() async {
    try {
      final data = await supabase
          .from('kategori')
          .select('id_kategori, nama_kategori')
          .order('id_kategori', ascending: true);
          
      setState(() {
        _kategoriList = List<Map<String, dynamic>>.from(data);
      });
    } catch (e) {
      debugPrint("Gagal load kategori: $e");
    }
  }

  // --- SIMPAN DATA KE SUPABASE ---
  Future<void> _simpanAlat() async {
    if (_namaController.text.trim().isEmpty || 
        _selectedKategoriId == null || 
        _stokController.text.trim().isEmpty ||
        _selectedKondisi == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Lengkapi semua data, termasuk Kategori & Kondisi!")),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await supabase.from('alat').insert({
        'nama_alat': _namaController.text.trim(),
        'id_kategori': _selectedKategoriId,
        'stok': int.tryParse(_stokController.text) ?? 0,
        'kondisi': _selectedKondisi,
        'gambar': _fotoController.text.trim(),
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Alat Berhasil Ditambahkan!"), backgroundColor: Colors.green),
        );
        Navigator.pop(context, true); 
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Gagal Simpan: $e"), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

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
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel("Nama Alat:"),
                    _buildTextField("Nama alat...", _namaController),

                    _buildLabel("Kategori Alat:"),
                    _buildKategoriDropdown(),

                    _buildLabel("Stok Alat:"),
                    _buildTextField("Jumlah stok...", _stokController, isNumber: true),

                    _buildLabel("Kondisi Alat:"),
                    _buildDropdownField(
                      hint: "Pilih Kondisi",
                      value: _selectedKondisi,
                      items: ["Baik", "Rusak"],
                      onChanged: (val) => setState(() => _selectedKondisi = val),
                    ),

                    _buildLabel("Foto Alat (URL):"),
                    _buildTextField("Link gambar...", _fotoController),

                    const SizedBox(height: 40),
                    Center(
                      child: _isLoading 
                        ? const CircularProgressIndicator(color: Color(0xFF7A1C33))
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF7A1C33),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                            ),
                            onPressed: _simpanAlat,
                            child: const Text("SIMPAN", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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

  // --- WIDGET HELPER ---

  Widget _buildKategoriDropdown() {
    // List default jika database kategori masih kosong
    final List<Map<String, dynamic>> defaultKategori = [
      {'id_kategori': 1, 'nama_kategori': 'Alat Memasak'},
      {'id_kategori': 2, 'nama_kategori': 'Alat Menyajikan'},
    ];

    final displayList = _kategoriList.isEmpty ? defaultKategori : _kategoriList;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: const Color(0xFFE7A9BD), borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: _selectedKategoriId,
          isExpanded: true,
          hint: const Text("Pilih Kategori", style: TextStyle(color: Color(0xFFF2C6CC))),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          dropdownColor: const Color(0xFFE7A9BD),
          items: displayList.map((kat) {
            return DropdownMenuItem<int>(
              value: kat['id_kategori'],
              child: Text(kat['nama_kategori'], style: const TextStyle(color: Colors.white)),
            );
          }).toList(),
          onChanged: (val) => setState(() => _selectedKategoriId = val),
        ),
      ),
    );
  }

  Widget _buildDropdownField({required String hint, required String? value, required List<String> items, required Function(String?) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(color: const Color(0xFFE7A9BD), borderRadius: BorderRadius.circular(15)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text(hint, style: const TextStyle(color: Color(0xFFF2C6CC))),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          dropdownColor: const Color(0xFFE7A9BD),
          items: items.map((item) => DropdownMenuItem(value: item, child: Text(item, style: const TextStyle(color: Colors.white)))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFE7A9BD),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      ),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white), onPressed: () => Navigator.pop(context)),
          const Text('Tambah Alat', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 5),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7A1C33))),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller, {bool isNumber = false}) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFE7A9BD), borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFFF2C6CC)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(15),
        ),
      ),
    );
  }
}