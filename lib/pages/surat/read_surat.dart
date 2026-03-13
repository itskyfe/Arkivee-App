import 'package:flutter/material.dart';
import '../../models/surat_model.dart';

class ReadSuratPage extends StatelessWidget {
  final Surat surat;

  const ReadSuratPage(this.surat, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Detail Surat")),

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nomor: ${surat.nomor}"),
            const SizedBox(height: 10),

            Text("Perihal: ${surat.perihal}"),
            const SizedBox(height: 10),

            Text("Asal/Tujuan: ${surat.asalTujuan}"),
            const SizedBox(height: 10),

            Text("Kategori: ${surat.kategori}"),
          ],
        ),
      ),
    );
  }
}
