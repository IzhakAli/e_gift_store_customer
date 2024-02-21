import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/core/class/handlingdataview.dart';

import '../../controller/checkout/checkout_controller.dart';
import '../widget/checkout/checkoutbutton.dart';
import '../widget/checkout/deliveryoptionssection.dart';
import '../widget/checkout/ordersummarysection.dart';
import '../widget/checkout/paymentdetailssection.dart';
import '../widget/checkout/paymentmethodsection.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutController());
    return Scaffold(
        appBar: AppBar(
          title: const Text("Checkout"),
        ),
        body: GetBuilder<CheckoutController>(
          builder: (controller) => HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: SingleChildScrollView(
              child: Column(
                children: [
                  const DeliveryOptionsSection(),
                  const PaymentMethodSection(),
                  Obx(() => controller.showPaymentDetails.isTrue
                      ? const PaymentDetailsSection()
                      : const SizedBox
                          .shrink()), // Only show if eWallet is selected
                  const OrderSummarySection(),
                  const CheckoutButton(),
                ],
              ),
            ),
          ),
        ));
  }
}
