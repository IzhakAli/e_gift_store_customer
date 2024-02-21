import 'package:get/get.dart';
import 'package:store/core/constant/routes.dart';

abstract class SuccessSignUpController {
  goToLogin();
}

class SuccessSignUpControllerImp extends SuccessSignUpController {
  @override
  goToLogin() {
    Get.offAllNamed(AppRoute.login);
  }
}
