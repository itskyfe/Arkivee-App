import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/surat_model.dart';
import '../services/surat_service.dart';

class SuratController extends GetxController {
  final service = SuratService();

  var dataSurat = <Surat>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSurat();
  }

  Future fetchSurat() async {
    dataSurat.value = await service.getAll();
  }

  bool nomorSudahAda(String nomor, {Surat? kecuali}) {
    return dataSurat.any((s) => s.nomor == nomor && s != kecuali);
  }

  Future tambah(Surat surat) async {
    surat.userId = Supabase.instance.client.auth.currentUser!.id;

    await service.insert(surat);

    fetchSurat();
  }

  Future updateSurat(Surat surat) async {
    await service.update(surat);

    fetchSurat();
  }

  Future hapus(Surat surat) async {
    await service.delete(surat.id!);

    dataSurat.remove(surat);
  }

  int get totalMasuk => dataSurat.where((s) => s.kategori == "Masuk").length;

  int get totalKeluar => dataSurat.where((s) => s.kategori == "Keluar").length;

  List<Surat> get recent => dataSurat.take(4).toList();
}
