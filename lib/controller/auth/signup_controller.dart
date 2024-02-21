import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:store/core/class/statusrequest.dart';
import 'package:store/core/constant/routes.dart';
import 'package:store/data/datasource/remote/auth/signup.dart';

import '../../core/functions/handlingdatacontroller.dart';

abstract class SignUpController extends GetxController {
  signUp();
  goToLogin();
  // goToCheckEmail();
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController number;
  late TextEditingController password;
//used with backend
  StatusRequest statusRequest = StatusRequest.none;
  SignUpData signUpData = SignUpData(Get.find());

  List data = [];
  //end used with backend

  bool isShowPassword = true;

  showPassword() {
    isShowPassword = isShowPassword == true ? false : true;
    update();
  }

  @override
  signUp() async {
    if (formState.currentState!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await signUpData.postData(
          username.text, password.text, email.text, number.text);
      print("===============================Controller $response");
      statusRequest = handlingData(response);
      if (StatusRequest.success == statusRequest) {
        if (response['status'] == "success") {
          // data.addAll(response['data']);
          Get.offNamed(AppRoute.verifyCodeSignUp,
              arguments: {"email": email.text});
        } else {
          Get.defaultDialog(
              title: "Alert",
              middleText:
                  "The provided phone number or email address is already registered in our system");
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {
      print("Invalid");
    }
  }

  // goToCheckEmail() {
  //   Get.offNamed(AppRoute.verifyCodeSignUp);
  // }

  @override
  goToLogin() {
    Get.offNamed(AppRoute.login);
  }

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    number = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    number.dispose();
    password.dispose();
    super.dispose();
  }
}
