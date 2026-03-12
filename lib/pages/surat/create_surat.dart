import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/surat_controller.dart';
import '../../models/surat_model.dart';
import '../../widgets/page_header.dart';

class CreateSuratPage extends StatefulWidget {
  const CreateSuratPage({super.key});

  @override
  State<CreateSuratPage> createState() => _CreateSuratPageState();
}

class _CreateSuratPageState extends State<CreateSuratPage> {
  final controller = Get.find<SuratController>();

  final formKey = GlobalKey<FormState>();

  final nomor = TextEditingController();
  final perihal = TextEditingController();
  final tanggal = TextEditingController();
  final asal = TextEditingController();

  String kategori = "Masuk";

  Future pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (hasil != null) {
      tanggal.text = "${hasil.day}/${hasil.month}/${hasil.year}";
    }
  }

  Widget inputField(TextEditingController ctrl, String label) {
    return TextFormField(
      controller: ctrl,

      decoration: InputDecoration(
        labelText: label,

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),

      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$label wajib diisi";
        }

        /// VALIDASI NOMOR SURAT DUPLIKAT
        if (label == "Nomor Surat") {
          if (controller.nomorSudahAda(value)) {
            return "Nomor surat sudah digunakan";
          }
        }

        return null;
      },
    );
  }

  void simpan() {
    if (!formKey.currentState!.validate()) return;

    controller.tambah(
      Surat(
        nomor: nomor.text,
        perihal: perihal.text,
        tanggal: DateTime.now(),
        asalTujuan: asal.text,
        kategori: kategori,
      ),
    );

    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const PageHeader(title: "Create A Letter"),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),

              child: Form(
                key: formKey,

                child: Column(
                  children: [
                    inputField(nomor, "Nomor Surat"),
                    const SizedBox(height: 12),

                    inputField(perihal, "Perihal"),
                    const SizedBox(height: 12),

                    /// TANGGAL
                    TextFormField(
                      controller: tanggal,
                      readOnly: true,

                      decoration: InputDecoration(
                        labelText: "Tanggal",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),

                        suffixIcon: IconButton(
                          icon: const Icon(Icons.calendar_today),
                          onPressed: pilihTanggal,
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Tanggal wajib diisi";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    inputField(asal, "Asal / Tujuan"),
                    const SizedBox(height: 12),

                    /// KATEGORI
                    DropdownButtonFormField(
                      value: kategori,

                      items: ["Masuk", "Keluar"]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),

                      onChanged: (v) {
                        setState(() {
                          kategori = v!;
                        });
                      },

                      decoration: InputDecoration(
                        labelText: "Kategori",

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,

                          padding: const EdgeInsets.symmetric(vertical: 14),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        onPressed: simpan,

                        child: const Text(
                          "Simpan",

                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
