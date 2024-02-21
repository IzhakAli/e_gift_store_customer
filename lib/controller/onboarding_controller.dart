import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:store/core/services/services.dart';

import '../core/constant/routes.dart';
import '../data/datasource/static/static.dart';

abstract class OnBoardingController extends GetxController {
  nextPage();
  skipOnBoarding();
}

class OnBoardingControllerImp extends OnBoardingController {
  final PageController pageController = PageController();
  int currentPage = 0;

  MyServices myServices = Get.find();

  @override
  void onInit() {
    pageController.addListener(() {
      currentPage = pageController.page!.round();
      update();
    });
    super.onInit();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  skipOnBoarding() {
    Get.offAllNamed(AppRoute.login);
    myServices.sharedPreferences.setString("step", "1");
  }

  @override
  void nextPage() {
    if (currentPage < onBoardingList.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offAllNamed(AppRoute.login);
      myServices.sharedPreferences.setString("step", "1");
    }
  }
}
