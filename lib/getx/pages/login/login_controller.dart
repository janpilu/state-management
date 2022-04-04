import 'package:get/get.dart';
import 'package:state_management/getx/pages.dart';
import 'package:state_management/getx/repos/auth_repo.dart';
import 'package:state_management/helper.dart';

class LoginController extends GetxController {
  AuthRepo _auth = AuthRepo.instance;
  String? email;
  String? password;

  final visiblePassword = false.obs;
  final validInput = false.obs;
  final isLoading = false.obs;

  toggleVisibility() => visiblePassword.toggle();

  void handleEmailChanged(String? input) {
    email = input;
    validateInput();
  }

  void handlePasswordChanged(String? input) {
    password = input;
    validateInput();
  }

  void validateInput() {
    validInput.value = validateEmail(email) && validatePassword(password);
  }

  void _handleLogin() async {
    isLoading.value = true;
    await _auth.login(email: email!, password: password!);
    Get.toNamed(Routes.HOME);
    isLoading.value = false;
  }

  void Function()? getHandleLogin() {
    if (validInput.value) {
      return _handleLogin;
    }
    return null;
  }
}