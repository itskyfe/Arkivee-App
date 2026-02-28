import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/surat_control.dart';
import '../models/surat_model.dart';
import '../models/page_header.dart';

class UpdateSuratPage extends StatefulWidget {
  final Surat surat;

  const UpdateSuratPage(this.surat, {super.key});

  @override
  State<UpdateSuratPage> createState() => _UpdateSuratPageState();
}

class _UpdateSuratPageState extends State<UpdateSuratPage> {
  final controller = Get.find<SuratController>();

  late TextEditingController nomor;
  late TextEditingController perihal;
  late TextEditingController tanggal;
  late TextEditingController asalTujuan;
  late String kategori;

  @override
  void initState() {
    super.initState();
    nomor = TextEditingController(text: widget.surat.nomor);
    perihal = TextEditingController(text: widget.surat.perihal);
    tanggal = TextEditingController(text: widget.surat.tanggal);
    asalTujuan = TextEditingController(text: widget.surat.asalTujuan);
    kategori = widget.surat.kategori;
  }

  // buka kalender dan isi field tanggal
  Future<void> pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (hasil != null) {
      tanggal.text =
          "${hasil.day.toString().padLeft(2, '0')}/${hasil.month.toString().padLeft(2, '0')}/${hasil.year}";
    }
  }

  Widget labelField(String label, Widget field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        field,
        const SizedBox(height: 12),
      ],
    );
  }

  Widget inputField(TextEditingController ctrl, String hint) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          controller: ctrl,
          decoration: InputDecoration(hintText: hint, border: InputBorder.none),
        ),
      ),
    );
  }

  void simpan() {
    if (nomor.text.isEmpty ||
        perihal.text.isEmpty ||
        tanggal.text.isEmpty ||
        asalTujuan.text.isEmpty) {
      Get.snackbar("Gagal", "Data tidak boleh kosong",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (controller.nomorSudahAda(nomor.text, kecuali: widget.surat)) {
      Get.snackbar("Gagal", "Nomor surat sudah digunakan",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    controller.updateSurat(
      widget.surat,
      nomor.text,
      perihal.text,
      tanggal.text,
      asalTujuan.text,
      kategori,
    );

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PageHeader(title: "Update A Letter"),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  labelField("Nomor Surat", inputField(nomor, "Masukkan nomor surat")),
                  labelField("Perihal", inputField(perihal, "Masukkan perihal")),

                  // field tanggal dengan tombol kalender
                  labelField(
                    "Tanggal Surat",
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: tanggal,
                                readOnly: true,
                                decoration: const InputDecoration(
                                  hintText: "dd/mm/yyyy",
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.calendar_today,
                                  color: Colors.blue),
                              onPressed: pilihTanggal,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  labelField("Asal / Tujuan", inputField(asalTujuan, "Masukkan asal atau tujuan")),

                  // dropdown kategori
                  labelField(
                    "Kategori Surat",
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButton<String>(
                          value: kategori,
                          isExpanded: true,
                          underline: const SizedBox(),
                          items: ["Masuk", "Keluar"]
                              .map((e) =>
                                  DropdownMenuItem(value: e, child: Text(e)))
                              .toList(),
                          onChanged: (v) => setState(() => kategori = v!),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: simpan,
                      child: const Text("Simpan", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}