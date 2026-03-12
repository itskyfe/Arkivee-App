import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {

  final client = Supabase.instance.client;

  Future login(String email,String password) async{

    await client.auth.signInWithPassword(
      email: email,
      password: password
    );

  }

  Future register(String email,String password) async{

    await client.auth.signUp(
      email: email,
      password: password
    );

  }

  Future logout() async{

    await client.auth.signOut();

  }

}