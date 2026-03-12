import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final auth = Get.put(AuthController());

  bool obscure = true;
  bool loading = false;

  void register() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => loading = true);

    try {
      await auth.register(email.text.trim(), password.text.trim());

      Get.snackbar(
        "Berhasil",
        "Akun berhasil dibuat",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      /// OTOMATIS KE LOGIN
      Get.offAll(() => const LoginPage());
    } catch (e) {
      Get.snackbar(
        "Register gagal",
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
                    const Icon(Icons.person_add, size: 70, color: Colors.blue),

                    const SizedBox(height: 10),

                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 25),

                    /// EMAIL
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

                    /// PASSWORD
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

                    const SizedBox(height: 15),

                    /// CONFIRM PASSWORD
                    TextFormField(
                      controller: confirmPassword,
                      obscureText: obscure,

                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        prefixIcon: const Icon(Icons.lock),

                        filled: true,
                        fillColor: Colors.grey.shade100,

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Konfirmasi password wajib diisi";
                        }

                        if (value != password.text) {
                          return "Password tidak sama";
                        }

                        return null;
                      },
                    ),

                    const SizedBox(height: 25),

                    /// REGISTER BUTTON
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

                        onPressed: loading ? null : register,

                        child: loading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    /// LOGIN LINK
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },

                      child: const Text(
                        "Sudah punya akun? Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
