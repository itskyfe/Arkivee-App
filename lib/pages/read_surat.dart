import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/surat_control.dart';
import '../models/card_surat.dart';
import '../models/page_header.dart';
import 'update_surat.dart';

class ListSuratPage extends StatelessWidget {
  const ListSuratPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SuratController>();

    return Scaffold(
      body: Column(
        children: [
          const PageHeader(title: "Your Letter"),
          Expanded(
            child: Obx(() => controller.dataSurat.isEmpty
                ? const Center(
                    child: Text("Belum ada surat.",
                        style: TextStyle(color: Colors.grey)),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.dataSurat.length,
                    itemBuilder: (context, i) {
                      final surat = controller.dataSurat[i];
                      return SuratCard(
                        surat: surat,
                        onTap: () => Get.to(() => UpdateSuratPage(surat)),
                        onDelete: () => controller.hapus(surat),
                      );
                    },
                  )),
          ),
        ],
      ),
    );
  }
}