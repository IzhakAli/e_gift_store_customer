import 'package:get/get.dart';
import 'package:store/core/constant/routes.dart';

import '../../core/class/statusrequest.dart';
import '../../core/functions/handlingdatacontroller.dart';
import '../../data/datasource/remote/auth/signupverifycode.dart';

abstract class VerifyCodeSignUpController extends GetxController {
  // checkCode();
  goToSuccessSignUpPage(String verificationCode);
  resend();
}

class VerifyCodeSignUpControllerImp extends VerifyCodeSignUpController {
  //backend stuff
  VerifyCodeSignUpData verifyCodeSignUpData = VerifyCodeSignUpData(Get.find());
  StatusRequest statusRequest = StatusRequest.none;
  String? email;
//end of back end

  // @override
  // checkCode() {}

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }

  @override
  resend() {
    verifyCodeSignUpData.resendData(email!);
  }

  @override
  goToSuccessSignUpPage(String verificationCode) async {
    statusRequest = StatusRequest.loading;
    update();
    var response =
        await verifyCodeSignUpData.postData(email!, verificationCode);
    print("===============================Controller $response");
    statusRequest = handlingData(response);
    if (StatusRequest.success == statusRequest) {
      if (response['status'] == "success") {
        Get.offAllNamed(AppRoute.successSignUp);
      } else {
        Get.defaultDialog(
            title: "Incorrect",
            middleText: "The verification code entered is not correct!");
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }
}
