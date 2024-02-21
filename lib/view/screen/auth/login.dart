import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/core/class/handlingdataview.dart';

import '../../../controller/auth/login_controller.dart';
import '../../../core/constant/imageasset.dart';
import '../../../core/functions/exit_app_alert.dart';
import '../../../core/functions/validinput.dart';
import '../../widget/auth/custom_login_button.dart';
import '../../widget/auth/custom_login_navigate_signup_text.dart';
import '../../widget/auth/custom_login_reset_password.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/login_image.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(LoginControllerImp());
    return WillPopScope(onWillPop: () async {
      return await showExitDialog();
    }, child: GetBuilder<LoginControllerImp>(
      builder: (controller) {
        return Scaffold(
            body: HandlingDataRequest(
          statusRequest: controller.statusRequest,
          widget: ListView(children: [
            BGImageLogin(
              assetName: AppImageAsset.bgLoginImage,
              child: Padding(
                padding: EdgeInsets.all(Get.width * 0.05), // 5% of screen width
                child: LayoutBuilder(
                  builder: (BuildContext context,
                          BoxConstraints viewportConstraints) =>
                      ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Form(
                          key: controller.formState,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                // width: Get.width * 0.85, // 80% of screen width
                                // height: Get.height * 0.09,
                                child: CustomTextFormAuth(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  myController: controller.email,
                                  labelText: "Email",
                                  prefixIcon: const Icon(Icons.email),
                                  valid: (val) {
                                    return validInput(val!, 5, 100, "email");
                                  },
                                ),
                              ),
                              SizedBox(
                                  height:
                                      Get.height * 0.02), // 2% of screen height
                              GetBuilder<LoginControllerImp>(
                                builder: (controller) => SizedBox(
                                    // width: Get.width * 0.85, // 80% of screen width
                                    // height: Get.height * 0.09,
                                    child: CustomTextFormAuth(
                                  textInputAction: TextInputAction.done,
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        controller.showPassword();
                                      },
                                      icon: Icon(
                                        controller.isShowPassword == true
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      )),
                                  obscureText: controller.isShowPassword,
                                  myController: controller.password,
                                  labelText: "Password",
                                  prefixIcon: const Icon(Icons.password),
                                  valid: (val) {
                                    return validInput(val!, 6, 40, "password");
                                  },
                                )),
                              ),
                              CustomResetPasswordTextLogin(onPressed: () {
                                controller.goToForgetPassword();
                              }),
                            ],
                          ),
                        ),
                        Column(
                          children: <Widget>[
                            SizedBox(
                                height:
                                    Get.height * 0.03), // 3% of screen height
                            CustomButtonLogin(
                                buttonName: "Login",
                                onPressed: () {
                                  controller.login();
                                }),
                            SizedBox(
                                height:
                                    Get.height * 0.05), // 5% of screen height
                            // const CustomTextGoogleLogin(),
                            SizedBox(height: Get.height * 0.01),
                            CustomNavigatorBetweenAuthPages(
                              text: 'Don\'t have an account? Sign Up',
                              onPressed: () {
                                controller.goToSignUp();
                              },
                            ),
                            SizedBox(height: Get.height * 0.02),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ));
      },
    ));
  }
}
