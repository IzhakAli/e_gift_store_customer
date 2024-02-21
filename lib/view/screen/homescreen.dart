import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/core/constant/color.dart';

import '../../controller/home_screen_controller.dart';
import '../../core/constant/routes.dart';
import '../../core/functions/exit_app_alert.dart';
import '../widget/home/custombuttonappbarhome.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    return GetBuilder<HomeScreenControllerImp>(
        builder: (controller) => Scaffold(
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                Get.toNamed(AppRoute.cart);
              },
              backgroundColor: AppColor.primary,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0))),
              label: const Icon(
                Icons.shopping_cart_outlined,
                color: Colors.black,
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const CustomBottomAppBarHome(),
            body: WillPopScope(
                onWillPop: () async {
                  return await showExitDialog();
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    controller.listPage.elementAt(controller.currentpage),
                    Positioned(
                        right: Get.width *
                            0.00, // Adjust the multiplier to position the button as needed
                        bottom: Get.height * 0.05,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColor.primary,
                              borderRadius: BorderRadius.circular(20)),
                          child: IconButton(
                            onPressed: () {
                              Get.toNamed(AppRoute.ai_landingscreen);
                            },
                            icon: Icon(
                              Icons.smart_toy_outlined,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ))));
  }
}
