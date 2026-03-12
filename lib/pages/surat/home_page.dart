import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/surat_controller.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/theme_controller.dart';

import '../../widgets/card_surat.dart';

import 'create_surat.dart';
import 'update_surat.dart';
import 'list_surat.dart';

import '../auth/login_page.dart';

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
    final auth = Get.put(AuthController());
    final theme = Get.put(ThemeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Arkivee",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),

        actions: [
          /// DARK MODE
          Obx(
            () => IconButton(
              icon: Icon(
                theme.isDark.value ? Icons.light_mode : Icons.dark_mode,
              ),

              onPressed: () {
                theme.toggleTheme();
              },
            ),
          ),

          /// LOGOUT
          IconButton(
            icon: const Icon(Icons.logout),

            onPressed: () async {
              /// RESET THEME KE LIGHT
              theme.resetTheme();

              await auth.logout();

              Get.offAll(() => const LoginPage());
            },
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const CreateSuratPage());
        },

        child: const Icon(Icons.add),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            /// STATISTIK
            Obx(
              () => Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff2F80ED), Color(0xff1C6ED5)],
                  ),

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

                        const SizedBox(height: 6),

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
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// HEADER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                const Text(
                  "Recently",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),

                TextButton(
                  onPressed: () {
                    Get.to(() => const ListSuratPage());
                  },

                  child: const Text("See All →"),
                ),
              ],
            ),

            const SizedBox(height: 10),

            /// LIST SURAT
            Expanded(
              child: Obx(() {
                if (controller.dataSurat.isEmpty) {
                  return const Center(child: Text("Belum ada surat"));
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
