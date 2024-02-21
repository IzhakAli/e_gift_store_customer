import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/onboarding_controller.dart';
import 'package:store/core/constant/color.dart';
import 'package:store/view/widget/onboarding/custombutton.dart';
import 'package:store/view/widget/onboarding/customslider.dart';

import '../widget/onboarding/dotcontroller.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    OnBoardingControllerImp controllerImp = Get.put(OnBoardingControllerImp());
    return Scaffold(
      backgroundColor: AppColor.backGroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    controllerImp.skipOnBoarding();
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const Expanded(
                flex: 6,
                child: CustomSlider(),
              ),
              // const SizedBox(height: 20),
              const CustomDotControllerOnBoarding(),
              const CustomButtonOnBoarding()
            ],
          ),
        ),
      ),
    );
  }
}
