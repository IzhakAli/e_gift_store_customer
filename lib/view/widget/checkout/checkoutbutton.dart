import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/checkout/checkout_controller.dart';

import '../../../core/constant/color.dart';

class CheckoutButton extends GetView<CheckoutController> {
  const CheckoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColor.backGroundColor,
          backgroundColor: AppColor.primary, // Button text color
        ),
        child: const Text('Confirm Order'),
        onPressed: () {
          controller.checkout();
        },
      ),
    );
  }
}
