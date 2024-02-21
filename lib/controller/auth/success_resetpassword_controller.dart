import 'package:get/get.dart';
import 'package:store/core/constant/routes.dart';

abstract class SuccessResetPasswordController {
  goToLogin();
}

class SuccessResetPasswordControllerImp extends SuccessResetPasswordController {
  @override
  goToLogin() {
    Get.offAllNamed(AppRoute.login);
  }
}
