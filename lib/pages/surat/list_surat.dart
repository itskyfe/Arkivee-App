import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/surat_controller.dart';
import '../../widgets/card_surat.dart';
import '../../widgets/page_header.dart';
import 'update_surat.dart';

class ListSuratPage extends StatefulWidget {
  const ListSuratPage({super.key});

  @override
  State<ListSuratPage> createState() => _ListSuratPageState();
}

class _ListSuratPageState extends State<ListSuratPage> {
  final controller = Get.find<SuratController>();

  String filterKategori = "Semua";
  String sortTanggal = "Terbaru";
  String searchText = "";

  List getFilteredList() {
    List list = controller.dataSurat.toList();

    /// SEARCH
    if (searchText.isNotEmpty) {
      list = list
          .where(
            (s) =>
                s.nomor.toLowerCase().contains(searchText.toLowerCase()) ||
                s.perihal.toLowerCase().contains(searchText.toLowerCase()),
          )
          .toList();
    }

    /// FILTER
    if (filterKategori == "Masuk") {
      list = list.where((s) => s.kategori == "Masuk").toList();
    }

    if (filterKategori == "Keluar") {
      list = list.where((s) => s.kategori == "Keluar").toList();
    }

    /// SORT
    list.sort((a, b) {
      if (sortTanggal == "Terbaru") {
        return b.tanggal.compareTo(a.tanggal);
      } else {
        return a.tanggal.compareTo(b.tanggal);
      }
    });

    return list;
  }

  void konfirmasiDelete(surat) {
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
    return Scaffold(
      body: Column(
        children: [
          const PageHeader(title: "Your Letter"),

          Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                /// SEARCH
                TextField(
                  decoration: InputDecoration(
                    hintText: "Cari nomor atau perihal surat...",

                    prefixIcon: const Icon(Icons.search),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  onChanged: (value) {
                    setState(() {
                      searchText = value;
                    });
                  },
                ),

                const SizedBox(height: 12),

                /// FILTER + SORT
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField(
                        value: filterKategori,

                        items: const [
                          DropdownMenuItem(
                            value: "Semua",
                            child: Text("Semua Surat"),
                          ),

                          DropdownMenuItem(
                            value: "Masuk",
                            child: Text("Surat Masuk"),
                          ),

                          DropdownMenuItem(
                            value: "Keluar",
                            child: Text("Surat Keluar"),
                          ),
                        ],

                        onChanged: (value) {
                          setState(() {
                            filterKategori = value!;
                          });
                        },

                        decoration: const InputDecoration(
                          labelText: "Filter",

                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: DropdownButtonFormField(
                        value: sortTanggal,

                        items: const [
                          DropdownMenuItem(
                            value: "Terbaru",
                            child: Text("Terbaru"),
                          ),

                          DropdownMenuItem(
                            value: "Terlama",
                            child: Text("Terlama"),
                          ),
                        ],

                        onChanged: (value) {
                          setState(() {
                            sortTanggal = value!;
                          });
                        },

                        decoration: const InputDecoration(
                          labelText: "Urutkan",

                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// LIST SURAT
                Obx(() {
                  List list = getFilteredList();

                  if (list.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 40),

                        child: Text("Tidak ada surat ditemukan"),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,

                    physics: const NeverScrollableScrollPhysics(),

                    itemCount: list.length,

                    itemBuilder: (context, i) {
                      final surat = list[i];

                      return SuratCard(
                        surat: surat,

                        onEdit: () {
                          Get.to(() => UpdateSuratPage(surat));
                        },

                        onDelete: () {
                          konfirmasiDelete(surat);
                        },
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
