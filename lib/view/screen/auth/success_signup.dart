import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/view/widget/auth/custom_login_button.dart';

import '../../../controller/auth/success_signup_controller.dart';

class SuccessSignUp extends StatelessWidget {
  const SuccessSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    SuccessSignUpControllerImp controllerImp =
        Get.put(SuccessSignUpControllerImp());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Success"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Center(
                  child: Icon(
                    Icons.check_circle,
                    size: 150,
                    color: Colors.green,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(40),
                  child: Text(
                      "You Have Successfully verified your email, click the button below to login",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
                SizedBox(
                  height: Get.height * 0.26,
                ),
                CustomButtonLogin(
                  buttonName: "Proceed to Login",
                  onPressed: () {
                    controllerImp.goToLogin();
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
