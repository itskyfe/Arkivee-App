class Surat {

  String? id;
  String nomor;
  String perihal;
  DateTime tanggal;
  String asalTujuan;
  String kategori;
  String? userId;

  Surat({
    this.id,
    required this.nomor,
    required this.perihal,
    required this.tanggal,
    required this.asalTujuan,
    required this.kategori,
    this.userId,
  });

  factory Surat.fromJson(Map<String,dynamic> json){

    return Surat(

      id: json["id"],
      nomor: json["nomor_surat"],
      perihal: json["perihal"],
      tanggal: DateTime.parse(json["tanggal"]),
      asalTujuan: json["asal_tujuan"],
      kategori: json["kategori"],
      userId: json["user_id"]

    );

  }

  Map<String,dynamic> toJson(){

    return {

      "nomor_surat": nomor,
      "perihal": perihal,
      "tanggal": tanggal.toIso8601String(),
      "asal_tujuan": asalTujuan,
      "kategori": kategori,
      "user_id": userId

    };

  }

}