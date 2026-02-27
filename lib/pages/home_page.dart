import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/surat_control.dart';
import '../models/card_surat.dart';
import 'create_surat.dart';
import 'read_surat.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // daftarkan controller supaya bisa dipakai di semua halaman
    final controller = Get.put(SuratController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Arkivee",
          style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => Get.to(() => const CreateSuratPage()),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Obx = widget yang otomatis rebuild kalau data berubah
            Obx(() => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Surat Masuk: ${controller.totalMasuk}",
                              style: const TextStyle(color: Colors.white)),
                          const SizedBox(height: 8),
                          Text("Surat Keluar: ${controller.totalKeluar}",
                              style: const TextStyle(color: Colors.white)),
                        ],
                      ),
                      Column(
                        children: [
                          const Text("Total Surat",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            "${controller.dataSurat.length}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 48,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Recently",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () => Get.to(() => const ListSuratPage()),
                  child: const Text("See All →"),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Expanded(
              child: Obx(() => controller.dataSurat.isEmpty
                  ? const Center(
                      child: Text("Belum ada surat.",
                          style: TextStyle(color: Colors.grey)),
                    )
                  : ListView.builder(
                      itemCount: controller.recent.length,
                      itemBuilder: (context, i) =>
                          SuratCard(surat: controller.recent[i]),
                    )),
            ),
          ],
        ),
      ),
    );
  }
}