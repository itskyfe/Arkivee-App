import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/surat_control.dart';
import '../models/card_surat.dart';
import 'create_surat.dart';
import 'read_surat.dart';
import 'update_surat.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void konfirmasiDelete(controller, surat) {
    Get.defaultDialog(
      title: "Hapus Surat",
      middleText: "Apakah yakin ingin menghapus surat ini?",
      textCancel: "Batal",
      textConfirm: "Hapus",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        controller.hapus(surat);
        Get.back();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// CARD STATISTIK
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
                          Text(
                            "Surat Masuk: ${controller.totalMasuk}",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Surat Keluar: ${controller.totalKeluar}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),

                      Column(
                        children: [
                          const Text(
                            "Total Surat",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${controller.dataSurat.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )),

            const SizedBox(height: 20),

            /// HEADER RECENTLY
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Recently",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextButton(
                  onPressed: () => Get.to(() => const ListSuratPage()),
                  child: const Text("See All →"),
                ),
              ],
            ),

            const SizedBox(height: 8),

            /// LIST SURAT
            Expanded(
              child: Obx(() {

                if (controller.dataSurat.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        SizedBox(height: 16),

                        Text(
                          "Belum ada surat",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),

                        SizedBox(height: 8),

                        Text(
                          "Klik tombol + untuk menambahkan",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: controller.recent.length,
                  itemBuilder: (context, i) {

                    final surat = controller.recent[i];

                    return SuratCard(
                      surat: surat,

                      onEdit: () {
                        Get.to(() => UpdateSuratPage(surat));
                      },

                      onDelete: () {
                        konfirmasiDelete(controller, surat);
                      },

                      onTap: () {
                        Get.to(() => UpdateSuratPage(surat));
                      },
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}