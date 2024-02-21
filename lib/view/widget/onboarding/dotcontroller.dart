import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/onboarding_controller.dart';

import '../../../core/constant/color.dart';
import '../../../data/datasource/static/static.dart';

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          onBoardingList.length,
              (indicator) => AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: controller.currentPage == indicator ? 24 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: controller.currentPage == indicator
                  ? AppColor.primary
                  : AppColor.grey.withOpacity(0.3),
            ),
          ),
        ),
      );
    },);
  }
}
