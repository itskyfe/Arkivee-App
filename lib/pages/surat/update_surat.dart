import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/surat_controller.dart';
import '../../models/surat_model.dart';
import '../../widgets/page_header.dart';

class UpdateSuratPage extends StatefulWidget {
  final Surat surat;

  const UpdateSuratPage(this.surat, {super.key});

  @override
  State<UpdateSuratPage> createState() => _UpdateSuratPageState();
}

class _UpdateSuratPageState extends State<UpdateSuratPage> {
  final controller = Get.find<SuratController>();

  final formKey = GlobalKey<FormState>();

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
    tanggal = TextEditingController(
      text:
          "${widget.surat.tanggal.day}/${widget.surat.tanggal.month}/${widget.surat.tanggal.year}",
    );
    asalTujuan = TextEditingController(text: widget.surat.asalTujuan);

    kategori = widget.surat.kategori;
  }

  Future<void> pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: widget.surat.tanggal,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (hasil != null) {
      setState(() {
        tanggal.text = "${hasil.day}/${hasil.month}/${hasil.year}";
        widget.surat.tanggal = hasil;
      });
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

        /// VALIDASI DUPLIKAT NOMOR SURAT
        if (label == "Nomor Surat") {
          if (controller.nomorSudahAda(value, kecuali: widget.surat)) {
            return "Nomor surat sudah digunakan";
          }
        }

        return null;
      },
    );
  }

  void simpan() {
    if (!formKey.currentState!.validate()) return;

    Get.defaultDialog(
      title: "Simpan Surat",
      middleText: "Apakah data surat sudah benar?",
      textCancel: "Batal",
      textConfirm: "Simpan",
      confirmTextColor: Colors.white,
      buttonColor: Colors.blue,

      onConfirm: () {
        controller.updateSurat(
          Surat(
            id: widget.surat.id, // penting agar update bukan insert
            nomor: nomor.text,
            perihal: perihal.text,
            tanggal: widget.surat.tanggal,
            asalTujuan: asalTujuan.text,
            kategori: kategori,
            userId: widget.surat.userId,
          ),
        );

        Get.back();
        Get.back();

        Get.snackbar(
          "Berhasil",
          "Surat berhasil diperbarui",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      },
    );
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

              child: Form(
                key: formKey,

                child: Column(
                  children: [
                    inputField(nomor, "Nomor Surat"),
                    const SizedBox(height: 12),

                    inputField(perihal, "Perihal"),
                    const SizedBox(height: 12),

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

                    inputField(asalTujuan, "Asal / Tujuan"),
                    const SizedBox(height: 12),

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
