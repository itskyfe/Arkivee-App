import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final service = AuthService();

  Future login(String email, String password) async {
    await service.login(email, password);
  }

  Future register(String email, String password) async {
    await service.register(email, password);
  }

  Future logout() async {
    await service.logout();
  }
}
