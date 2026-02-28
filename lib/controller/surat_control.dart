import 'package:get/get.dart';
import '../models/surat_model.dart';

class SuratController extends GetxController {
  var dataSurat = <Surat>[].obs;

  // cek apakah nomor surat sudah dipakai
  // parameter "kecuali" dipakai saat update, supaya nomor surat miliknya sendiri tidak dianggap duplikat
  bool nomorSudahAda(String nomor, {Surat? kecuali}) {
    return dataSurat.any((s) => s.nomor == nomor && s != kecuali);
  }

  void tambah(Surat surat) {
    dataSurat.add(surat);
  }

  void hapus(Surat surat) {
    dataSurat.remove(surat);
  }

  void updateSurat(Surat surat, String nomor, String perihal, String tanggal,
      String asalTujuan, String kategori) {
    surat.nomor = nomor;
    surat.perihal = perihal;
    surat.tanggal = tanggal;
    surat.asalTujuan = asalTujuan;
    surat.kategori = kategori;
    dataSurat.refresh();
  }

  int get totalMasuk => dataSurat.where((s) => s.kategori == "Masuk").length;
  int get totalKeluar => dataSurat.where((s) => s.kategori == "Keluar").length;
  List<Surat> get recent => dataSurat.reversed.take(4).toList();
}