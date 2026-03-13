import '../config/supabase_config.dart';
import '../models/surat_model.dart';

class SuratService {
  final client = SupabaseConfig.client;

  Future<List<Surat>> getAll() async {
    final userId = client.auth.currentUser!.id;

    final data = await client
        .from("surat")
        .select()
        .eq("user_id", userId)
        .order("tanggal", ascending: false);

    return (data as List).map((e) => Surat.fromJson(e)).toList();
  }

  Future insert(Surat surat) async {
    await client.from("surat").insert(surat.toJson());
  }

  Future update(Surat surat) async {
    await client.from("surat").update(surat.toJson()).eq("id", surat.id!);
  }

  Future delete(String id) async {
    await client.from("surat").delete().eq("id", id);
  }
}
