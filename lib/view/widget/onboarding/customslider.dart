import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/onboarding_controller.dart';

import '../../../data/datasource/static/static.dart';

class CustomSlider extends GetView<OnBoardingControllerImp> {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      itemCount: onBoardingList.length,
      pageSnapping: true,
      itemBuilder: (context, index) {
        return Column(
            children: [
              Text(
                onBoardingList[index].title!,
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Image.asset(
                onBoardingList[index].image!,
                width: 250,
                height: 280,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  onBoardingList[index].body!,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
      },
    );
  }
}

