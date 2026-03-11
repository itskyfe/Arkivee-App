import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/surat_control.dart';
import '../models/surat_model.dart';
import '../models/page_header.dart';

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
  final asalTujuan = TextEditingController();

  String kategori = "Masuk";

  Future<void> pilihTanggal() async {

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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),

      validator: (value) {

        if (value == null || value.isEmpty) {
          return "$label wajib diisi";
        }

        /// CEK DUPLIKAT NOMOR SURAT
        if (label == "Nomor Surat") {
          if (controller.nomorSudahAda(value)) {
            return "Nomor surat sudah digunakan";
          }
        }

        return null;
      },
    );
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
                      initialValue: kategori,
                      items: ["Masuk", "Keluar"]
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ))
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

                        onPressed: () {

                          if (formKey.currentState!.validate()) {

                            controller.tambah(
                              Surat(
                                nomor: nomor.text,
                                perihal: perihal.text,
                                tanggal: tanggal.text,
                                asalTujuan: asalTujuan.text,
                                kategori: kategori,
                              ),
                            );

                            Get.back();
                          }
                        },

                        child: const Text(
                          "Simpan",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}