import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../surat/home_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final auth = Get.put(AuthController());

  bool loading = false;
  bool obscure = true;

  void login() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      await auth.login(email.text.trim(), password.text.trim());

      Get.offAll(() => const HomePage());
    } catch (e) {
      Get.snackbar(
        "Login gagal",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),

          child: Card(
            elevation: 8,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(24),

              child: Form(
                key: formKey,

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    const Icon(Icons.lock, size: 70, color: Colors.blue),

                    const SizedBox(height: 10),

                    const Text(
                      "Arkivee Login",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    TextFormField(
                      controller: email,

                      decoration: InputDecoration(
                        labelText: "Email",

                        prefixIcon: const Icon(Icons.email),

                        filled: true,
                        fillColor: Colors.grey.shade100,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Email wajib diisi";
                        }

                        if (!GetUtils.isEmail(value)) {
                          return "Format email tidak valid";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 15),

                    TextFormField(
                      controller: password,

                      obscureText: obscure,

                      decoration: InputDecoration(
                        labelText: "Password",

                        prefixIcon: const Icon(Icons.lock),

                        filled: true,
                        fillColor: Colors.grey.shade100,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),

                        suffixIcon: IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility : Icons.visibility_off,
                          ),

                          onPressed: () {
                            setState(() {
                              obscure = !obscure;
                            });
                          },
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Password wajib diisi";
                        }

                        if (value.length < 6) {
                          return "Password minimal 6 karakter";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,

                          padding: const EdgeInsets.symmetric(vertical: 14),

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),

                        onPressed: loading ? null : login,

                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextButton(
                      onPressed: () {
                        Get.to(() => const RegisterPage());
                      },

                      child: const Text("Belum punya akun? Register"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
