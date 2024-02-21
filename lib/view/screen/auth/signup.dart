import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/auth/signup_controller.dart';
import 'package:store/core/constant/imageasset.dart';
import 'package:store/core/functions/validinput.dart';

import '../../../core/class/handlingdataview.dart';
import '../../../core/functions/exit_app_alert.dart';
import '../../widget/auth/custom_login_button.dart';
import '../../widget/auth/custom_login_navigate_signup_text.dart';
import '../../widget/auth/customtextformauth.dart';
import '../../widget/auth/login_image.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async {
      return await showExitDialog();
    }, child: Scaffold(body: GetBuilder<SignUpControllerImp>(
      builder: (signUpControllerImp) {
        return HandlingDataRequest(
            statusRequest: signUpControllerImp.statusRequest,
            widget: ListView(
              children: [
                BGImageLogin(
                  assetName: AppImageAsset.bgSignUpImage,
                  child: Padding(
                    padding:
                        EdgeInsets.all(Get.width * 0.05), // 5% of screen width
                    child: Form(
                      key: signUpControllerImp.formState,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(
                                // width: Get.width * 0.85, // 80% of screen width
                                // height: Get.height * 0.09,
                                child: CustomTextFormAuth(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.name,
                                  myController: signUpControllerImp.username,
                                  labelText: "Username",
                                  prefixIcon: const Icon(Icons.person),
                                  valid: (val) {
                                    return validInput(val!, 5, 50, "username");
                                  },
                                ),
                              ),
                              SizedBox(
                                  height:
                                      Get.height * 0.02), // 2% of screen height
                              SizedBox(
                                // width: Get.width * 0.85, // 80% of screen width
                                // height: Get.height * 0.09,
                                child: CustomTextFormAuth(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.emailAddress,
                                  myController: signUpControllerImp.email,
                                  labelText: "Email",
                                  prefixIcon: const Icon(Icons.email),
                                  valid: (val) {
                                    return validInput(val!, 5, 50, "email");
                                  },
                                ),
                              ),
                              SizedBox(
                                  height:
                                      Get.height * 0.02), // 2% of screen height
                              SizedBox(
                                // width: Get.width * 0.85, // 80% of screen width
                                // height: Get.height * 0.09,
                                child: CustomTextFormAuth(
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.phone,
                                  myController: signUpControllerImp.number,
                                  labelText: "Number",
                                  prefixIcon: const Icon(Icons.phone),
                                  valid: (val) {
                                    return validInput(val!, 9, 10, "phone");
                                  },
                                ),
                              ),
                              SizedBox(
                                  height:
                                      Get.height * 0.02), // 2% of screen height
                              SizedBox(
                                  // width: Get.width * 0.85, // 80% of screen width
                                  // height: Get.height * 0.09,
                                  child: CustomTextFormAuth(
                                obscureText: signUpControllerImp.isShowPassword,
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      signUpControllerImp.showPassword();
                                    },
                                    icon: Icon(
                                      signUpControllerImp.isShowPassword == true
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    )),
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                myController: signUpControllerImp.password,
                                labelText: "Password",
                                prefixIcon: const Icon(Icons.password),
                                valid: (val) {
                                  return validInput(val!, 6, 40, "password");
                                },
                              )),
                              SizedBox(
                                  height:
                                      Get.height * 0.01), // 3% of screen height
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              SizedBox(
                                  height:
                                      Get.height * 0.03), // 3% of screen height
                              CustomButtonLogin(
                                  buttonName: "Sign Up",
                                  onPressed: () {
                                    signUpControllerImp.signUp();
                                  }),
                              SizedBox(
                                  height:
                                      Get.height * 0.01), // 2% of screen height
                              // const CustomTextGoogleLogin(),
                              SizedBox(height: Get.height * 0.02),
                              Container(
                                color: Colors.lightBlueAccent,
                                child: CustomNavigatorBetweenAuthPages(
                                    onPressed: () {
                                      signUpControllerImp.goToLogin();
                                    },
                                    text: 'Already a member? Log in'),
                              ),
                              SizedBox(height: Get.height * 0.03),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    )));
  }
}
